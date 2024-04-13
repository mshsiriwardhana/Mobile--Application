import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolist/calender%20screens/event.dart';

class EventDatabase {
  static final EventDatabase instance = EventDatabase._init();
  static late Database _database; // late modifier for _database

  EventDatabase._init();

  Future<Database> get database async {
    if (_database.isOpen) return _database; // Check if database is open

    _database = await _initDB('events.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE events(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        date TEXT,
        description TEXT
      )
    ''');
  }

  Future<List<Event>> getAllEvents() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('events');
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'],
        title: maps[i]['title'],
        date: DateTime.parse(maps[i]['date']),
        description: maps[i]['description'],
      );
    });
  }

  Future<Event> addEvent(Event event) async {
    final db = await instance.database;
    event.id = await db.insert('events', event.toMap());
    return event;
  }

  Future<int> updateEvent(Event event) async {
    final db = await instance.database;
    return await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(int id) async {
    final db = await instance.database;
    return await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
