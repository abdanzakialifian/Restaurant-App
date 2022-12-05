import 'dart:convert';

RestaurantListResponse restaurantListResponseFromJson(String str) =>
    RestaurantListResponse.fromJson(json.decode(str));

class RestaurantListResponse {
  bool? error;
  String? message;
  int? count;
  List<RestaurantDataResponse>? restaurants;

  RestaurantListResponse({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantDataResponse>.from(
          json["restaurants"].map(
            (x) => RestaurantDataResponse.fromJson(x),
          ),
        ),
      );
}

class RestaurantDataResponse {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  RestaurantDataResponse({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory RestaurantDataResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDataResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
