// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/task.dart';
import 'package:to_dont_list/widgets/to_do_tasks.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Task> tasks = [const Task(name: "add more todos")];
  final _TaskSet = <Task>{};

  void _handleListChanged(Task task, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _TaskSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      tasks.remove(task);
      if (!completed) {
        print("Completing");
        _TaskSet.add(task);
        tasks.add(task);
      } else {
        print("Making Undone");
        _TaskSet.remove(task);
        tasks.insert(0, task);
      }
    });
  }

  void _handleDeleteTask(Task task) {
    setState(() {
      print("Deleting Task");
      tasks.remove(task);
    });
  }

  void _handleNewTask(String taskText, TextEditingController textController) {
    setState(() {
      print("Adding new Task");
      Task task = Task(name: taskText);
      tasks.insert(0, task);
      textController.clear();
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Something New'),
    ),
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      children: [
        const Text('To-do'),
        Column(
          children: tasks.map((task) {
            if (!_TaskSet.contains(task)) {
              return ToDoListTask(
                task: task,
                completed: false,
                onListChanged: _handleListChanged,
                onDeleteTask: _handleDeleteTask,
              );
            } else {
              return Container();
            }
          }).toList(),
        ),
        const Text('Done'),
        Column(
          children: tasks.map((task) {
            if (_TaskSet.contains(task)) {
              return ToDoListTask(
                task: task,
                completed: true,
                onListChanged: _handleListChanged,
                onDeleteTask: _handleDeleteTask,
              );
            } else {
              return Container();
            }
          }).toList(),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return ToDoDialog(onListAdded: _handleNewTask);
          },
        );
      },
    ),
  );
}

  }

void main() {
  runApp(MaterialApp(
    title: 'To Do List',
    theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 248, 178, 3))),
    home: const ToDoList(),
  ));
}
