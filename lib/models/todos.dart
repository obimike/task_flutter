class Tasks {
  final int id;
  final String title;
  final bool isChecked;
  final String dateStamp;
  final String priority;

  const Tasks({
    required this.id,
    required this.title,
    required this.isChecked,
    required this.dateStamp,
    required this.priority,
  });

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Todos{id: $id, taskTitle: $title, isChecked: $isChecked, dateStamp: $dateStamp, priority: $priority}';
  }
}
