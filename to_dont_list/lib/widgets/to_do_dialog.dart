import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    String value, TextEditingController textController);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  final TextEditingController _inputController = TextEditingController();
  String _valueText = '';

  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a New Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(labelText: 'Task name'),
            onChanged: (value) {
              setState(() {
                _valueText = value;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          style: yesStyle,
          onPressed: _valueText.isNotEmpty
              ? () {
                  widget.onListAdded(_valueText, _inputController);
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Add'),
        ),
        ElevatedButton(
          style: noStyle,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
