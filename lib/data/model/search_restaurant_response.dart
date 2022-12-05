import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant_list_response.dart';

SearchRestaurantResponse searchRestaurantResponseFromJson(String str) =>
    SearchRestaurantResponse.fromJson(json.decode(str));

class SearchRestaurantResponse {
  bool? error;
  int? founded;
  List<RestaurantDataResponse>? restaurants;

  SearchRestaurantResponse({
    this.error,
    this.founded,
    this.restaurants,
  });

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantDataResponse>.from(
            json["restaurants"].map((x) => RestaurantDataResponse.fromJson(x))),
      );
}
