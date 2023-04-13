import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todolist = [];
  //reference to the box
  final _myBox = Hive.box('mybox');

  //create initail data sample task
  void createintialData() {
    todolist = [
      ["Task1", false],
    ];
  }

  //load data from local
  void loadData() {
    todolist = _myBox.get("TODOLIST");
  }

  //update data

  void updateData() {
    _myBox.put("TODOLIST", todolist);
  }
}
