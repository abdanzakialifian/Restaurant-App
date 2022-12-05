import 'dart:convert';

DetailRestaurantResponse detailRestaurantResponseFromJson(String str) =>
    DetailRestaurantResponse.fromJson(json.decode(str));

class DetailRestaurantResponse {
  bool? error;
  String? message;
  RestaurantResultResponse? restaurant;

  DetailRestaurantResponse({
    this.error,
    this.message,
    this.restaurant,
  });

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantResultResponse.fromJson(json["restaurant"]),
      );
}

class RestaurantResultResponse {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<CategoryResponse>? categories;
  MenusResponse? menus;
  double? rating;
  List<CustomerReviewResponse>? customerReviews;

  RestaurantResultResponse({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory RestaurantResultResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantResultResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<CategoryResponse>.from(
            json["categories"].map((x) => CategoryResponse.fromJson(x))),
        menus: MenusResponse.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReviewResponse>.from(
            json["customerReviews"]
                .map((x) => CustomerReviewResponse.fromJson(x))),
      );
}

class CategoryResponse {
  String? name;

  CategoryResponse({
    this.name,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        name: json["name"],
      );
}

class CustomerReviewResponse {
  String? name;
  String? review;
  String? date;

  CustomerReviewResponse({
    this.name,
    this.review,
    this.date,
  });

  factory CustomerReviewResponse.fromJson(Map<String, dynamic> json) =>
      CustomerReviewResponse(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class MenusResponse {
  List<CategoryResponse>? foods;
  List<CategoryResponse>? drinks;

  MenusResponse({
    this.foods,
    this.drinks,
  });

  factory MenusResponse.fromJson(Map<String, dynamic> json) => MenusResponse(
        foods: List<CategoryResponse>.from(
            json["foods"].map((x) => CategoryResponse.fromJson(x))),
        drinks: List<CategoryResponse>.from(
            json["drinks"].map((x) => CategoryResponse.fromJson(x))),
      );
}
