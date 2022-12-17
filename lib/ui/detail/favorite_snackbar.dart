import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/resturant_favorite.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';

class FavoriteSnackbar extends StatelessWidget {
  final RestaurantFavoriteProvider provider;
  final RestaurantFavorite restaurantFavorite;
  final bool isFavorite;

  const FavoriteSnackbar({
    Key? key,
    required this.provider,
    required this.restaurantFavorite,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final Future awaitData;

        if (isFavorite) {
          awaitData = provider.deleteRestaurant(
            restaurantFavorite,
            restaurantFavorite.id ?? "",
          );
        } else {
          awaitData = provider.insertRestaurant(
            restaurantFavorite,
            restaurantFavorite.id ?? "",
          );
        }

        awaitData.whenComplete(() {
          SnackBar snackBar = SnackBar(
            content: Text(provider.message ?? ""),
            duration: const Duration(milliseconds: 500),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
      icon: isFavorite
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
    );
  }
}
