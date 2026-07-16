import 'package:get/get.dart';

import '../bindings/bindings.dart';
import '../screen/membership/registration_stepper_screen.dart';
import 'controller.dart';
import 'package:get/get.dart';
import '../bindings/registration_binding.dart';
import '../controllers/registration_controller.dart';

class MembershipController extends GetxController {

  // ==========================================
  // 🔵 ૧. નવું સભ્ય નોંધણી ફોર્મ શરૂ કરવાનો ફ્લો ભાઈ
  // ==========================================
  void startNewRegistration() {
    // જો કંટ્રોલર ઓલરેડી મેમરીમાં પડ્યો હોય, તો એના જૂના ડેટા અને ફિલ્ડ્સને ક્લીન કરી નાખવા ભાઈ
    try {
      if (Get.isRegistered<RegistrationController>()) {
        final regController = Get.find<RegistrationController>();
        regController.isOldUser.value = false;

        // પેલા ટેક્સ્ટ કંટ્રોલર્સ સાફ કરવા માટે
        regController.phoneController.clear();
        regController.emailController.clear();
        regController.passwordController.clear();
        regController.confirmPasswordController.clear();
      }
    } catch (_) {}

    Get.to(
          () => const RegistrationStepperScreen(),
      binding: RegistrationBinding(),
      arguments: "NEW_REGISTRATION", // ➔ ⚡ સ્પષ્ટ સિગ્નલ લોક ભાઈ
    );
  }

  // ==========================================
  // 🟠 ૨. જૂના સભ્યો માટે ડાયરેક્ટ લોગિન મોડ ઓપન જુગાડ ભાઈ
  // ==========================================
  void loginExistingMember() {
    // ➔ ⚡ ⚡ ગેટએક્સ સ્ટાન્ડર્ડ ફિક્સ: ડાયરેક્ટ આર્ગ્યુમેન્ટ્સથી જ સ્ટેટ પાસ કરવો સેફ છે ભાઈ!
    Get.to(
          () => const RegistrationStepperScreen(),
      binding: RegistrationBinding(),
      arguments: "DIRECT_LOGIN", // આપણે આર્ગ્યુમેન્ટ તરીકે સિગ્નલ મોકલીશું
    );
  }

  // ==========================================
  // 📲 ૩. મોબાઈલ એપ્લિકેશન ડાઉનલોડ લિંક ફ્લો
  // ==========================================
  void downloadMobileApp() {
  }
}
