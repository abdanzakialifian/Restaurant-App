import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/ui/detail/detail_page.dart';
import '../../data/model/restaurants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future? jsonLocal;
  List<Restaurants> listRestaurants = <Restaurants>[];
  List<Restaurants> restaurants = <Restaurants>[];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    jsonLocal = DefaultAssetBundle.of(context)
        .loadString("assets/json/restaurants.json");

    _textEditingController.addListener(() => filterSearchResult());

    restaurants.addAll(listRestaurants);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              _customSearchWidget(context),
              const SizedBox(
                height: 20,
              ),
              _listRestaurant(context),
            ],
          ),
        ),
      ),
    );
  }

  /// custom widget search
  Widget _customSearchWidget(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: TextField(
          controller: _textEditingController,
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

  // getting data from json local
  FutureBuilder<String> _listRestaurant(BuildContext context) {
    return FutureBuilder<String>(
      future: jsonLocal as Future<String>,
      builder: (context, snapshot) {
        listRestaurants = parseRestaurants(snapshot.data);
        return Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 15),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            shrinkWrap: true,
            itemCount: restaurants.isEmpty
                ? listRestaurants.length
                : restaurants.length,
            itemBuilder: (context, index) => _listRestaurantWidget(
                context,
                restaurants.isEmpty
                    ? listRestaurants[index]
                    : restaurants[index]),
          ),
        );
      },
    );
  }

  /// parse json to list of object
  List<Restaurants> parseRestaurants(String? data) {
    if (data == null) {
      return <Restaurants>[];
    }
    var parseJson = json.decode(data);
    Restaurant restaurant = Restaurant.fromJson(parseJson);
    return restaurant.restaurants ?? <Restaurants>[];
  }

  Widget _listRestaurantWidget(BuildContext context, Restaurants restaurants) {
    return InkWell(
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(restaurants: restaurants),
            ),
          );
        });
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
                restaurants.pictureId ?? "",
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
                        rating: restaurants.rating?.toDouble() ?? 0.0,
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
  }

  void filterSearchResult() {
    if (_textEditingController.text.isNotEmpty) {
      List<Restaurants> listData = <Restaurants>[];
      for (var element in listRestaurants) {
        if (element.name
                ?.toLowerCase()
                .contains(_textEditingController.text.toLowerCase()) ==
            true) {
          listData.add(element);
        }
      }
      setState(() {
        restaurants.clear();
        restaurants.addAll(listData);
      });
      return;
    } else {
      setState(() {
        restaurants.clear();
        restaurants.addAll(listRestaurants);
      });
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }
}
