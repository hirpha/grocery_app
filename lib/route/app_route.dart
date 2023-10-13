import 'package:flutter/material.dart';
import 'package:grocery_app/screens/home/home.dart';
import 'package:grocery_app/screens/splash/splash.dart';

import '../screens/category/category.dart';
import '../screens/order_submitted.dart';
import '../screens/product_detail.dart';
import '../screens/signin/signin.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == SigninScreen.routeName) {
      return MaterialPageRoute(builder: (context) => const SigninScreen());
    }
    if (settings.name == CategoryScreen.routeName) {
      return MaterialPageRoute(builder: (context) => const CategoryScreen());
    }
    if (settings.name == OrderSubmit.routeName) {
      return MaterialPageRoute(builder: (context) => const OrderSubmit());
    }
    if (settings.name == ProductDetail.routeName) {
      return MaterialPageRoute(builder: (context) => const ProductDetail());
    }
    if (settings.name == HomeScreen.routeName) {
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    } else {
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
