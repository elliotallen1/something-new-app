import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/task.dart';

typedef TaskDetailsSaveCallback = Function(int rating, String description, bool wouldDoAgain);
typedef TaskDetailsCancelCallback = Function(Task task);

class TaskDialog extends StatefulWidget {
  const TaskDialog({
    super.key,
    required this.task,
    required this.onSave,
  });

  final Task task;
  final TaskDetailsSaveCallback onSave;
  

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
      title: Text(widget.task.name),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('0-5 What would you give it?'),
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
            decoration: const InputDecoration(labelText: 'How was it?'),
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Would you do it again?'),
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
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
