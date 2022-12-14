import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/resturant_favorite.dart';
import 'package:restaurant_app/data/source/local/database_helper.dart';
import 'package:restaurant_app/data/source/remote/api_service.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_favorite_provider.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import 'package:restaurant_app/ui/globals/empty_animation.dart';
import 'package:restaurant_app/ui/globals/error_animation.dart';
import 'package:restaurant_app/utils/globals.dart';
import 'package:restaurant_app/utils/result_state.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    RestaurantFavoriteProvider provider =
        Provider.of<RestaurantFavoriteProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: provider.getAllRestaurant(),
        builder: (context, snapshot) {
          switch (snapshot.data) {
            case ResultState.hasData:
              return _appbar(provider, context, Globals.hasData);
            case ResultState.noData:
              return EmptyAnimation(
                textColor: darkGreen,
                errorMessage: provider.message,
              );
            case ResultState.hasError:
              return ErrorAnimation(
                textColor: Colors.red,
                errorMessage: provider.message,
              );
            default:
              return const CircularProgressIndicator(
                color: darkGreen,
              );
          }
        },
      ),
    );
  }

  Widget _appbar(
      RestaurantFavoriteProvider provider, BuildContext context, String state) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 12,
              right: 5,
              bottom: 15,
            ),
            child: SizedBox(
              height: 40,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        "Favorite",
                        style: TextStyle(
                          fontFamily: "Poppins Bold",
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _listFavorite(provider.listRestaurant),
          ),
        ],
      ),
    );
  }

  Widget _listFavorite(List<RestaurantFavorite> listRestaurant) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: listRestaurant.length,
      itemBuilder: (context, index) {
        RestaurantFavorite restaurant = listRestaurant[index];
        return Padding(
          padding: const EdgeInsets.all(15),
          child: InkWell(
            onTap: () async {
              var awaitData = await Navigator.push(
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

              if (awaitData == Globals.rebuildPage) {
                /// rebuild page
                setState(() {});
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    Globals.baseUrlImage + restaurant.pictureId.toString(),
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/ic_marker_location.png",
                            height: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              "${restaurant.address}, ${restaurant.city}",
                              style: const TextStyle(
                                fontFamily: "Poppins Medium",
                                fontSize: 12,
                                color: Colors.grey,
                              ),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
