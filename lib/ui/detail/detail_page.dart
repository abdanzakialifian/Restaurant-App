import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/model/foods.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/style/color.dart';
import '../../data/model/drinks.dart';

class DetailPage extends StatefulWidget {
  final Restaurants restaurants;

  const DetailPage({Key? key, required this.restaurants}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                    IconButton(
                      onPressed: (() {
                        setState(() {
                          !isFavorite ? isFavorite = true : isFavorite = false;
                          SnackBar addFavorite = SnackBar(
                            content: Text(
                                "${widget.restaurants.name} added to favorite"),
                            duration: const Duration(seconds: 1),
                          );
                          SnackBar deleteFavorite = SnackBar(
                            content: Text(
                                "${widget.restaurants.name} deleted from favorite"),
                            duration: const Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            !isFavorite ? deleteFavorite : addFavorite,
                          );
                        });
                      }),
                      icon: !isFavorite
                          ? const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                    ),
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
                            widget.restaurants.name ?? "",
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
                                    widget.restaurants.city ?? "",
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
                                    rating:
                                        widget.restaurants.rating?.toDouble() ??
                                            0.0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${widget.restaurants.rating?.toDouble() ?? 0}",
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
                            widget.restaurants.description ?? "",
                            style: const TextStyle(
                                fontFamily: "Poppins Regular",
                                fontSize: 12,
                                color: darkGrey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
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
                          child: _listCardFoods(context),
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
                          child: _listCardDrinks(context),
                        ),
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
                        image: NetworkImage(widget.restaurants.pictureId ?? ""),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listCardFoods(BuildContext context) {
    List<Foods> listFoods = widget.restaurants.menus?.foods ?? <Foods>[];
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemCount: listFoods.length,
      itemBuilder: (context, index) {
        return Container(
          width: 150,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 175, 175, 175),
                blurRadius: 0.5,
                spreadRadius: 0.2,
                offset: Offset(1, 2),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/ic_food.png",
                width: 50,
                height: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  listFoods[index].name ?? "",
                  style: const TextStyle(
                    fontFamily: "Poppins Medium",
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _listCardDrinks(BuildContext context) {
    List<Drinks> listDrinks = widget.restaurants.menus?.drinks ?? <Drinks>[];
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemCount: listDrinks.length,
      itemBuilder: (context, index) {
        return Container(
          width: 150,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 175, 175, 175),
                blurRadius: 0.5,
                spreadRadius: 0.2,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/ic_drink.png",
                height: 50,
                width: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  listDrinks[index].name ?? "",
                  style: const TextStyle(
                    fontFamily: "Poppins Medium",
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
