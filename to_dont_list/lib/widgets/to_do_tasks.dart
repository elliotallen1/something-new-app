import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/task.dart';

typedef ToDoListChangedCallback = void Function(Task task, bool completed);
typedef ToDoListRemovedCallback = void Function(Task task);

class ToDoListTask extends StatelessWidget {
  const ToDoListTask({
    super.key,
    required this.task,
    required this.completed,
    required this.onListChanged,
    required this.onDeleteTask,
  });

  final Task task;
  final bool completed;
  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteTask;

  Color _getColor(BuildContext context) {
    return completed ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(task, completed);
      },
      onLongPress: completed
          ? () {
              onDeleteTask(task);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(
          task.abbrev(),
          style: _getTextStyle(context),
        ),
      ),
      title: Text(
        task.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
