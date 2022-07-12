import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/User.dart';

class RegDatabase {
  static final RegDatabase instance = RegDatabase._init();

  static Database? _database;

  RegDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('easyreg.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $easyreg ( 
  ${Registration.id} $idType, 
   ${Registration.age} $textType,
      ${Registration.name} $textType,
         ${Registration.gender} $textType,
            ${Registration.church} $textType,
             ${Registration.churchCity} $textType,
             ${Registration.churchState} $textType,
              ${Registration.time} $textType
  )
''');
  }

  Future<UserModels> create(UserModels userModel) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(easyreg, userModel.toJson());
    log('INSERTED===>$id');
    return userModel.copyWith(id: id);
  }

  Future<UserModels> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      easyreg,
      columns: Registration.values,
      where: '${Registration.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserModels.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${Registration.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(easyreg, orderBy: orderBy);

    return result.map((json) => UserModels.fromJson(json)).toList();
  }

  Future<int> update(UserModels userModel) async {
    final db = await instance.database;

    return db.update(
      easyreg,
      userModel.toJson(),
      where: '${Registration.id} = ?',
      whereArgs: [userModel.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      easyreg,
      where: '${Registration.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
