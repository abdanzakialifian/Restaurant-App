import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/style/color.dart';
import 'package:restaurant_app/utils/globals.dart';

class ListReview extends StatelessWidget {
  final DetailRestaurantProvider provider;
  final String from;

  const ListReview({Key? key, required this.provider, required this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomerReviewResponse> listReview = [];
    from == Globals.fromDetail
        ? listReview = provider
                .restaurantResultResponse.customerReviews?.reversed
                .toList() ??
            []
        : listReview = provider.customerReviewResponse.reversed.toList();

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      shrinkWrap: true,
      separatorBuilder: (context, index) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: const Divider(
          thickness: 0.3,
          color: darkGrey,
        ),
      ),
      itemCount: listReview.length,
      itemBuilder: (context, index) {
        CustomerReviewResponse review = listReview[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: darkGreen,
                  child: Text(
                    review.name?.substring(0, 1).toUpperCase() ?? "",
                    style: const TextStyle(
                      fontFamily: "Poppins Medium",
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    review.name ?? "",
                    style: const TextStyle(
                      fontFamily: "Poppins Medium",
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              review.date ?? "",
              style: const TextStyle(
                fontFamily: "Poppins Regular",
                color: darkGrey,
                fontSize: 10,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              review.review ?? "",
              style: const TextStyle(
                fontFamily: "Poppins Regular",
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }
}
