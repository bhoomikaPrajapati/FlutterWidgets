import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:first_app/note_app/model/note.dart';
import 'package:first_app/note_app/utils/Const.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    return _databaseHelper ??= DatabaseHelper._createInstance();
  }

  Future<Database> get database async {
    return _database ??= await initializeDatabase();
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $NOTE_TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT,$TITLE TEXT,$DESCRIPTION TEXT,$PRIORITY INTEGER,$DATE TEXT)");
  }

  /* void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $NOTE_TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT, $TITLE TEXT, '
        '$DESCRIPTION TEXT, $PRIORITY INTEGER, $DATE TEXT)');
  }*/

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(NOTE_TABLE, orderBy: '$PRIORITY ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {

    Database db = await this.database;
    debugPrint("Db Note--${note.toMap()}");
    var result = await db.insert(NOTE_TABLE, note.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(NOTE_TABLE, note.toMap(), where: '$ID = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $NOTE_TABLE WHERE $ID = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $NOTE_TABLE');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length; // Count the number of map entries in db table

    List<Note> noteList = <Note>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}
