import 'package:flutter/material.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //TODO  @SimbaStart:  list of todo tasks
  List todos = [
    ["Create ToDo App", false],
    ["Do Exercises", false]
  ];

  void _checkBoxChanged(bool? value, index) {
    setState(() {
      todos[index][1] = !todos[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todos[index][0],
            taskCompleted: todos[index][1],
            onChanged: (value) => _checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
