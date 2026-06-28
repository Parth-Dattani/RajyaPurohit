import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedMenu = 'હોમ'.obs;

  void changeMenu(String menuName) {
    selectedMenu.value = menuName;
  }
}