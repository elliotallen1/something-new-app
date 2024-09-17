import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/task.dart';
import 'package:to_dont_list/widgets/task_dialog.dart';
import 'package:to_dont_list/widgets/to_do_tasks.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Task> tasks = [const Task(name: "add something new you want to do!")];
  final _TaskSet = <Task>{};

  void _handleListChanged(Task task, bool completed) {
    setState(() {
      tasks.remove(task);
      if (!completed) {
        showDialog(
          context: context,
          builder: (_) {
            return TaskDialog(
              task: task,
              onSave: (rating, description, wouldDoAgain) {
                // Update task with new details
                Task updatedTask = task.update(
                  rating: rating,
                  description: description,
                  wouldDoAgain: wouldDoAgain,
                );
                setState(() {
                  _TaskSet.add(updatedTask);
                  tasks.add(updatedTask);
                });
              },
              onCancel: (task) {
                setState(() {
                  tasks.add(task);
                });
              },
            );
          },
        );
      } else {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Try something new?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
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
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Look what you did!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
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
      ),
      floatingActionButton: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: FloatingActionButton.extended( 
      onPressed: () {
      showDialog(
        context: context,
        builder: (_) {
          return ToDoDialog(onListAdded: _handleNewTask);
          },
          );
          },
          label: const Text('Wanna do something new?'),),
),);
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Something New',
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 234, 19, 220), brightness: Brightness.dark, contrastLevel: 1)),
    home: const ToDoList(),
  ));
}
