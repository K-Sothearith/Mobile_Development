import '../model/student.dart';
import '../model/course.dart';
import '../model/course_result.dart';
import '../model/assignment.dart';

class LmsSystem {
  final List<Student> _students = [];
  final List<Course> _courses = [];
  final List<Result> _results = [];
  final List<Assignment> _assignments = [];

  List<Student> get students => List.unmodifiable(_students);
  List<Course> get courses => List.unmodifiable(_courses);
  List<Result> get results => List.unmodifiable(_results);
  List<Assignment> get assignments => List.unmodifiable(_assignments);
 
  void addStudent({required String studentId, required String studentName}) {
    // ! Student shall not exist already
    Student? student = _findStudentOrNull(studentId);
    if (student != null) {
      throw Exception('Student $student already exists');
    }

    _students.add(Student(id: studentId, name: studentName));
  }
 
  void removeStudent({required String studentId}) {
    Student? student = _findStudentOrNull(studentId);
    if (student == null) {
      throw Exception('Student \'$studentId\' not found');
    }
    // 1- Remove student from the students list
    _students.removeWhere((student) => student.id == studentId);
    // 2- Remove studentId from studentIDs list in Course
    for (var course in _courses) {
      course.removeStudentId(studentId);
    }
    // 3- Remove student from results
    _results.removeWhere((result) => result.studentId == studentId);
  }

  Student? _findStudentOrNull(String studentId) {
    for (Student s in _students) {
      if (s.id == studentId) {
        return s;
      }
    }
    return null; // not found
  }

  Course? _findCourseOrNull(String courseId) {
    for (Course c in _courses) {
      if (c.id == courseId) {
        return c;
      }
    }
    return null;
  }

  Assignment? _findAssignmentOrNull(String assignmentId) {
    for (final assignment in _assignments) {
      if (assignment.id == assignmentId) return assignment;
    }
    return null;
  }

  Result? _findResultOrNull(String studentId, String courseId, String assignmentId) {
    for (Result result in _results) {
      if (result.studentId == studentId && result.courseId == courseId && result.assignmentId == assignmentId) {
        return result;
      }
    }
    return null;
  }

  Student _nonNullStudent(String studentId) {
    final student = _findStudentOrNull(studentId);
    if (student == null) throw Exception ('Student with the ID \'$studentId\' not found');
    return student;
  }

  Course _nonNullCourse(String courseId) {
    final course = _findCourseOrNull(courseId);
    if (course == null) throw Exception ('Course \'$courseId\' not found');
    return course;
  }

  Result _nonNullResult(String studentId, String courseId, String assignmentId) {
    final result = _findResultOrNull(studentId, courseId, assignmentId);
    if (result == null) {
      throw Exception ('Result for student \'$studentId\' on assignment \'$assignmentId\'in course \'$courseId\ not found');
    }
    return result;
  }

  void addCourse({required String courseId, required String courseName}) {
    if (_findCourseOrNull(courseId) != null) {
      throw Exception ('Course with the ID \'$courseId\' already exists');
    }
    _courses.add(Course(id: courseId, name: courseName));
  }

  void removeCourse({required String courseId}) {
    Course courseToBeRemoved = _nonNullCourse(courseId);
    _results.removeWhere((result) => result.courseId == courseId);
    _assignments.removeWhere((assignment) => courseToBeRemoved.assignmentIds.contains(assignment.id));
    _courses.remove(courseToBeRemoved);
  }

  void enrollStudent({required String studentId, required String courseId}) {
    _nonNullStudent(studentId);
    Course courseToBeEnrolled = _nonNullCourse(courseId);
    if (courseToBeEnrolled.studentIds.contains(studentId)) {
      throw Exception ('Student \'$studentId\' is already enrolled in course \'$courseId\'');
    }
    courseToBeEnrolled.addStudentId(studentId);
  }

  void discardStudentFromCourse({required String studentId, required String courseId}) {
    _nonNullStudent(studentId);
    Course courseToRemove = _nonNullCourse(courseId);
    if (!courseToRemove.studentIds.contains(studentId)) {
      throw Exception ('Student \'$studentId\' is not enrolled in course \'$courseId\'');
    }
    _results.removeWhere((result) => result.studentId == studentId && result.courseId == courseId);
    courseToRemove.studentIds.remove(studentId);
  }

  void addResult({required String studentId, required String courseId, required String assignmentId, required double score}) {
    _nonNullStudent(studentId);
    Course enrolledCourse = _nonNullCourse(courseId);
    if (!enrolledCourse.studentIds.contains(studentId)) {
      throw Exception('Student \'$studentId\' is not enrolled in course \'$courseId\'');
    }
    if (!enrolledCourse.assignmentIds.contains(assignmentId)) {
      throw Exception ('Assignment \'$assignmentId\' not found in course \'$courseId\'');
    }
    if (!score.isFinite || score < 0 || score > 100) {
      throw Exception('Score must be finite and between 0 and 100');
    }
    if (_findResultOrNull(studentId, courseId, assignmentId) != null) {
      throw Exception('Result for student \'$studentId\' on assignment \'$assignmentId\' in course \'$courseId\' already exists');
    }
    _results.add(Result(studentId: studentId, courseId: courseId, assignmentId: assignmentId, score: score));
  }

  void removeResult({required String studentId, required String courseId, required String assignmentId}) {
    Result resultToBeRemoved = _nonNullResult(studentId, courseId, assignmentId);
    _results.remove(resultToBeRemoved);
  }

  void addAssignmentToCourse({required String courseId, required String assignmentId, required String assignmentName}) {
    final course = _nonNullCourse(courseId);
    if (_findAssignmentOrNull(assignmentId) != null) {
      throw Exception('Assignment \'$assignmentId\' already exists');
    }
    _assignments.add(Assignment(id: assignmentId, title: assignmentName));
    course.addAssignmentId(assignmentId);
  }

  void removeAssignmentFromCourse({required String assignmentId, required String courseId}) {
    final course = _nonNullCourse(courseId);
    if (!course.assignmentIds.contains(assignmentId)) {
      throw Exception('Assignment \'$assignmentId\' not found in course \'$courseId\'');
    }
    course.removeAssignmentId(assignmentId);
    _assignments.removeWhere((assignment) => assignment.id == assignmentId);
    _results.removeWhere((result) => result.assignmentId == assignmentId);
  }
}
