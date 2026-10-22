import 'package:test/test.dart';

import '../lib/service/lms_system.dart';

void main() {
  group('Student', () {
    test('creates a student', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      expect(lms.students, hasLength(1));
      expect(lms.students.single.id, 'S1');
      expect(lms.students.single.name, 'Ronan');
    });

    test('removes a student', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.removeStudent(studentId: 'S1');
      expect(lms.students, isEmpty);
    });

    test('rejects a duplicate student ID', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      expect(() => lms.addStudent(studentId: 'S1', studentName: 'Mina'), throwsException);
      expect(lms.students, hasLength(1));
      expect(lms.students.single.name, 'Ronan');
    });

    test('rejects removal of a nonexistent student', () {
      final lms = LmsSystem();
      expect(() => lms.removeStudent(studentId: 'S1'), throwsException);
      expect(lms.students, isEmpty);
    });

    test(
        'removing a student clears enrollments and results in multiple courses',
        () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addStudent(studentId: 'S2', studentName: 'Mina');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addCourse(courseId: 'C2', courseName: 'Backend Development');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.addAssignmentToCourse(courseId: 'C2', assignmentId: 'A2', assignmentName: 'Layered Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.enrollStudent(studentId: 'S1', courseId: 'C2');
      lms.enrollStudent(studentId: 'S2', courseId: 'C1');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80);
      lms.addResult(studentId: 'S1', courseId: 'C2', assignmentId: 'A2', score: 90);
      lms.addResult(studentId: 'S2', courseId: 'C1', assignmentId: 'A1', score: 70);
      lms.removeStudent(studentId: 'S1');
      expect(lms.students.map((student) => student.id), ['S2']);
      expect(lms.courses[0].studentIds, ['S2']);
      expect(lms.courses[1].studentIds, isEmpty);
      expect(lms.results, hasLength(1));
      expect(lms.results.single.studentId, 'S2');
    });
  });

  group('Course', () {
    test('adds and removes a course', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      expect(lms.courses.single.id, 'C1');
      expect(lms.courses.single.name, 'Mobile Architecture');
      lms.removeCourse(courseId: 'C1');
      expect(lms.courses, isEmpty);
    });

    test('rejects a duplicate course ID', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      expect(() => lms.addCourse(courseId: 'C1', courseName: 'Backend Development'), throwsException);
      expect(lms.courses, hasLength(1));
      expect(lms.courses.single.name, 'Mobile Architecture');
    });

    test('rejects removal of a nonexistent course', () {
      final lms = LmsSystem();
      expect(() => lms.removeCourse(courseId: 'C1'), throwsException);
      expect(lms.courses, isEmpty);
    });

    test('removing a course clears its assignments and results', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addCourse(courseId: 'C2', courseName: 'Backend Development');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.addAssignmentToCourse(courseId: 'C2', assignmentId: 'A2', assignmentName: 'Layered Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.enrollStudent(studentId: 'S1', courseId: 'C2');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80);
      lms.addResult(studentId: 'S1', courseId: 'C2', assignmentId: 'A2', score: 90);
      lms.removeCourse(courseId: 'C1');
      expect(lms.courses.single.id, 'C2');
      expect(lms.assignments.map((assignment) => assignment.id), ['A2']);
      expect(lms.results.single.assignmentId, 'A2');
      expect(lms.students.single.id, 'S1');
    });
  });

  group('Enrollment', () {
    test('enrolls an existing student in an existing course', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      expect(lms.courses.single.studentIds, ['S1']);
    });

    test('rejects enrollment of a nonexistent student', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      expect(() => lms.enrollStudent(studentId: 'S1', courseId: 'C1'), throwsException);
      expect(lms.courses.single.studentIds, isEmpty);
    });

    test('rejects enrollment in a nonexistent course', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      expect(() => lms.enrollStudent(studentId: 'S1', courseId: 'C1'), throwsException);
      expect(lms.students, hasLength(1));
    });

    test('rejects duplicate enrollment', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      expect(() => lms.enrollStudent(studentId: 'S1', courseId: 'C1'),throwsException);
      expect(lms.courses.single.studentIds, ['S1']);
    });

    test('removes an enrollment but keeps the student and course', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.discardStudentFromCourse(studentId: 'S1', courseId: 'C1');
      expect(lms.courses.single.studentIds, isEmpty);
      expect(lms.students.single.id, 'S1');
      expect(lms.courses.single.id, 'C1');
    });

    test('rejects removal of a nonexistent enrollment', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      expect(() => lms.discardStudentFromCourse(studentId: 'S1', courseId: 'C1'), throwsException);
      expect(lms.courses.single.studentIds, isEmpty);
    });

    test('removing an enrollment deletes only its course results', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addCourse(courseId: 'C2', courseName: 'Backend Development');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.addAssignmentToCourse(courseId: 'C2', assignmentId: 'A2', assignmentName: 'Layered Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.enrollStudent(studentId: 'S1', courseId: 'C2');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80);
      lms.addResult(studentId: 'S1', courseId: 'C2', assignmentId: 'A2', score: 90);
      lms.discardStudentFromCourse(studentId: 'S1', courseId: 'C1');
      expect(lms.results, hasLength(1));
      expect(lms.results.single.courseId, 'C2');
      expect(lms.courses[0].studentIds, isEmpty);
      expect(lms.courses[1].studentIds, ['S1']);
    });
  });

  group('Assignment', () {
    test('adds an assignment to an existing course', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      expect(lms.assignments.single.id, 'A1');
      expect(lms.assignments.single.title, 'OOP');
      expect(lms.courses.single.assignmentIds, ['A1']);
    });

    test('rejects an assignment for a nonexistent course', () {
      final lms = LmsSystem();
      expect(() => lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP'), throwsException);
      expect(lms.assignments, isEmpty);
    });

    test('rejects a duplicate assignment ID even in another course', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Development');
      lms.addCourse(courseId: 'C2', courseName: 'Backend Development');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      expect(() => lms.addAssignmentToCourse(courseId: 'C2', assignmentId: 'A1', assignmentName: 'Layered Architecture'),  throwsException);
      expect(lms.assignments, hasLength(1));
      expect(lms.courses[1].assignmentIds, isEmpty);
    });

    test('removes an assignment from its course', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.removeAssignmentFromCourse(assignmentId: 'A1', courseId: 'C1');
      expect(lms.assignments, isEmpty);
      expect(lms.courses.single.assignmentIds, isEmpty);
      expect(lms.courses.single.id, 'C1');
    });

    test('rejects removal of an assignment absent from the course', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addCourse(courseId: 'C2', courseName: 'Backend Development');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      expect(() => lms.removeAssignmentFromCourse(assignmentId: 'A1', courseId: 'C2'), throwsException);
      expect(lms.assignments.single.id, 'A1');
      expect(lms.courses[0].assignmentIds, ['A1']);
    });

    test(
        'removing an assignment deletes its results but keeps unrelated results',
        () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A2', assignmentName: 'Layered Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.addResult(
          studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80);
      lms.addResult(
          studentId: 'S1', courseId: 'C1', assignmentId: 'A2', score: 90);
      lms.removeAssignmentFromCourse(assignmentId: 'A1', courseId: 'C1');
      expect(lms.assignments.map((assignment) => assignment.id), ['A2']);
      expect(lms.courses.single.assignmentIds, ['A2']);
      expect(lms.results, hasLength(1));
      expect(lms.results.single.assignmentId, 'A2');
      expect(lms.results.single.score, 90);
    });
  });

  group('Result', () {
    test('adds a valid result for an enrolled student and course assignment', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 85.5);
      expect(lms.results, hasLength(1));
      expect(lms.results.single.studentId, 'S1');
      expect(lms.results.single.courseId, 'C1');
      expect(lms.results.single.assignmentId, 'A1');
      expect(lms.results.single.score, 85.5);
    });

    test('rejects a result for a nonexistent student', () {
      final lms = LmsSystem();
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      expect(() => lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80), throwsException);
      expect(lms.results, isEmpty);
    });

    test('rejects a result for a nonexistent course', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      expect(() => lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80), throwsException);
      expect(lms.results, isEmpty);
    });

    test('rejects a result for a student not enrolled in the course', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      expect(() => lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80), throwsException);
      expect(lms.results, isEmpty);
    });

    test('rejects a result for an assignment outside the course', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addCourse(courseId: 'C2', courseName: 'Backend Development');
      lms.addAssignmentToCourse(courseId: 'C2', assignmentId: 'A1', assignmentName: 'OOP');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      expect(() => lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80), throwsException);
      expect(lms.results, isEmpty);
    });

    test('accepts boundary scores of 0 and 100', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A2', assignmentName: 'Layered Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 0);
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A2', score: 100);
      expect(lms.results.map((result) => result.score), [0, 100]);
    });

    test('rejects scores outside 0 to 100 and non-finite scores', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      for (final score in [-0.1, 100.1, double.nan, double.infinity, double.negativeInfinity]) {
        expect(() => lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: score), throwsException);
      }
      expect(lms.results, isEmpty);
    });

    test('rejects a duplicate result for the same student and assignment', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80);
      expect(() => lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 90), throwsException);
      expect(lms.results, hasLength(1));
      expect(lms.results.single.score, 80);
    });

    test('removes an existing result and makes it unavailable', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80);
      lms.removeResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1');
      expect(lms.results, isEmpty);
      expect(() => lms.removeResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1'), throwsException);
    });

    test('rejects removal of a nonexistent result', () {
      final lms = LmsSystem();
      expect(() => lms.removeResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1'), throwsException);
      expect(lms.results, isEmpty);
    });

    test('removing a result preserves its student, course, and other results', () {
      final lms = LmsSystem();
      lms.addStudent(studentId: 'S1', studentName: 'Ronan');
      lms.addCourse(courseId: 'C1', courseName: 'Mobile Architecture');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A1', assignmentName: 'OOP');
      lms.addAssignmentToCourse(courseId: 'C1', assignmentId: 'A2', assignmentName: 'Layered Architecture');
      lms.enrollStudent(studentId: 'S1', courseId: 'C1');
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1', score: 80);
      lms.addResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A2', score: 90);
      lms.removeResult(studentId: 'S1', courseId: 'C1', assignmentId: 'A1');
      expect(lms.results, hasLength(1));
      expect(lms.results.single.assignmentId, 'A2');
      expect(lms.results.single.score, 90);
      expect(lms.students.single.id, 'S1');
      expect(lms.courses.single.id, 'C1');
      expect(lms.courses.single.studentIds, ['S1']);
      expect(lms.assignments, hasLength(2));
    });
  });
}