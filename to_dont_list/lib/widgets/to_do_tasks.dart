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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.80),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 206, 110, 209),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
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
          title: Text(
            task.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.rating != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < task.rating! ? Icons.star : Icons.star_border,
                      color: const Color.fromARGB(255, 247, 206, 84),
                      size: 16,
                    );
                  }),
                ),
              ],
              if (task.description != null && task.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                 Text(
                  '${task.description}',
                ),
              ],
              if (task.wouldDoAgain != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Would do again: ${task.wouldDoAgain! ? "Yes" : "No"}',
                ),
              ],
            ],
          ),
          trailing: completed
              ? const Icon(Icons.check_circle, color: Color.fromARGB(255, 240, 164, 221))
              : const Icon(Icons.circle_outlined, color: Colors.grey),
        ),
      ),
    );
  }
}
