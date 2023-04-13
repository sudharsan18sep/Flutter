import 'package:flutter/material.dart';
import 'package:todoapp/util/my_button.dart';

class Dailogbox extends StatelessWidget {
  final controller;
  VoidCallback onsave;
  VoidCallback oncancel;
  Dailogbox(
      {super.key,
      required this.controller,
      required this.onsave,
      required this.oncancel});

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
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add new Task",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save buttun
                Buttons(text: "Save", onPressed: onsave),
                const SizedBox(
                  width: 6,
                ),
                //cancel button
                Buttons(text: "Cancel", onPressed: oncancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
