import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/task.dart';

typedef ToDoListChangedCallback = Function(Task task, bool completed);
typedef ToDoListRemovedCallback = Function(Task task);

class ToDoListTask extends StatelessWidget {
  ToDoListTask(required Type task, 
      {required this.name,
      required this.completed,
      required this.onListChanged,
      required this.onDeleteTask})
      : super(key: ObjectKey(task));

  final Task task;
  final bool completed;

  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteTask;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return completed //
        ? Colors.black54
        : Theme.of(context).primaryColor;
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
      title: Text(task.name)
    );
  }
}
