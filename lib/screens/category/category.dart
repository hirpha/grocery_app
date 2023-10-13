import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category/category_bloc.dart';
import 'package:grocery_app/widgets/category.dart';

import '../../bloc/category/category_state.dart';
import '../../bloc/product/product_bloc.dart';
import '../../widgets/product.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = "/category=-screen";
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight =
        (size.height - kToolbarHeight - size.height * .5) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Categories",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * .9,
          child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
            if (state is CategoryLoadSuccess) {
              return GridView.count(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 2,
                  controller: new ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  children: state.categories!
                      .map((cat) => CategoryWidget(category: cat))
                      .toList());
            }

            return Container(
              margin: const EdgeInsets.only(top: 100),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          })),
    );
  }
}
