import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/globals/shimmer_loading.dart';

class ShimmerLoadingMenus extends StatelessWidget {
  const ShimmerLoadingMenus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemCount: 10,
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
              ShimmerLoading(
                widget: CircleAvatar(
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ShimmerLoading(
                widget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 80,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
