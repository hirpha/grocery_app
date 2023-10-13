import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/product/product_bloc.dart';
import 'package:grocery_app/utils/colors.dart';
import 'package:onboarding_animation/onboarding_animation.dart';

import '../bloc/category/category_bloc.dart';
import '../bloc/category/category_event.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../utils/end_points.dart';

class ProductDetail extends StatefulWidget {
  static String routeName = "/product-detail";
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<ProductBloc>(context).add(ProductsLoadEvent());
        BlocProvider.of<CategoryBloc>(context).add(CategoryLoad());
        return true;
      },
      child: Scaffold(body:
          BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoadSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Stack(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .4,
                    child: Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: OnBoardingAnimation(
                        indicatorExpansionFactor: 4,
                        indicatorStrokeWidth: 6,
                        indicatorInActiveDotDecoration: const DotDecoration(
                          height: 20,
                          verticalOffset: 20,
                        ),
                        indicatorFixedCenter: true,
                        pages: state.product!.detailImages
                            .map(
                              (emages) => CachedNetworkImage(
                                imageUrl: imageBaseUrl + emages!,
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
                                      fit: BoxFit.cover,
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
                            )
                            .toList(),
                        indicatorDotHeight: 7.0,
                        indicatorDotWidth: 7.0,
                        indicatorType: IndicatorType.expandingDots,
                        indicatorPosition: IndicatorPosition.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                      left: 10,
                      top: 20,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<ProductBloc>(context)
                                .add(ProductsLoadEvent());
                            BlocProvider.of<CategoryBloc>(context)
                                .add(CategoryLoad());
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          )))
                ]),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.product!.name!,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .3,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: ColorProvider().lightYellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {},
                              child: const Text(
                                "ADD TO CART",
                              )),
                        )
                      ]),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${state.product!.singleDeal!.originalPrice!}",
                        style: TextStyle(
                            color: ColorProvider().lightYellow,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove,
                            color: ColorProvider().lightYellow,
                            size: 30,
                          ),
                        ),
                        Text(
                          state.product!.singleDeal!.availableQuantity!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: ColorProvider().lightYellow,
                            size: 30,
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: const Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Divider(
                              thickness: 2,
                              color: ColorProvider().lightYellow,
                              height: 10,
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Color.fromARGB(255, 197, 197, 197),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        state.product!.longDescription!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      })),
    );
  }
}
