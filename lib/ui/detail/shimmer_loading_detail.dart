import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail/shimmer_loading_menus.dart';
import 'package:restaurant_app/ui/detail/shimmer_loading_review.dart';
import 'package:restaurant_app/ui/globals/shimmer_loading.dart';

class ShimmerLoadingDetail extends StatelessWidget {
  const ShimmerLoadingDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 110,
                      ),
                      ShimmerLoading(
                        widget: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 140,
                            height: 20,
                            color: Colors.grey,
                          ),
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
                                    width: 90,
                                    height: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ShimmerLoading(
                                  widget: Container(
                                    width: 70,
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
                      const SizedBox(
                        height: 30,
                      ),
                      ShimmerLoading(
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ShimmerLoading(
                        widget: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: 70,
                            height: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 130,
                        child: ShimmerLoadingMenus(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ShimmerLoading(
                        widget: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: 70,
                            height: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 130,
                        child: ShimmerLoadingMenus(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ShimmerLoading(
                        widget: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            width: 60,
                            height: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ShimmerLoading(
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ShimmerLoading(
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ShimmerLoading(
                        widget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const ShimmerLoadingReview(),
                    ],
                  ),
                ),
                ShimmerLoading(
                  widget: Container(
                    margin: const EdgeInsets.only(top: 45),
                    child: const CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
