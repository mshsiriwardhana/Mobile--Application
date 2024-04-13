import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/Calculator/calculator.dart';
import 'package:todolist/Qr/qr_main.dart';
import 'package:todolist/calender%20screens/calender_screen.dart';
import 'package:todolist/home/dashboard.dart';
import 'package:todolist/pages/todo_home_page.dart';
import 'package:todolist/unit%20converter/uni_converter.dart';
import 'package:todolist/widgets_notepad.dart/note_home_screen.dart';

void main() async {
  //ini the hive
  await Hive.initFlutter();

  // open a box
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/calendar': (context) => CalendarScreen(),
        '/calculator': (context) => const Calculator(),
        '/notepad': (context) => const HomeScreen(),
        '/todo': (context) => const HomePageToDo(),
        '/qr_scanner': (context) => const QrMain(),
        //'/expense': (context) => MainApp(),
        '/unit_converter': (context) => const UnitConverter(),
      },
      home: Dashboards(),

      debugShowCheckedModeBanner: false,
      //home: const HomePageToDo(),
      theme: ThemeData(primaryColor: Color.fromARGB(255, 255, 233, 250)),
    );
  }
}
