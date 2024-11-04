import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/toy.dart';

typedef ToyListAddedCallback = Function(String value, Faction faction, TextEditingController textController);

class ToyDialog extends StatefulWidget {
  const ToyDialog({
    super.key,
    required this.onListAdded,
  });

  final ToyListAddedCallback onListAdded;

  @override
  State<ToyDialog> createState() => _ToyDialogState();
}

class _ToyDialogState extends State<ToyDialog> {
  final TextEditingController _inputController = TextEditingController();
  Faction selectedFaction = Faction.a;

  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a New Toy'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(hintText: "Type toy name here"),
          ),
          const SizedBox(height: 12),
          DropdownButton<Faction>(
            value: selectedFaction,
            onChanged: (Faction? faction) {
              setState(() {
                selectedFaction = faction!;
              });
            },
            items: Faction.values.map<DropdownMenuItem<Faction>>((Faction faction) {
              return DropdownMenuItem<Faction>(
                value: faction,
                child: Text(faction.label),
              );
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      widget.onListAdded(value.text, selectedFaction, _inputController);
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
