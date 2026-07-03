import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class TasksListWidget extends StatelessWidget {
  TasksListWidget({super.key, required this.task, required this.onTaskChanged});
  List<Task> task;
  final Function(bool?,int?) onTaskChanged;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: task.length,
      padding: EdgeInsets.only(bottom: 24),
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              // padding: EdgeInsets.only(top: 8),
              alignment: Alignment.center,
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFF282828),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    activeColor: Color(0xFF15B86C),
                    checkColor: Color(0xFFFFFCFC),
                    value: task[index].isDone,
                    onChanged: (bool? value) async {
                      await onTaskChanged(value,index);
                    },
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${task[index].taskName}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            decoration: task[index].isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 16,
                            color: task[index].isDone
                                ? Color(0xFFC6C6C6)
                                : Color(0xFFFFFCFC),
                          ),
                          maxLines: 1,
                        ),
                        Text(
                          '${task[index].taskDescription}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFC6C6C6),
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.start,

                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_vert),
                    color: task[index].isDone
                        ? Color(0xFFC6C6C6)
                        : Color(0xFFFFFCFC),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
