import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/data/source/local/database_helper.dart';
import 'package:restaurant_app/data/source/remote/api_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/utils/globals.dart';

class ListRestaurant extends StatelessWidget {
  final List<RestaurantDataResponse> listRestaurants;

  const ListRestaurant({Key? key, required this.listRestaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(bottom: 15),
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        shrinkWrap: true,
        itemCount: listRestaurants.length,
        itemBuilder: (context, index) {
          final restaurants = listRestaurants[index];
          return InkWell(
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
                            id: restaurants.id ?? "",
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
                        id: restaurants.id ?? "",
                      ),
                    );
                  },
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 233, 233, 233),
                    blurRadius: 1,
                    spreadRadius: 0.5,
                    offset: Offset(1, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/medium/${restaurants.pictureId}",
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurants.name ?? "",
                          style: const TextStyle(
                            fontFamily: "Poppins Bold",
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                              restaurants.city ?? "",
                              style: const TextStyle(
                                fontFamily: "Poppins Medium",
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemSize: 20,
                              itemCount: 5,
                              unratedColor: Colors.amber.withAlpha(50),
                              rating: restaurants.rating ?? 0.0,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${restaurants.rating?.toDouble() ?? 0}",
                              style: const TextStyle(
                                fontFamily: "Poppins Medium",
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
