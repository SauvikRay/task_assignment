import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_space.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../data/models/product_response.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product
  });
  final Product product;

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
                child: CachedNetworkImage(
            key: UniqueKey(),
            errorWidget: (context, url, error) => Image.asset(
              "assets/default.png",
              fit: BoxFit.cover,
            ),
            fit: BoxFit.contain,
            imageUrl: product.images?.first.src.toString()??'',
            repeat: ImageRepeat.noRepeat,
            imageBuilder: (context, imageProvider) {
              log('Cached Newtowk image build multiple');
              return Container(decoration: (BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.contain))));
            },
            placeholder: (context, url) => const Center(child: CupertinoActivityIndicator()),
          )),
            SizedBox(
              height: 115,
              width: double.infinity,
              child: Padding(
                padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'This is the very very important Productvery important Product',
                      product.name??'',
                      style: AppTextStyles.productText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SpaceHepler.verticalSpace(8),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                      product.regularPrice =='' ? '':'\$${product.regularPrice??''}',
                          style:const TextStyle(decoration: TextDecoration.lineThrough, fontSize: 15, color: AppColors.disabledColor),
                        ),
                        SpaceHepler.horizontalSmall,
                        Text(
                          '\$${product.price??0.0}',
                          style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                    SpaceHepler.verticalSmall,
                    RatingBar.builder(
                      itemSize: 15,
                      initialRating: double.tryParse(product.ratingCount.toString())??0.0,
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
