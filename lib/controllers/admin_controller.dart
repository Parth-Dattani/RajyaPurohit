import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rajya_purohit/utils/shared_preferences_helper.dart';

class AdminController extends GetxController {
  var userList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    try {
      isLoading.value = true;
      // લોગિન થયેલ યુઝરની ID ડેશબોર્ડમાંથી અથવા સ્ટોરેજમાંથી મેળવો
      // લાઇન ૨૧ માં આ ફેરફાર કરો:
      final cachedData = sharedPreferencesHelper.getPrefData('cached_user') ?? '{}';
      final adminData = jsonDecode(cachedData);

      final response = await http.post(
        Uri.parse("https://rajyapurohitjamnagar.in/api/get_users.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'admin_id': adminData['id']}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userList.assignAll(List<Map<String, dynamic>>.from(data['users']));
      } else {
        Get.snackbar("ભૂલ ❌", "ડેટા લાવવામાં નિષ્ફળતા!");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyUser(int userId, int status) async {
    try {
      final response = await http.post(
        Uri.parse("https://rajyapurohitjamnagar.in/api/verify_user.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'user_id': userId, 'status': status}),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          "સફળ",
          status == 1 ? "સભ્ય વેરિફાઈ થઈ ગયા છે!" : "સભ્યનું વેરિફિકેશન રદ કર્યું છે.",
          backgroundColor: status == 1 ? Colors.green : Colors.orange,
          colorText: Colors.white,
        );
        fetchAllUsers(); // લિસ્ટ રિફ્રેશ કરો
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar("ભૂલ ❌", "કનેક્શન લોચો થયો છે!");
    }
  }
}