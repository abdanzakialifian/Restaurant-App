import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/resturant_favorite.dart';
import 'package:restaurant_app/data/source/local/database_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  String? _message;
  List<RestaurantFavorite>? _listRestaurant;

  String? get message => _message;
  List<RestaurantFavorite>? get listRestaurant => _listRestaurant;

  RestaurantFavoriteProvider({required this.databaseHelper});

  Future insertRestaurant(
      RestaurantFavorite restaurantFavorite, String id) async {
    try {
      await databaseHelper.insertRestaurant(restaurantFavorite);
      isFavorite(id);
      _message = "${restaurantFavorite.name} added to favorite.";
      notifyListeners();
    } catch (e) {
      _message = "Failed to Insert Data.";
      notifyListeners();
    }
  }

  Future deleteRestaurant(
      RestaurantFavorite restaurantFavorite, String id) async {
    try {
      await databaseHelper.deleteRestaurant(id);
      isFavorite(id);
      _message = "${restaurantFavorite.name} deleted from favorite.";
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

  Future<dynamic> getAllRestaurant() async {
    _listRestaurant = await databaseHelper.getAllRestaurant();
    try {
      if (_listRestaurant?.isNotEmpty == true) {
        return ResultState.hasData;
      } else {
        _message = "Data is Empty.";
        notifyListeners();
        return ResultState.noData;
      }
    } catch (e) {
      _message = "Get Data Error.";
      notifyListeners();
      return ResultState.hasError;
    }
  }
}
