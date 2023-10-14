import 'package:flutter/material.dart';
import 'package:todo_app/util/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final addNewTaskController;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.addNewTaskController,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: addNewTaskController,
              decoration: InputDecoration(hintText: "Add a new task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //  saveButton
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                ),
                const SizedBox(width: 4),
                //  cancelButton
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
