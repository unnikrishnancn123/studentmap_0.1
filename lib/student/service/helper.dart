import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../model/studentmodel.dart';

const studentTable = 'Student';

class Helper {
  static late Database _db;
  static final Helper instance = Helper._init();

  Helper._init();

  Future<Database> get db async {
    _db = await createDatabase();
    return _db;
  }

  Future<Database> createDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'student.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onUpgrade: onUpgrade);
    return db;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {
      // Perform necessary database upgrade tasks here
    }
  }

  void _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT, email TEXT, phone TEXT, district TEXT, gender TEXT, dob TEXT, data TEXT, crtloc TEXT)');
    stderr.writeln('print me');
  }


  Future<Student> addStudent(Student student) async {
    try {
      var dbClient = await db;
      var studentId = await dbClient.insert(studentTable, student.toMap());
      student.id = studentId;
      return student;
    } catch (e) {
      rethrow; // Re-throw the exception to propagate it further if necessary
    }
  }

  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(studentTable);
    List<Student> students = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        students.add(Student.fromMap(maps[i]));
      }
    }
    return students;
  }

  Future<int> deleteStudent(int id) async {
    var dbClient = await db;
    return await dbClient.delete(studentTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateStudent(Student student) async {
    var dbClient = await db;
    return await dbClient.update(studentTable, student.toMap(), where: 'id = ?', whereArgs: [student.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  Future<Student?> getStudent(int id) async {
    var dbClient = await db;
    var result = await dbClient.query(studentTable, where: 'id = ?', whereArgs: [id]);
    List<Student> students = result.isNotEmpty ? result.map((map) => Student.fromMap(map)).toList() : [];
    return students.isNotEmpty ? students[0] : null;
  }
}
