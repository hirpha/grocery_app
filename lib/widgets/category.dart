import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/category.dart';

import '../utils/colors.dart';
import '../utils/end_points.dart';

class CategoryWidget extends StatelessWidget {
  Category category;
  CategoryWidget({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(
            5.0,
            5.0,
          ),
          blurRadius: 10.0,
          spreadRadius: 2.0,
        ),
      ]),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: CachedNetworkImage(
                imageUrl: imageBaseUrl + category.primaryImage!,
                imageBuilder: (
                  context,
                  imageProvider,
                ) =>
                    Container(
                  width: double.infinity,
                  height: double.infinity,
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
            ),
          ),
          Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    category.name!,
                    style: TextStyle(
                      color: ColorProvider().orange,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ))),
        ],
      ),
    );
  }
}
