import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category/category_bloc.dart';
import 'package:grocery_app/bloc/product/product_bloc.dart';
import 'package:grocery_app/models/product.dart';
import 'package:grocery_app/screens/cart.dart';
import 'package:grocery_app/screens/category/category.dart';
import 'package:grocery_app/screens/favorite.dart';
import 'package:grocery_app/screens/profile.dart';
import 'package:grocery_app/utils/Session.dart';
import 'package:grocery_app/utils/end_points.dart';

import '../../bloc/category/category_event.dart';
import '../../bloc/category/category_state.dart';
import '../../bloc/product/product_event.dart';
import '../../bloc/product/product_state.dart';
import '../../utils/colors.dart';
import '../../widgets/product.dart';
import '../product_detail.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      BlocProvider.of<ProductBloc>(context).add(ProductsLoadEvent());
      BlocProvider.of<CategoryBloc>(context).add(CategoryLoad());
    }
    if (_selectedIndex == 1) {
      BlocProvider.of<CategoryBloc>(context).add(CategoryLoad());
    }
  }

  Widget body() {
    Widget returnWidget = home();
    switch (_selectedIndex) {
      case 0:
        returnWidget = home();
        break;
      case 1:
        returnWidget = const CategoryScreen();
        break;
      case 2:
        returnWidget = const CartScreen();
        break;
      case 3:
        returnWidget = const FavoriteScreen();
        break;
      case 4:
        returnWidget = const ProfileScreen();
        break;
      default:
        returnWidget = body();
    }

    return returnWidget;
  }

  Widget home() {
    var size = MediaQuery.of(context).size;
    final double itemHeight =
        (size.height - kToolbarHeight - size.height * .45) / 2;
    final double itemWidth = size.width / 2;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Good morning",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorProvider().blackLigth),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rafatul Islam",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorProvider().black),
                ),
                Container(
                  height: 40,
                  width: 40,
                  child: Stack(
                    children: [
                      const Positioned(
                        right: 0,
                        left: 0,
                        child: Icon(
                          Icons.notifications,
                        ),
                      ),
                      Positioned(
                          right: 10,
                          top: 2,
                          child: Icon(
                            Icons.circle,
                            color: ColorProvider().lightYellow,
                            size: 10,
                          ))

                      // Positioned(child: child)
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = 1;
                              });
                              BlocProvider.of<CategoryBloc>(context)
                                  .add(CategoryLoad());
                            },
                            icon: const Icon(Icons.arrow_forward))
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                        Session().logSession("state...", state.toString());
                        if (state is CategoryLoadSuccess) {
                          Session().logSession("state...", state.toString());
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(
                                          5.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius:
                                            2.0, // horizontal, vertical offset
                                      ),
                                    ],
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: imageBaseUrl +
                                        state.categories![index].primaryImage!,
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
                                    placeholder: (context, url) => Center(
                                        child: Container(
                                            height: 20,
                                            width: 20,
                                            child:
                                                const CircularProgressIndicator())),
                                    errorWidget: (context, url, error) {
                                      return const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: 50,
                                      );
                                    },
                                  ),
                                );
                              },
                              itemCount: state.categories!.length);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "Latest Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .54,
                child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                  if (state is ProductsLoadEventSuccess) {
                    return GridView.count(
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisCount: 2,
                        controller:
                            new ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        children: state.product!
                            .map((pro) => InkWell(
                                onTap: () {
                                  BlocProvider.of<ProductBloc>(context)
                                      .add(ProductLoad(id: pro.id));
                                  Navigator.pushNamed(
                                      context, ProductDetail.routeName);
                                },
                                child: ProductWidget(product: pro)))
                            .toList()

                        // Add more items as needed

                        );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: ColorProvider().lightYellow,
        unselectedItemColor: const Color.fromARGB(146, 8, 8, 8),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
