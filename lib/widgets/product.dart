import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';

import '../utils/colors.dart';
import '../utils/end_points.dart';

class ProductWidget extends StatelessWidget {
  Product product;
  ProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Stack(children: [
        Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 50,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imageBaseUrl + product.primaryImage!,
                imageBuilder: (
                  context,
                  imageProvider,
                ) =>
                    Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator())),
                errorWidget: (context, url, error) {
                  return const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 50,
                  );
                },
              ),
            )),
        Positioned(
            left: 10,
            top: 10,
            child: Icon(Icons.favorite,
                color: product.favorite == true
                    ? ColorProvider().pink
                    : Colors.grey)),
        Positioned(
            right: 0,
            bottom: -10,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$${product.singleDeal!.originalPrice!}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: ColorProvider().red),
                        onPressed: () {},
                        child: const Text("Add to cart"))
                  ],
                ),
              ],
            ))
      ]),
    );
  }
}
