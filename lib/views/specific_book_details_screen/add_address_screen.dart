import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/controllers/address_controller.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController fullAddress = TextEditingController();
  TextEditingController cityAddress = TextEditingController();
  TextEditingController stateAddress = TextEditingController();
  TextEditingController pinCode = TextEditingController();

  AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: houseNumber,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'House No.',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: fullAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Full Address',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: pinCode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Pin Code',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: cityAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'City',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: stateAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'State',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  addressController.fullAddress.value = fullAddress.text;
                  addressController.name.value = nameController.text;
                  addressController.houseNumber.value = houseNumber.text;
                  addressController.city.value = cityAddress.text;
                  addressController.state.value = stateAddress.text;
                  addressController.pincode.value = pinCode.text;
                  addressController.addAddress();
                  Get.back();
                },
                child: const Text("Add address"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
