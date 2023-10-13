import 'package:flutter/material.dart';
import 'package:grocery_app/screens/order_submitted.dart';
import 'package:grocery_app/utils/colors.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget item(String name, String type, int price, int amount) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(10),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/placeholderbanner.png",
                    ))),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                            color: Colors.black12,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$$price",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 230, 131, 17),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 209, 208, 208),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.remove,
                                color: ColorProvider().lightGrey,
                                size: 30,
                              ),
                            ),
                            const Text(
                              '3',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: ColorProvider().lightGrey,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            "Items Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
      body: ListView(
        children: [
          item('Fruits', "Banana", 23, 4),
          item('Fruits', "Banana", 23, 4),
          item('Fruits', "Banana", 23, 4),
          item('Fruits', "Banana", 23, 4),
          Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text("Total \$6.6")),
          Container(
              height: 60,
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      backgroundColor: ColorProvider().lightYellow),
                  onPressed: () {
                    Navigator.pushNamed(context, OrderSubmit.routeName);
                  },
                  child: const Text(
                    "PLACE ORDER",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
