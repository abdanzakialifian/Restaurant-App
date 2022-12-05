import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/result_state.dart';
import '../data/model/restaurant_list_response.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  late List<RestaurantDataResponse> _restaurantList;
  late ResultState _state;

  List<RestaurantDataResponse> get result => _restaurantList;
  ResultState get state => _state;

  RestaurantListProvider({required this.apiService}) {
    _fetchRestaurant();
  }

  void setQuery(String query) {
    query.isNotEmpty ? _searchRestaurant(query) : _fetchRestaurant();
  }

  Future _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.fetchListRestaurants();
      if (restaurant.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantList = restaurant.restaurants ?? <RestaurantDataResponse>[];
      }
    } catch (e) {
      _state = ResultState.hasError;
      notifyListeners();
    }
  }

  Future _searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchRestaurant = await apiService.searchRestaurant(query);
      if (searchRestaurant.restaurants?.isEmpty == true) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantList =
            searchRestaurant.restaurants ?? <RestaurantDataResponse>[];
      }
    } catch (e) {
      _state = ResultState.hasError;
      notifyListeners();
    }
  }
}
