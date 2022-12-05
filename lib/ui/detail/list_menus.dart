import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/utils/globals.dart';

class ListMenus extends StatelessWidget {
  final DetailRestaurantProvider provider;
  final String menus;
  final String imageAsset;

  const ListMenus(
      {Key? key,
      required this.provider,
      required this.menus,
      required this.imageAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CategoryResponse> listMenus;
    menus == Globals.foodMenu
        ? listMenus = provider.restaurantResultResponse.menus?.foods ??
            <CategoryResponse>[]
        : listMenus = provider.restaurantResultResponse.menus?.drinks ??
            <CategoryResponse>[];

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemCount: listMenus.length,
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
                imageAsset,
                width: 50,
                height: 50,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  listMenus[index].name ?? "",
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
