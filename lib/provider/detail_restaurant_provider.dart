import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/source/remote/api_service.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  late ResultState _state;
  ResultState? _stateReview;
  late RestaurantResultResponse _restaurantResultResponse;
  late List<CustomerReviewResponse> _customerReviewResponse;
  late String _message;
  bool _isFavorite = false;

  ResultState get state => _state;
  ResultState? get stateReview => _stateReview;
  RestaurantResultResponse get restaurantResultResponse =>
      _restaurantResultResponse;
  List<CustomerReviewResponse> get customerReviewResponse =>
      _customerReviewResponse;
  String get message => _message;
  bool get isFavorite => _isFavorite;

  TextEditingController name = TextEditingController();
  TextEditingController review = TextEditingController();

  DetailRestaurantProvider({required this.apiService, required String id}) {
    _fetchDetailRestaurant(id);
  }

  void setFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
    notifyListeners();
  }

  void postReviewCustomer(String id, String name, String review) {
    _postCustomerReview(id, name, review);
  }

  Future _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.fetchDetailRestaurant(id);
      if (detailRestaurant.restaurant == null) {
        _state = ResultState.noData;
        _message = "Data is Empty";
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantResultResponse =
            detailRestaurant.restaurant ?? RestaurantResultResponse();
      }
    } catch (e) {
      _state = ResultState.hasError;
      _message = "Failed to Load Data";
      notifyListeners();
      return _message;
    }
  }

  Future _postCustomerReview(String id, String name, String review) async {
    try {
      _stateReview = ResultState.loading;
      notifyListeners();
      final reviewRestaurant =
          await apiService.reviewRestuarant(id, name, review);
      if (reviewRestaurant.customerReviews?.isEmpty == true) {
        _stateReview = ResultState.noData;
        _message = "Data is Empty";
        notifyListeners();
      } else {
        _stateReview = ResultState.hasData;
        notifyListeners();
        _customerReviewResponse =
            reviewRestaurant.customerReviews ?? <CustomerReviewResponse>[];
      }
    } catch (e) {
      _stateReview = ResultState.hasError;
      _message = "Failed to Load Data";
      notifyListeners();
    }
  }

  @override
  void dispose() {
    name.dispose();
    review.dispose();
    super.dispose();
  }
}
