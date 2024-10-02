import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ResturantHelper {
  // Singleton pattern for the database helper
  static final ResturantHelper instance = ResturantHelper._privateConstructor();
  static Database? _database;

  ResturantHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'resturant_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE resturant(id INTEGER PRIMARY KEY AUTOINCREMENT, resid TEXT, name TEXT, aboutus TEXT, address TEXT, phone TEXT, ownerid TEXT, latitude TEXT,longitude TEXT,website TEXT, ownername TEXT, ownerphone TEXT, owneremail TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert user
  Future<void> insertDetails(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'resturant',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all details
  Future<List<Map<String, dynamic>>> getDetails() async {
    final db = await database;
    return db.query('resturant');
  }
}
