import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:national_digital_notes_new/views/specific_book_details_screen/add_address_screen.dart';

import '../../controllers/address_controller.dart';

class AllAddressScreen extends StatefulWidget {
  const AllAddressScreen({Key? key}) : super(key: key);

  @override
  State<AllAddressScreen> createState() => _AllAddressScreenState();
}

class _AllAddressScreenState extends State<AllAddressScreen> {
  AddressController addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Address"),
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (addressController.addedAddressList.isEmpty)
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                alignment: Alignment.center,
                child: const Text("No Address found !"),
              ),
            if (addressController.addedAddressList.isNotEmpty)
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: addressController.addedAddressList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        addressController.indexOfTile.value = index;
                      },
                      leading: const Icon(Icons.gps_fixed),
                      title: Text(
                          "${addressController.addedAddressList[index]['name']}, ${addressController.addedAddressList[index]['fullAddress']}"),
                      subtitle: Text(
                          "${addressController.addedAddressList[index]['houseNumber']}, ${addressController.addedAddressList[index]['city']}, ${addressController.addedAddressList[index]['state']}"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 16,
                      ),
                    );
                  }),
            const Spacer(),
            SizedBox(
              height: 60,
              width: double.maxFinite,
              child: ElevatedButton(
                child: const Text("Add Address"),
                onPressed: () {
                  Get.to(const AddAddressScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
