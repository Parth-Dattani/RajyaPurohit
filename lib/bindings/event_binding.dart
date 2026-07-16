import 'package:get/get.dart';
import '../controllers/event_controller.dart'; // તમારો સાચો કંટ્રોલર પાથ ભાઈ

class EventBinding extends Bindings {
  @override
  void dependencies() {
    // ➔ ⚡ સ્ક્રીન ઓપન થતાં જ કંટ્રોલરને મેમરીમાં ઇન્જેક્ટ કરવા માટે
    Get.lazyPut<EventController>(() => EventController());
  }
}