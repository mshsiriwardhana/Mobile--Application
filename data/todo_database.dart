import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List toDoList = [];
  //ref our box
  final _myBox = Hive.box('mybox');

//run this method if this is the first time openning this app
  void createInitialData(){
    toDoList = [];

  }
  // load data from database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");

  }
  //update the database
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);

  }




}