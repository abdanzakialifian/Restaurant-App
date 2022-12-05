import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/ui/detail/list_menus.dart';
import 'package:restaurant_app/ui/detail/list_review.dart';
import 'package:restaurant_app/ui/detail/shimmer_loading_detail.dart';
import 'package:restaurant_app/ui/detail/shimmer_loading_review.dart';
import 'package:restaurant_app/ui/globals/custom_text_input.dart';
import 'package:restaurant_app/ui/globals/empty_animation.dart';
import 'package:restaurant_app/ui/globals/error_animation.dart';
import 'package:restaurant_app/utils/globals.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: _getDetailRestaurant(context),
        ),
      ),
    );
  }

  Widget _getDetailRestaurant(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.height;
    return Consumer<DetailRestaurantProvider>(
      builder: (context, value, child) {
        if (value.state == ResultState.loading) {
          return const ShimmerLoadingDetail();
        } else if (value.state == ResultState.hasData) {
          return _detailRestaurantInformation(
              context, value.restaurantResultResponse);
        } else if (value.state == ResultState.noData) {
          return const Center(
            child: EmptyAnimation(),
          );
        } else {
          return ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: mediaQuery),
            child: const Center(
              child: ErrorAnimation(),
            ),
          );
        }
      },
    );
  }

  Widget _updateReviewRestaurant() {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, value, child) {
        if (value.stateReview == ResultState.loading) {
          return const ShimmerLoadingReview();
        } else if (value.stateReview == ResultState.hasData) {
          return ListReview(provider: value, from: Globals.fromReview);
        } else if (value.stateReview == ResultState.noData) {
          return const EmptyAnimation();
        } else {
          return const ErrorAnimation();
        }
      },
    );
  }

  Widget _detailRestaurantInformation(
      BuildContext context, RestaurantResultResponse result) {
    final provider =
        Provider.of<DetailRestaurantProvider>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              _favoriteButton(provider, context),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 110,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      result.name ?? "",
                      style: const TextStyle(
                          fontFamily: "Poppins Bold", fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                              result.city ?? "",
                              style: const TextStyle(
                                fontFamily: "Poppins Medium",
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemSize: 20,
                              itemCount: 5,
                              unratedColor: Colors.amber.withAlpha(50),
                              rating: result.rating?.toDouble() ?? 0.0,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${result.rating?.toDouble() ?? 0}",
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
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      result.description ?? "",
                      style: const TextStyle(
                        fontFamily: "Poppins Regular",
                        fontSize: 12,
                        color: darkGrey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Foods",
                      style: TextStyle(
                          fontFamily: "Poppins Bold",
                          fontSize: 16,
                          color: darkGreen),
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    child: ListMenus(
                      provider: provider,
                      menus: Globals.foodMenu,
                      imageAsset: "assets/images/ic_food.png",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Drinks",
                      style: TextStyle(
                          fontFamily: "Poppins Bold",
                          fontSize: 16,
                          color: darkGreen),
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    child: ListMenus(
                      provider: provider,
                      menus: Globals.drinkMenu,
                      imageAsset: "assets/images/ic_drink.png",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Review",
                      style: TextStyle(
                          fontFamily: "Poppins Bold",
                          fontSize: 16,
                          color: darkGreen),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomTextInput(
                        hintText: "Input your name...",
                        height: 40,
                        controller: provider.name),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: CustomTextInput(
                      hintText: "Input your review...",
                      height: 100,
                      controller: provider.review,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        provider.postReviewCustomer(
                          provider.restaurantResultResponse.id ?? "",
                          provider.name.text,
                          provider.review.text,
                        );
                      },
                      child: const Text(
                        "Send",
                        style: TextStyle(
                            fontFamily: "Poppins Regular", color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  provider.stateReview != null
                      ? _updateReviewRestaurant()
                      : ListReview(
                          provider: provider, from: Globals.fromDetail),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 45),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 175, 175, 175),
                    blurRadius: 0.5,
                    spreadRadius: 0.2,
                    offset: Offset(2, 2),
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://restaurant-api.dicoding.dev/images/medium/${result.pictureId}"),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _favoriteButton(
      DetailRestaurantProvider provider, BuildContext context) {
    return IconButton(
      onPressed: (() {
        provider.isFavorite
            ? provider.setFavorite(false)
            : provider.setFavorite(true);
        SnackBar addFavorite = _snackBar(
          "${provider.restaurantResultResponse.name} added to favorite",
        );
        SnackBar deleteFavorite = _snackBar(
          "${provider.restaurantResultResponse.name} deleted from favorite",
        );
        ScaffoldMessenger.of(context).showSnackBar(
          provider.isFavorite ? addFavorite : deleteFavorite,
        );
      }),
      icon: provider.isFavorite
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

  SnackBar _snackBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    );
  }
}
