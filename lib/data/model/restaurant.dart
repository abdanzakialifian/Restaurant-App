import 'package:restaurant_app/data/model/restaurants.dart';

class Restaurant {
  List<Restaurants>? restaurants;

  Restaurant({this.restaurants});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    if (json["restaurants"] == null) {
      return Restaurant(restaurants: <Restaurants>[]);
    } else {
      List<Restaurants>? listRestaurants = <Restaurants>[];
      json["restaurants"].forEach((e) {
        listRestaurants.add(Restaurants.fromJson(e));
      });

      return Restaurant(restaurants: listRestaurants);
    }
  }
}
