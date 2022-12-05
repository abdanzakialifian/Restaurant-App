import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/globals/shimmer_loading.dart';

class ShimmerLoadingReview extends StatelessWidget {
  const ShimmerLoadingReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ShimmerLoading(
                  widget: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ShimmerLoading(
                  widget: Container(
                    width: 100,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            ShimmerLoading(
              widget: Container(
                width: 70,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ShimmerLoading(
              widget: Expanded(
                child: Container(
                  height: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ShimmerLoading(
              widget: Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
