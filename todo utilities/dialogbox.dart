import 'package:flutter/material.dart';
import 'package:todolist/todo%20utilities/mybutton.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 250, 216, 249),
      // ignore: sized_box_for_whitespace
      content: Container(
        height: 130,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          //getuser input
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task",
            ),
          ),
          //buttons-save cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //save
              MyButton(text: "Save", onPressed: onSave),

              const SizedBox(width: 15),

              //cancel
              MyButton(text: "Cancel", onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
