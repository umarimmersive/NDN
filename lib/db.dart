
import 'package:flutter/cupertino.dart';
import 'package:national_digital_notes_new/app/modules/Test/views/Question.dart';
import 'package:national_digital_notes_new/models/Questions_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SqliteService{

  static String databaseName = "Ndn_database";
  static Database? db;

  SqliteService._privateConstructor();
  static SqliteService instance = SqliteService._privateConstructor();

  Future<Database?> get database async {
    if (db != null) return db;
    // lazily instantiate the db the first time it is accessed
    db = await initizateDb();
    return db;
  }

  static Future<Database> initizateDb() async{
    print('------------------print1');
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return db?? await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          print('------------------print2');
          await createTables(db);
        });

  }

  static Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);

  static Future<void> createTables(Database database) async{


    await database.execute(
      'CREATE TABLE Questions(id INTEGER PRIMARY KEY, question TEXT, answerIndex STRING, options STRING, user_answer STRING, type STRING, question_hindi STRING, options_hindi STRING, answer_index_hindi STRING, markforreview STRING)',
    );
    //

    print('database---------------$database');
   //"[1,2,]"
  }

  static Future<int> createItem(Questions_model note) async {

    print('------------------print');
    final db = await SqliteService.initizateDb();

    final id = await db.insert('Questions', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id--------------$id');
    return id;
  }

  // Read all notes
  static Future<List<Questions_model>> getItems() async {
    final db = await SqliteService.initizateDb();

    final List<Map<String, Object?>> queryResult = await db.query('Questions');
    print('-------------${queryResult.map((e) => Questions_model.fromMap(e)).toList()}');
    return queryResult.map((e) => Questions_model.fromMap(e)).toList();
  }


  // Delete an note by id
  static Future<void> deleteItem(String type) async {
    final db = await SqliteService.initizateDb();
    try {
      await db.delete("Questions", where: "type = ?", whereArgs: [type]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> updatedata(Questions_model note) async {
    // Get a reference to the database.
    final db = await SqliteService.initizateDb();

    print('note.map-----------------${note.toMap()}');
    // Update the given Dog.
    await db.update(
      'Questions',
      note.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [note.id],
    );
  }

}