import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/todo_database.dart';
import 'package:todolist/todo%20utilities/dialogbox.dart';
import 'package:todolist/todo%20utilities/todo_tile.dart';

class HomePageToDo extends StatefulWidget {
  const HomePageToDo({super.key});

  @override
  State<HomePageToDo> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageToDo> {
  //ref the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is the first thime ever opennig the app, then create defauld data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exist data
      db.loadData();
    }

    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //check box was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 196, 219),
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('MY TO DO LIST'),
        backgroundColor: Color.fromARGB(255, 255, 231, 243),
        elevation: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
            );
          }),
    );
  }
}
