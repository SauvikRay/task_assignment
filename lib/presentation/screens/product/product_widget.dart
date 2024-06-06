import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_space.dart';
import '../../../app/config/app_text_styles.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      width: 160,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color(0xff395AB8).withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Image.asset(
              'assets/model.png',
              fit: BoxFit.contain,
            )),
            SizedBox(
              height: 115,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This is the very very important Productvery important Product',
                      style: AppTextStyles.productText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SpaceHepler.verticalSpace(8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '\$150',
                          style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 15, color: AppColors.disabledColor),
                        ),
                        SpaceHepler.horizontalSmall,
                        Text(
                          '\$150',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                    SpaceHepler.verticalSmall,
                    RatingBar.builder(
                      itemSize: 15,
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
