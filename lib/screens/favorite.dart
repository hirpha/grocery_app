import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:grocery_app/utils/colors.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

Widget item(String name, String type, double price, int amount) {
  return Container(
    height: 120,
    margin: EdgeInsets.all(10),
    alignment: Alignment.bottomLeft,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "assets/images/placeholderbanner.png",
                  ))),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$" + price.toString(),
                    style: TextStyle(
                        color: ColorProvider().lightYellow,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 229, 229),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Add to cart"))
              ],
            )
          ],
        ))
      ],
    ),
  );
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Favorite's",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
      body: ListView(children: [
        item('Fruits', "Banana", 23.6, 4),
        item('Fruits', "Banana", 23.5, 4),
        item('Fruits', "Banana", 23.7, 4),
        item('Fruits', "Banana", 23.7, 4),
        item('Fruits', "Banana", 23.8, 4),
        item('Fruits', "Banana", 23.9, 4),
      ]),
    );
  }
}
