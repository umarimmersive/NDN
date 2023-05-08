import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/dashboard_screen/Home_view.dart';

import '../dashboard/views/dashboard_view.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({Key? key}) : super(key: key);

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Get.offAll( DashboardView()));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Image.asset(
              'assets/20943863.jpg',
              scale: 0.1,
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 150,
          ),
          const Text(
            "Order Placed Successfully",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
