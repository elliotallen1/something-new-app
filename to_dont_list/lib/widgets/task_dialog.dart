import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/task.dart';

typedef TaskDetailsSaveCallback = Function(int rating, String description, bool wouldDoAgain);
typedef TaskDetailsCancelCallback = Function(Task task);

class TaskDialog extends StatefulWidget {
  const TaskDialog({
    super.key,
    required this.task,
    required this.onSave,
    required this.onCancel,
  });

  final Task task;
  final TaskDetailsSaveCallback onSave;
  
  final TaskDetailsCancelCallback onCancel;

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  int _rating = 0;
  String _description = '';
  bool _wouldDoAgain = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('How was ${widget.task.name}?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Rate this task:'),
          Slider(
            value: _rating.toDouble(),
            min: 0,
            max: 5,
            divisions: 5,
            label: '$_rating',
            onChanged: (value) {
              setState(() {
                _rating = value.toInt();
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Describe the task'),
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Would you do this task again?'),
            value: _wouldDoAgain,
            onChanged: (value) {
              setState(() {
                _wouldDoAgain = value ?? false;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            widget.onSave(_rating, _description, _wouldDoAgain);
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onCancel(widget.task);
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
