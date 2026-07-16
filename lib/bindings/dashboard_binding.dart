import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // ➔ ⚡ ડેશબોર્ડ ઓપન થતાં જ કંટ્રોલર લાઈવ ઇન્જેક્ટ થઈ જશે ભાઈ
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}