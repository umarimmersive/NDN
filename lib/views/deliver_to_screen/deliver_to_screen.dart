import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/order_placed_screen/order_placed_view.dart';
import 'package:national_digital_notes_new/views/specific_book_details_screen/add_address_screen.dart';

class DeliverToScreen extends StatefulWidget {
  const DeliverToScreen({Key? key}) : super(key: key);

  @override
  State<DeliverToScreen> createState() => _DeliverToScreenState();
}

class _DeliverToScreenState extends State<DeliverToScreen> {
  var value = '1';
  var test = true;

  void callNextScreen() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      test = true;
      Get.to(const OrderPlaced());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a delivery address'),
      ),
      body: test == false
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            )
          : Column(
              children: [
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Radio(
                                value: true,
                                groupValue: value,
                                onChanged: (_) {}),
                          ),
                          Expanded(
                            flex: 7,
                            child: ListTile(
                              onTap: () {},
                              title: const Text("Tanmay"),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                      "604, Immersive Infotech, Atulya IT park, Indore"),
                                  Text("452001"),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Radio(
                                value: test,
                                groupValue: value,
                                onChanged: (value) {}),
                          ),
                          Expanded(
                            flex: 7,
                            child: ListTile(
                              onTap: () {},
                              title: const Text("Ali"),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                      "604, Immersive Infotech, Atulya IT park, Indore"),
                                  Text("452001"),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Radio(
                                value: true,
                                groupValue: value,
                                onChanged: (_) {}),
                          ),
                          Expanded(
                            flex: 7,
                            child: ListTile(
                              onTap: () {},
                              title: const Text("Nikhil"),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                      "604, Immersive Infotech, Atulya IT park, Indore"),
                                  Text("452001"),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.to(const AddAddressScreen());
                    },
                    child: const Icon(Icons.add)),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      test = false;
                      callNextScreen();
                    },
                    child: const Text(
                      "CHECKOUT",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
