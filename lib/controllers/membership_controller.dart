import 'package:get/get.dart';

import '../bindings/bindings.dart';
import '../screen/membership/registration_stepper_screen.dart';

class MembershipController extends GetxController {
  // બટન પર ક્લિક થતાં જે એક્શન કે રાઉટિંગ કરાવવું હોય તેના હેલ્પર ફંક્શન્સ
  void startNewRegistration() {
    Get.to(
          () => const RegistrationStepperScreen(),
      binding: RegistrationBinding(), // ✅ આ લાઇન ઉમેરી દો ભાઈ (ફાઈલ ઉપર ઈમ્પોર્ટ કરી લેવી)
    );
  }

  void loginExistingMember() {
    // Get.toNamed('/LoginScreen');
  }

  void downloadMobileApp() {
    // પ્લેસ્ટોર કે લિંક ઓપન કરવા માટે
  }
}