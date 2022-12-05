import 'dart:convert';

import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

ReviewRestaurantResponse reviewRestaurantResponseFromJson(String str) =>
    ReviewRestaurantResponse.fromJson(json.decode(str));

class ReviewRestaurantResponse {
  bool? error;
  String? message;
  List<CustomerReviewResponse>? customerReviews;

  ReviewRestaurantResponse({
    this.error,
    this.message,
    this.customerReviews,
  });

  factory ReviewRestaurantResponse.fromJson(Map<String, dynamic> json) =>
      ReviewRestaurantResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReviewResponse>.from(
            json["customerReviews"]
                .map((x) => CustomerReviewResponse.fromJson(x))),
      );
}
