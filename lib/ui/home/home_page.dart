import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/ui/globals/empty_animation.dart';
import 'package:restaurant_app/ui/globals/error_animation.dart';
import 'package:restaurant_app/ui/home/list_restaurant.dart';
import 'package:restaurant_app/ui/home/shimmer_loading_restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hi Guest!",
                      style: TextStyle(
                        fontFamily: "Poppins Medium",
                        color: darkGrey,
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: darkGreen,
                      ),
                      child: Image.asset(
                        "assets/images/default_profile.png",
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Hungry Now?",
                      style: TextStyle(
                        fontFamily: "Poppins Bold",
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "assets/images/fire.png",
                        height: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                _customSearchView(context),
                const SizedBox(
                  height: 20,
                ),
                _getDataRestaurants(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// custom widget search
  Widget _customSearchView(BuildContext context) {
    final provider =
        Provider.of<RestaurantListProvider>(context, listen: false);
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          onChanged: (query) {
            Future.delayed(
              const Duration(
                milliseconds: 300,
              ),
              () => provider.setQuery(query),
            );
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search restaurant...",
            hintStyle: TextStyle(
              fontFamily: "Poppins Regular",
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDataRestaurants(BuildContext context) {
    return Consumer<RestaurantListProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.loading) {
          return const ShimmerLoadingRestaurant();
        } else if (value.state == ResultState.hasData) {
          return ListRestaurant(listRestaurants: value.result);
        } else if (value.state == ResultState.noData) {
          return const EmptyAnimation();
        } else {
          return Container(
            margin: const EdgeInsets.only(top: 150),
            child: const ErrorAnimation(),
          );
        }
      },
    );
  }
}
