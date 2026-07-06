import 'package:get/get.dart';

import '../controllers/controller.dart';
// ⚠️ તમારા કંટ્રોલરનો પાથ અહીંયા સેટ કરજો ભાઈ

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    // પેજ ઓપન થાય ત્યારે જ કંટ્રોલર મેમરીમાં ઇન્જેક્ટ થશે ભાઈ
    Get.lazyPut<RegistrationController>(() => RegistrationController());
  }
}