import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/ui/favorite/favorite_page.dart';
import 'package:restaurant_app/ui/globals/empty_animation.dart';
import 'package:restaurant_app/ui/globals/error_animation.dart';
import 'package:restaurant_app/ui/home/list_restaurant.dart';
import 'package:restaurant_app/ui/home/shimmer_loading_restaurant.dart';
import 'package:restaurant_app/ui/settings/settings_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/utils/result_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureDidReceiveLocalNotificationSubject(context);
    _notificationHelper.configureSelectedNotificationSubject(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Hi Guest!",
                        style: TextStyle(
                          fontFamily: "Poppins Medium",
                          color: darkGrey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FavoritePage()),
                        ),
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.settings,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
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
              Expanded(child: _getDataRestaurants(context)),
            ],
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
        switch (value.state) {
          case ResultState.noData:
            return EmptyAnimation(
              textColor: darkGreen,
              errorMessage: value.message ?? "",
            );
          case ResultState.hasData:
            return ListRestaurant(listRestaurants: value.result ?? []);
          case ResultState.hasError:
            return ErrorAnimation(
              textColor: Colors.red,
              errorMessage: value.message ?? "",
            );
          default:
            return const ShimmerLoadingRestaurant();
        }
      },
    );
  }

  @override
  void dispose() {
    selectedNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }
}
