import 'package:flutter/material.dart';
import 'package:restaurant_app/data/source/remote/api_service.dart';
import 'package:restaurant_app/utils/result_state.dart';
import '../data/model/restaurant_list_response.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  late List<RestaurantDataResponse> _restaurantList;
  late ResultState _state;
  late String _message;

  List<RestaurantDataResponse> get result => _restaurantList;
  ResultState get state => _state;
  String get message => _message;

  RestaurantListProvider({required this.apiService}) {
    _fetchRestaurant();
  }

  void setQuery(String query) {
    query.isNotEmpty ? _searchRestaurant(query) : _fetchRestaurant();
  }

  void _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.fetchListRestaurants();
      if (restaurant.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        _message = "Data is Empty";
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _restaurantList = restaurant.restaurants ?? <RestaurantDataResponse>[];
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.hasError;
      _message = "Failed to Load Data";
      notifyListeners();
    }
  }

  void _searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchRestaurant = await apiService.searchRestaurant(query);
      if (searchRestaurant.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        _message = "Data is Empty";
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _restaurantList =
            searchRestaurant.restaurants ?? <RestaurantDataResponse>[];
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.hasError;
      _message = "Failed to Load Data";
      notifyListeners();
    }
  }
}
