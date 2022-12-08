import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/globals/shimmer_loading.dart';

class ShimmerLoadingRestaurant extends StatelessWidget {
  const ShimmerLoadingRestaurant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 15),
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) => Container(
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
              child: ShimmerLoading(
                widget: Container(
                  height: 150,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(
                    widget: Container(
                      width: 140,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ShimmerLoading(
                        widget: Container(
                          height: 15,
                          width: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ShimmerLoading(
                        widget: Container(
                          width: 80,
                          height: 15,
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
                      ShimmerLoading(
                        widget: Container(
                          width: 100,
                          height: 15,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ShimmerLoading(
                        widget: Container(
                          width: 15,
                          height: 15,
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
}
