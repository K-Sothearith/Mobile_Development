class Course {
  final String id;
  final String name;
  final List<String> studentIds = [];
  final List<String> assignmentIds = [];

  Course({required this.id, required this.name});

  void addStudentId(String studentId) => studentIds.add(studentId);
  void removeStudentId (String studentId) => studentIds.remove(studentId);

  void addAssignmentId(String assignmentId) => assignmentIds.add(assignmentId);
  void removeAssignmentId(String assignmentId) => assignmentIds.remove(assignmentId);
}
