import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/product/product_bloc.dart';
import 'package:grocery_app/screens/home/home.dart';
import 'package:grocery_app/screens/signin/signin.dart';
import 'package:grocery_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/category/category_bloc.dart';
import '../../bloc/category/category_event.dart';
import '../../bloc/product/product_event.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash-screen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  gotoSignIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    if (token != null) {
      Future.delayed(const Duration(seconds: 3), () {
        BlocProvider.of<CategoryBloc>(context).add(CategoryLoad());
        BlocProvider.of<ProductBloc>(context).add(ProductsLoadEvent());
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, SigninScreen.routeName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ColorProvider().lightYellow,
      statusBarColor: ColorProvider().lightYellow,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    gotoSignIn();
    return Scaffold(
      backgroundColor: ColorProvider().lightYellow,
      body: Container(
        color: ColorProvider().lightYellow,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * .15),
                child: Image.asset("assets/images/fruits.png"))
          ],
        ),
      ),
    );
  }
}
