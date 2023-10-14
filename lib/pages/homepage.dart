import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the box
  //TODO  @SimbaStart:  list of todo tasks
  ToDoDatabase db = ToDoDatabase();
  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    // TODO: implement initState

    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void _checkBoxChanged(bool? value, index) {
    setState(() {
      // setting checkbox to true / false, setting it to the opposite of whats already there
      db.toDoList[index][1] = !db.toDoList[index][1];
      db.updateDatabase();
    });
  }

  void deleteTask(index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  final _addNewTaskController = TextEditingController();

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_addNewTaskController.text, false]);
      _addNewTaskController.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void _createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          addNewTaskController: _addNewTaskController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => _checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
