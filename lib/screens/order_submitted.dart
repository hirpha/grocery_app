import 'package:flutter/material.dart';
import 'package:grocery_app/utils/colors.dart';

class OrderSubmit extends StatelessWidget {
  static String routeName = "/order-submitted";
  const OrderSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Container(),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Thank you",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 100,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .5,
                child: Image.asset("assets/images/thankyou.png"),
              ),
              const Text(
                "Your order in progress",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * .8,
                child: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                    textAlign: TextAlign.center),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 236, 235, 235),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    elevation: 0,
                    backgroundColor: ColorProvider().lightYellow),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "GO BACK HOME",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
