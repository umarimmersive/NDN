import 'package:get/get.dart';

class CheckboxItem {
  final String title;
  bool value;

  CheckboxItem({required this.title, required this.value});
}

class CheckboxesController extends GetxController {
  var checkboxes = [
    CheckboxItem(title: 'Checkbox 1', value: false),
    CheckboxItem(title: 'Checkbox 2', value: false),
    CheckboxItem(title: 'Checkbox 3', value: false),
  ].obs;
}
