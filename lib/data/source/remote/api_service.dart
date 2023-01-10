import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/model/review_restaurant_response.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static const String _headers = "Content-Type";
  static const String _bodyHeaders = "application/x-www-form-urlencoded";
  static const _id = "id";
  static const _name = "name";
  static const _review = "review";

  Future<RestaurantListResponse> fetchListRestaurants({httpClient = http.Client}) async {
    var client = (httpClient == http.Client) ? http.Client() : httpClient;

    final response = await client.get(Uri.parse("${_baseUrl}list"));

    if (response.statusCode == 200) {
      return restaurantListResponseFromJson(response.body);
    } else {
      throw Exception("Failed to load list restaurants");
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query, {httpClient = http.Client}) async {
    var client = (httpClient == http.Client) ? http.Client() : httpClient;

    final response = await client.get(Uri.parse("${_baseUrl}search?q=$query"));

    if (response.statusCode == 200) {
      return searchRestaurantResponseFromJson(response.body);
    } else {
      throw Exception("Failed to search restaurants");
    }
  }

  Future<DetailRestaurantResponse> fetchDetailRestaurant(String id, {httpClient = http.Client}) async {
    var client = (httpClient == http.Client) ? http.Client() : httpClient;

    final response = await client.get(Uri.parse("${_baseUrl}detail/$id"));

    if (response.statusCode == 200) {
      return detailRestaurantResponseFromJson(response.body);
    } else {
      throw Exception("Failed to load detail restaurant");
    }
  }

  Future<ReviewRestaurantResponse> reviewRestuarant(String id, String name, String review, {httpClient = http.Client}) async {
    var client = (httpClient == http.Client) ? http.Client() : httpClient;

    final response = await client.post(
      Uri.parse("${_baseUrl}review"),
      headers: <String, String>{
        _headers: _bodyHeaders,
      },
      body: <String, String>{
        _id: id,
        _name: name,
        _review: review,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return reviewRestaurantResponseFromJson(response.body);
    } else {
      throw Exception("Failed to post review restaurant");
    }
  }
}
