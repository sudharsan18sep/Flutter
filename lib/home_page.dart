import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/util/dailog_box.dart';
import 'package:todoapp/util/todo_tile.dart';

import 'data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createintialData();
    } else {
      //already exist
      db.loadData();
    }
  }

  final _controller = TextEditingController();

  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updateData();
  }

  //save new task
  void savenewtask() {
    setState(() {
      db.todolist.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void createnewtask() {
    showDialog(
        context: context,
        builder: (context) {
          return Dailogbox(
            controller: _controller,
            onsave: savenewtask,
            oncancel: () => Navigator.of(context).pop(),
          );
        },
        );
       
  }
  // delte task

  void deleteTask(int index) {
    setState(() {
      db.todolist.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 220, 1),
      appBar: AppBar(
        title: const Text(
          'Todo',
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewtask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.todolist.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskname: db.todolist[index][0],
              taskcompleted: db.todolist[index][1],
              onChanged: (value) => checkboxchanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
