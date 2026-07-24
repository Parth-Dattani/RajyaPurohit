import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final selectedMenu = 'હોમ'.obs;
  final RxBool isHistoryExpanded = false.obs;
  RxInt visitorCount = 1.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLiveVisitorCount();
  }

  void fetchLiveVisitorCount() async {
    try {
      final response = await http.get(Uri.parse('https://rajyapurohitjamnagar.in/api/visitor_count.php'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          visitorCount.value = data['visitors'];
        }
      }
    } catch (e) {
      debugPrint("Visitor count error: $e");
    }
  }

  void changeMenu(String menuName) {
    selectedMenu.value = menuName;
  }
}