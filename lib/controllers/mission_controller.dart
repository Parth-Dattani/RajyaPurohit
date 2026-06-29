import 'package:get/get.dart';

class MissionController extends GetxController {
  // ભવિષ્યમાં જો ડેટાબેઝ કે API માંથી ઈમેજો કે લખાણ લાવવું હોય તો અહીં હેન્ડલ થશે
  final RxString currentMenu = 'અમારો ઉદ્દેશ'.obs;

  void changeMenu(String title) {
    currentMenu.value = title;
  }
}