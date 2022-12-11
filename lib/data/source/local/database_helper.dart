import 'package:restaurant_app/data/model/resturant_favorite.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static late Database _database;
  static const _tbRestaurant = "tb_restaurant";

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await initializeDb();
    return _database;
  }

  Future<Database> initializeDb() async {
    String path = await getDatabasesPath();
    var db = openDatabase(
      "$path/restaurant_db.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          """CREATE TABLE $_tbRestaurant (
          id TEXT PRIMARY KEY, 
          name TEXT, 
          city TEXT, 
          address TEXT, 
          pictureId TEXT, 
          rating REAL
          )""",
        );
      },
    );
    return db;
  }

  Future insertRestaurant(RestaurantFavorite restaurantFavorite) async {
    final Database db = await database;
    await db.insert(_tbRestaurant, restaurantFavorite.toMap());
  }

  Future<List<RestaurantFavorite>> getAllRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tbRestaurant);
    return results.map((e) => RestaurantFavorite.fromMap(e)).toList();
  }

  Future deleteRestaurant(String id) async {
    final Database db = await database;

    await db.delete(
      _tbRestaurant,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<Map> isFavorited(String id) async {
    final Database db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tbRestaurant,
      where: "id = ?",
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }
}
