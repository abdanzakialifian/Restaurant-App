import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/resturant_favorite.dart';
import 'package:restaurant_app/data/source/local/database_helper.dart';
import 'package:restaurant_app/utils/globals.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  String _message = "";
  List<RestaurantFavorite> _listRestaurant = [];

  String get message => _message;
  List<RestaurantFavorite> get listRestaurant => _listRestaurant;
  String to = "";

  RestaurantFavoriteProvider({required this.databaseHelper, required this.to}) {
    if (to == Globals.toFavorite) {
      getAllRestaurant();
    }
  }

  Future<void> insertRestaurant(
      RestaurantFavorite restaurantFavorite, String id) async {
    try {
      await databaseHelper.insertRestaurant(restaurantFavorite);
      _message = "${restaurantFavorite.name} added to favorite.";
      isFavorite(id);
      notifyListeners();
    } catch (e) {
      _message = "Failed to Insert Data.";
      notifyListeners();
    }
  }

  Future<void> deleteRestaurant(
      RestaurantFavorite restaurantFavorite, String id) async {
    try {
      await databaseHelper.deleteRestaurant(id);
      _message = "${restaurantFavorite.name} deleted from favorite.";
      isFavorite(id);
      notifyListeners();
    } catch (e) {
      _message = "Failed to Delete Data.";
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favorite = await databaseHelper.isFavorited(id);
    return favorite.isNotEmpty;
  }

  Future getAllRestaurant() async {
    var awaitData = await databaseHelper.getAllRestaurant();
    notifyListeners();
    if (awaitData.isNotEmpty) {
      _listRestaurant = awaitData;
      notifyListeners();
    } else {
      _message = "Data is Empty";
      notifyListeners();
    }
  }
}
