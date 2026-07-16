import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // ➔ ⚡ લોગિન સ્ક્રીન ઓપન થતાં જ લોગિન કંટ્રોલર મેમરીમાં ઇન્જેક્ટ થઈ જશે ભાઈ!
    Get.lazyPut<LoginController>(() => LoginController());
  }
}