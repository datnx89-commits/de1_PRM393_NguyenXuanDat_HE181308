import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../models/task_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static DatabaseHelper get instance => _instance ??= DatabaseHelper._internal();

  final String dbName;
  Database? _database;

  DatabaseHelper._internal({this.dbName = 'tasks.db'});

  factory DatabaseHelper.forTest({String dbName = 'test_tasks.db'}) {
    return DatabaseHelper._internal(dbName: dbName);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final String path;
    if (kIsWeb) {
      path = filePath;
    } else {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }
      final dbPath = await getDatabasesPath();
      path = join(dbPath, filePath);
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        is_completed INTEGER NOT NULL DEFAULT 0,
        icon_name TEXT NOT NULL DEFAULT 'laptop'
      )
    ''');

    // Prepopulate initial tasks matching the exam screenshot
    final initialTasks = [
      {
        'title': 'Làm bài tập Flutter',
        'description': 'Hoàn thành trước thứ Sáu',
        'is_completed': 0,
        'icon_name': 'laptop',
      },
      {
        'title': 'Ôn tập Riverpod',
        'description': 'Xem lại bài giảng MVVM',
        'is_completed': 0,
        'icon_name': 'book',
      },
      {
        'title': 'Chuẩn bị bài thuyết trình',
        'description': 'Nhóm 4 - Chủ đề Firebase',
        'is_completed': 0,
        'icon_name': 'presentation',
      },
      {
        'title': 'Viết báo cáo môn học',
        'description': 'Nộp trên LMS',
        'is_completed': 0,
        'icon_name': 'document',
      },
    ];

    for (final task in initialTasks) {
      await db.insert('tasks', task);
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    final result = await db.query('tasks', orderBy: 'id ASC');
    return result.map((json) => TaskModel.fromMap(json)).toList();
  }

  Future<TaskModel?> getTaskById(int id) async {
    final db = await database;
    final result = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return TaskModel.fromMap(result.first);
    }
    return null;
  }

  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
