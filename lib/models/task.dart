class Task {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone = false;
  Task({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });
  Map<String, dynamic> toJson() => {
    'taskName': taskName,
    'taskDescription': taskDescription,
    'isHighPriority': isHighPriority,
    'isDone' : isDone,
  };
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json["taskName"],
      taskDescription: json["taskDescription"],
      isHighPriority: json["isHighPriority"],
      isDone: json["isDone"] ?? false
    );
  }
}
