import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app/ui/favorite/list_favorite.dart';
import 'package:restaurant_app/ui/globals/empty_animation.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantFavoriteProvider>(
        builder: (context, value, child) {
          if (value.listRestaurant.isNotEmpty) {
            return ListFavorite(provider: value);
          } else {
            return EmptyAnimation(
              textColor: Colors.white,
              errorMessage: value.message,
            );
          }
        },
      ),
    );
  }
}
