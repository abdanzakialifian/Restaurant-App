import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/resturant_favorite.dart';
import 'package:restaurant_app/data/source/local/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'database_helper_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late Database database;
  late MockDatabaseHelper databaseHelper;
  const tbRestaurant = "tb_restaurant";
  final RestaurantFavorite dummyRestaurantFavorite = RestaurantFavorite(
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    city: "Medan",
    address: "Jln. Pandeglang no 19",
    pictureId: "14",
    rating: 4.2,
  );
  List<RestaurantFavorite> dummyListRestaurant = List.generate(
    10,
    (index) => dummyRestaurantFavorite,
  );

  setUpAll(
    () async {
      sqfliteFfiInit();
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await database.execute(
        """CREATE TABLE $tbRestaurant (
          id TEXT PRIMARY KEY, 
          name TEXT, 
          city TEXT, 
          address TEXT, 
          pictureId TEXT, 
          rating REAL
          )""",
      );
      databaseHelper = MockDatabaseHelper();
      databaseHelper.db = database;
      when(databaseHelper.insertRestaurant(any))
          .thenAnswer((_) async => dummyRestaurantFavorite);
      when(databaseHelper.getAllRestaurant())
          .thenAnswer((_) async => dummyListRestaurant);
      when(databaseHelper.deleteRestaurant(dummyRestaurantFavorite.id))
          .thenAnswer((_) async => 9);
      when(databaseHelper.isFavorited(dummyRestaurantFavorite.id)).thenAnswer(
        (_) async => dummyRestaurantFavorite.toMap(),
      );
    },
  );

  group(
    "Database Test",
    () {
      test(
        "Sqflite version",
        () async {
          expect(await database.getVersion(), 0);
        },
      );
      test(
        "Insert restaurant favorite",
        () async {
          verifyNever(databaseHelper.insertRestaurant(dummyRestaurantFavorite));
          expect(await databaseHelper.insertRestaurant(dummyRestaurantFavorite),
              dummyRestaurantFavorite);
          verify(databaseHelper.insertRestaurant(dummyRestaurantFavorite))
              .called(1);
        },
      );
      test(
        "Get all restaurant favorite",
        () async {
          verifyNever(databaseHelper.getAllRestaurant());
          expect(await databaseHelper.getAllRestaurant(), dummyListRestaurant);
          verify(databaseHelper.getAllRestaurant()).called(1);
        },
      );
      test(
        "Delete restaurant favorite",
        () async {
          verifyNever(
              databaseHelper.deleteRestaurant(dummyRestaurantFavorite.id));
          expect(
              await databaseHelper.deleteRestaurant(dummyRestaurantFavorite.id),
              dummyListRestaurant.length - 1);
          verify(databaseHelper.deleteRestaurant(dummyRestaurantFavorite.id))
              .called(1);
        },
      );
      test(
        "Get already favorited",
        () async {
          verifyNever(databaseHelper.isFavorited(dummyRestaurantFavorite.id));
          expect(
            await databaseHelper.isFavorited(dummyRestaurantFavorite.id),
            dummyRestaurantFavorite.toMap(),
          );
          verify(databaseHelper.isFavorited(dummyRestaurantFavorite.id))
              .called(1);
        },
      );
    },
  );
}
