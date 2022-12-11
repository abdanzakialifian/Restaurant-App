import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/resturant_favorite.dart';
import 'package:restaurant_app/data/source/local/database_helper.dart';
import 'package:restaurant_app/data/source/remote/api_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/utils/globals.dart';

class ListFavorite extends StatelessWidget {
  final RestaurantFavoriteProvider provider;

  const ListFavorite({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: provider.listRestaurant.length,
      itemBuilder: (context, index) {
        RestaurantFavorite restaurant = provider.listRestaurant[index];
        return Padding(
          padding: const EdgeInsets.all(20),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => DetailRestaurantProvider(
                            apiService: ApiService(),
                            id: restaurant.id ?? "",
                          ),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => RestaurantFavoriteProvider(
                            databaseHelper: DatabaseHelper(),
                            to: Globals.toDetail,
                          ),
                        ),
                      ],
                      child: DetailPage(
                        id: restaurant.id ?? "",
                      ),
                    );
                  },
                ),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}",
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name ?? "",
                      style: const TextStyle(
                        fontFamily: "Poppins Bold",
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/ic_marker_location.png",
                          height: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${restaurant.address}, ${restaurant.city}",
                          style: const TextStyle(
                            fontFamily: "Poppins Medium",
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          itemSize: 15,
                          itemCount: 5,
                          unratedColor: Colors.amber.withAlpha(50),
                          rating: restaurant.rating ?? 0.0,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${restaurant.rating ?? 0}",
                          style: const TextStyle(
                            fontFamily: "Poppins Medium",
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
