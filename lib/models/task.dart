class Task {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  const Task({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
  });
  Map<String, dynamic> toJson() => {
    'taskName': taskName,
    'taskDescription': taskDescription,
    'isHighPriority': isHighPriority,
  };
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json["taskName"],
      taskDescription: json["taskDescription"],
      isHighPriority: json["isHighPriority"]
      );
  }
}
