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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        onTap: !completed 
          ? () {
            onListChanged(task, completed);
          }
          : null,
        onLongPress: !completed
          ? () {
            onDeleteTask(task);
          }
          : null,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            task.name,
            textAlign: TextAlign.left,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.rating != null) ...[
              const SizedBox(height: 8),
              Text(
                'Rating: ${task.rating}/5',
                textAlign: TextAlign.left,
              ),
            ],
            if (task.description != null && task.description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Description: ${task.description}',
                textAlign: TextAlign.left,
              ),
            ],
            if (task.wouldDoAgain != null) ...[
              const SizedBox(height: 8),
              Text(
                'Would do again: ${task.wouldDoAgain! ? "Yes" : "No"}',
                textAlign: TextAlign.left,
              ),
            ],
          ],
        ),
        trailing: completed ? const Icon(Icons.check_circle) : null,
      ),
    );
  }
}
