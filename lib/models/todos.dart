class Todos {
  final int id;
  final String taskTitle;
  final bool isChecked;
  final String dateStamp;
  final String priority;

  const Todos({
    required this.id,
    required this.taskTitle,
    required this.isChecked,
    required this.dateStamp,
    required this.priority,
  });
}
