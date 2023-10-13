import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/bloc/category/category_bloc.dart';
import 'package:grocery_app/widgets/category.dart';

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
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Categories"),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
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
                      .toList()

                  // Add more items as needed

                  );
            }

            return Container(
              margin: EdgeInsets.only(top: 100),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          })),
    );
  }
}
 // SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     margin: EdgeInsets.only(top: 20),
          //     child: Row(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Icon(Icons.arrow_back),
          //         Text(
          //           "Categories",
          //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //         )
          //       ],
          //     ),
          //   ),
          // ),