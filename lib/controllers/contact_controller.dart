import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/app_colors.dart'; // તમારી કલર ફાઈલનો પાથ ભાઈ

class ContactController extends GetxController {
  // લોડિંગ સ્ટેટ મેનેજ કરવા માટે ભાઈ
  var isLoading = false.obs;

  // ⚡ જાદુઈ ફંક્શન: જે તમારા હોસ્ટિંગર સર્વર પર ડેટા પોસ્ટ કરશે ભાઈ
  Future<void> submitContactForm({
    required String name,
    required String email,
    required String city,
    required String mobile,
    required String subject,
    required String message,
    required VoidCallback onSuccess,
  }) async {
    // હોસ્ટિંગરની લાઈવ API નો પાથ ભાઈ
    final String apiUrl = "https://rajyapurohitjamnagar.in/api/contact_msg.php";

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "name": name,
          "email": email,
          "city": city,
          "mobile": mobile,
          "subject": subject,
          "message": message,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final resData = json.decode(response.body);
        if (resData["status"] == "success") {
          // સક્સેસ સ્નેકબાર ભાઈ
          Get.snackbar(
            'Success',
            'Your message has been sent successfully! Alert dispatched.',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            maxWidth: 500,
            margin: const EdgeInsets.all(15),
          );
          onSuccess(); // ફોર્મ ક્લીન કરવા માટે કોલબેક રન થશે ભાઈ
        } else {
          _showErrorSnackbar(resData["message"] ?? "Something went wrong.");
        }
      } else {
        _showErrorSnackbar("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      _showErrorSnackbar("Connection failure: Could not connect to API.");
      print("ડખો થયો ભાઈ: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorSnackbar(String msg) {
    Get.snackbar(
      'Error',
      msg,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      maxWidth: 500,
      margin: const EdgeInsets.all(15),
    );
  }
}