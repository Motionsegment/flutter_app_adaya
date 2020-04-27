import 'package:flutterappadaya/model/Fav.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'dart:async';
import 'dart:io';

class DatabaseHelper{

  String favesTable = "faves";
  String colId = "id";
  String colSwraName = "swraName";
  String colSwraIndex = "swraIndex";
  String colText = "text";
  String colIndex = "ayaIndex";
  String colIsFave = "isFave";

  static final _databaseName = "faves.db";
  static final _databaseVersion = 1;

  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper ()
  {
    if(_databaseHelper == null)
      _databaseHelper = DatabaseHelper._createInstance();

    return _databaseHelper;
  }


  Future<Database> get database async{

    if(_database == null)
      _database = await initializeDb();

    return _database;
  }

  Future<Database> initializeDb() async{
    // Get the directory path for both Android and IOS to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);

    print("the path is : " + path);
    //Open/Create the database at a given path
    var notesDatabase = await openDatabase(path,version: _databaseVersion , onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db , int version) async{

    await db.execute('''
    CREATE TABLE $favesTable (
    $colId INTEGER PRIMARY KEY AUTOINCREMENT ,
    $colSwraName TEXT, 
    $colSwraIndex TEXT, 
    $colText TEXT,
    $colIndex TEXT,
    $colIsFave INTEGER NOT NULL
    )
     ''');

    /*await db.execute('''
          CREATE TABLE $favesTable (
            $colId INTEGER PRIMARY KEY,
            $colSwraName TEXT NOT NULL,
            $colIsFave INTEGER NOT NULL
          )
          ''');*/
  }

  //Fetch Operation : Get all Note object from database
  Future<List<Fav>> getAll() async{
    Database db = await this.database;
    // var result = await db.query('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(favesTable);
    return result.map((f)=>Fav.fromMap(f)).toList();
  }

  //Insert Operation : Insert a Note object to database
  Future<int> insertFav(Fav fav)async{
    //print("Start Inserting");
    Database db = await this.database;
    //print("End Inserting");
    var result = await db.insert(favesTable, fav.toMap());
    return result;
  }


  Future<int> getCount() async{
    Database db = await this.database;
    return Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM $favesTable ")
    );
  }

  Future<List<Fav>> getFav() async
  {
    Database db = await this.database;
    var result = await db.rawQuery("SELECT * FROM $favesTable WHERE $colIsFave = 1");
    return result.map((f)=>Fav.fromMap(f)).toList();
  }

  Future<int> updateFave(Fav fav) async{
    Database db = await this.database;
     return await db.update(favesTable, fav.toMap(),where: "$colId =?",whereArgs: [fav.id]);
  }

  Future delete() async{
    Database db = await this.database;
    await db.execute("DROP TABLE IF EXISTS $favesTable");
  }
  Future close() async{
    Database db = await this.database;

    return db.close();
  }


}