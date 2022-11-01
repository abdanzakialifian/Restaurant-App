import 'package:restaurant_app/data/model/drinks.dart';
import 'package:restaurant_app/data/model/foods.dart';

class Menus {
  List<Foods>? foods;
  List<Drinks>? drinks;

  Menus({this.foods, this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    List<Foods> listFoods = <Foods>[];
    List<Drinks> listDrinks = <Drinks>[];

    if (json["foods"] == null) {
      return Menus(foods: <Foods>[]);
    } else {
      json["foods"].forEach((e) {
        listFoods.add(Foods.fromJson(e));
      });
    }

    if (json["drinks"] == null) {
      return Menus(drinks: <Drinks>[]);
    } else {
      json["drinks"].forEach((e) {
        listDrinks.add(Drinks.fromJson(e));
      });
    }

    return Menus(foods: listFoods, drinks: listDrinks);
  }
}
