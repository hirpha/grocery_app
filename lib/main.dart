import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/product/product_bloc.dart';
import 'package:grocery_app/repository/auth_repo.dart';
import 'package:grocery_app/repository/category_repo.dart';
import 'package:grocery_app/repository/product_repo.dart';
import 'package:grocery_app/route/app_route.dart';
import 'package:grocery_app/screens/splash/splash.dart';
import 'package:grocery_app/utils/colors.dart';
import 'package:http/http.dart' as http;

import 'bloc/Auth/auth_bloc.dart';
import 'bloc/category/category_bloc.dart';

void main() {
  final AuthRepository authRepository =
      AuthRepository(httpClient: http.Client());
  final CategoryRepository categoryRepository =
      CategoryRepository(httpClient: http.Client());
  final ProductRepository productRepository =
      ProductRepository(httpClient: http.Client());
  runApp(MyApp(
    authRepository: authRepository,
    categoryRepository: categoryRepository,
    productRepository: productRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  const MyApp({
    super.key,
    required this.authRepository,
    required this.categoryRepository,
    required this.productRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: categoryRepository),
        RepositoryProvider.value(value: productRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository: authRepository),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(categoryRepository: categoryRepository)
                  ..add(CategoryLoad()),
          ),
          BlocProvider(
            create: (context) =>
                ProductBloc(productRepository: productRepository),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: ColorProvider().lightYellow,
            primarySwatch: Colors.yellow,
          ),
          onGenerateRoute: AppRoute.generateRoute,
        ),
      ),
    );
  }
}
