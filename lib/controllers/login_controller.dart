import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/shared_preferences_helper.dart'; // 👈 તમારા હેલ્પરનો સાચો પાથ ભાઈ

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false.obs;

  Future<void> loginWithEmailPassword() async {
    final String loginUrl = "https://rajyapurohitjamnagar.in/api/login.php";

    // ૧. ફ્રન્ટએન્ડ વેલિડેશન ચેક ભાઈ
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      Get.snackbar(
          "વિગત ખૂટે છે ભાઈ",
          "કૃપા કરીને ઈમેલ અને પાસવર્ડ બંને દાખલ કરો.",
          backgroundColor: Colors.amber.shade800,
          colorText: Colors.white
      );
      return;
    }

    try {
      isLoading.value = true;

      final Map<String, dynamic> credentials = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim()
      };

      // ૨. લાઈવ PHP API પર POST રિક્વેસ્ટ રવાના ભાઈ
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(credentials),
      );

      isLoading.value = false;
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {

        // ➔ ⚡ ⚡ અસલી જાદુ: તમારા SharedPreferencesHelper દ્વારા સેશન અને જેસન ડેટા કન્વર્ટ કરીને લોક ભાઈ!
        await sharedPreferencesHelper.storeBoolPrefData('isLoggedIn', true);

        await sharedPreferencesHelper.storePrefData('cached_user', jsonEncode(responseData['user_data']));
        await sharedPreferencesHelper.storePrefData('cached_maternal', jsonEncode(responseData['maternal_data']));
        await sharedPreferencesHelper.storePrefData('cached_family', jsonEncode(responseData['family_members']));

        // ૩. યુઝરને સીધા ડેશબોર્ડ સ્ક્રીન પર મોકલી દો ભાઈ
        Get.offAllNamed('/DashboardScreen');

        Get.snackbar(
            "લોગિન સફળ ભાઈ!",
            "તમારા પરિવારનો આખો ડેટા લાઈવ સિંક થઈ ગયો છે.",
            backgroundColor: Colors.green,
            colorText: Colors.white
        );
      } else {
        Get.snackbar(
            "લોગિન નિષ્ફળ ભાઈ",
            responseData['message'] ?? "ખોટો ઈમેલ અથવા પાસવર્ડ.",
            backgroundColor: Colors.red.shade800,
            colorText: Colors.white
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
          "નેટવર્ક એરર",
          "સર્વર જોડાણ લોચો: $e",
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}