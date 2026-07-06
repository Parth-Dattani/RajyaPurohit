import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  var currentStep = 0.obs;
  var isLoading = false.obs;

  // ==========================================
  // 📝 UNIQUE TEXT EDITING CONTROLLERS
  // ==========================================
  // Step 1: Mobile verification
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  // Step 2: Primary Info
  final firstNameController = TextEditingController();
  final fatherHusbandController = TextEditingController();
  final motherNameController = TextEditingController();
  final surnameController = TextEditingController();

  // Step 2 & Step 3: Address & Locations (Completely Separated)
  final currentAddressController = TextEditingController();
  final currentDistrictController = TextEditingController();
  final currentTalukaController = TextEditingController();
  final currentCityVillageController = TextEditingController();
  final pincodeController = TextEditingController();
  final nativeVillageController = TextEditingController();

  // Step 3: Split BirthDate Controllers
  final birthDayController = TextEditingController();
  final birthMonthController = TextEditingController();
  final birthYearController = TextEditingController();

  // Step 3: Maternal / Mosal Details (Completely Separated from Main Profile)
  final maternalFatherController = TextEditingController();
  final maternalMotherController = TextEditingController();
  final maternalAddressController = TextEditingController();
  final maternalSurnameController = TextEditingController();
  final maternalVillageController = TextEditingController();

  // ==========================================
  // 🔄 REACTIVE DROPDOWN & NAVIGATION STATES
  // ==========================================
  var selectedGender = 'Male'.obs;
  var selectedMaritalStatus = 'Single'.obs;
  var selectedRelation = 'Self'.obs;
  var selectedGotraId = '1'.obs;
  var selectedVillageId = '1'.obs;

  // Reactive states for Education and Occupation dropdown selections
  var selectedEducation = 'Select Option'.obs;
  var selectedOccupation = 'Select Option'.obs;

  // Generational Tree Technical Flags
  var isMarriedSon = false.obs;
  var parentFamilyId = 5001.obs;

  // Live Gotras Master Lookup List Array
  var gotrasList = <Map<String, dynamic>>[].obs;
  var isGotrasLoading = false.obs;

  // Dynamic Family Members Logic States
  var familyCount = 0.obs;
  var familyMembers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch live gotras master lookup data automatically on initialization
    fetchLiveGotras();
  }

  // ==========================================
  // 🌐 FETCH LIVE GOTRAS MASTER LOOKUP DATA
  // ==========================================
  Future<void> fetchLiveGotras() async {
    final String gotraApiUrl = "https://rajyapurohitjamnagar.in/api/get_gotras.php";
    try {
      isGotrasLoading.value = true;
      final response = await http.get(Uri.parse(gotraApiUrl));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['status'] == 'success' && decodedData['data'] != null) {
          gotrasList.assignAll(List<Map<String, dynamic>>.from(decodedData['data']));

          // Set initial default selection safely if master lookup is not empty
          if (gotrasList.isNotEmpty) {
            selectedGotraId.value = gotrasList.first['id'].toString();
          }
        }
      } else {
        Get.snackbar("Master Data Error", "Failed to load gotras lookup list.");
      }
    } catch (e) {
      Get.snackbar("Network Error", "Gotras fetch connection failed: $e");
    } finally {
      isGotrasLoading.value = false;
    }
  }

  // ==========================================
  // 👥 DYNAMIC FAMILY MEMBERS MAPPING LOGIC
  // ==========================================
  void updateFamilyCount(int count) {
    familyCount.value = count;
    if (familyMembers.length < count) {
      int fieldsToAdd = count - familyMembers.length;
      for (int i = 0; i < fieldsToAdd; i++) {
        familyMembers.add({
          'nameController': TextEditingController(),
          'relation': 'પસંદ કરો',
          'dayController': TextEditingController(),
          'monthController': TextEditingController(),
          'yearController': TextEditingController(),
          'phoneController': TextEditingController(),
        });
      }
    } else if (familyMembers.length > count) {
      while (familyMembers.length > count) {
        var removedMember = familyMembers.removeLast();
        removedMember['nameController']?.dispose();
        removedMember['dayController']?.dispose();
        removedMember['monthController']?.dispose();
        removedMember['yearController']?.dispose();
        removedMember['phoneController']?.dispose();
      }
    }
  }

  // ==========================================
  // 🔄 STEP NAVIGATION CONTROLS
  // ==========================================
  void nextStep() {
    if (currentStep.value == 0) {
      currentStep.value = 1; // Direct screen bypass for OTP step
    }
    else if (currentStep.value < 4) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  // ==========================================
  // 💾 SUBMIT NODE DATA TO LIVE SQL DATABASE
  // ==========================================
  // ==========================================
  // 💾 SUBMIT NODE DATA TO LIVE SQL DATABASE
  // ==========================================
  Future<void> submitMemberToLiveSQL() async {
    final String apiUrl = "https://rajyapurohitjamnagar.in/api/add_member.php";

    try {
      isLoading.value = true;

      // Construct proper YYYY-MM-DD MySQL date standard securely
      String yyyy = birthYearController.text.trim().isEmpty ? "1995" : birthYearController.text.trim();
      String mm = birthMonthController.text.trim().isEmpty ? "01" : birthMonthController.text.trim();
      String dd = birthDayController.text.trim().isEmpty ? "01" : birthDayController.text.trim();
      String fullBirthDate = "$yyyy-$mm-$dd";

      // Structured Payload conforming back to Generational Architecture Design Flow
      final Map<String, dynamic> payload = {
        "is_married_son": isMarriedSon.value,
        "parent_family_id": isMarriedSon.value ? parentFamilyId.value : null,
        "user_data": {
          "gotra_id": selectedGotraId.value.isEmpty ? "1" : selectedGotraId.value,
          "native_village_id": selectedVillageId.value.isEmpty ? "1" : selectedVillageId.value,
          "surname": surnameController.text.trim(),
          "first_name": firstNameController.text.trim(),
          "father_or_husband_name": fatherHusbandController.text.trim(),
          "gender": selectedGender.value,
          "birth_date": fullBirthDate,
          "phone_number": phoneController.text.trim(),
          "marital_status": selectedMaritalStatus.value,
          "education": selectedEducation.value == 'Select Option' ? 'Graduate' : selectedEducation.value,
          "occupation": selectedOccupation.value == 'Select Option' ? 'Job' : selectedOccupation.value,
          "relation_with_head": selectedRelation.value,
          "address": currentAddressController.text.trim(),
          "current_city": currentCityVillageController.text.trim(),
          "current_district": currentDistrictController.text.trim(),
          "current_taluka": currentTalukaController.text.trim(),
          "pincode": pincodeController.text.trim(),
          "native_village_name": nativeVillageController.text.trim()
        },
        "maternal_data": (selectedMaritalStatus.value == 'Married' || selectedGender.value == 'Female')
            ? {
          "maternal_father_name": maternalFatherController.text.trim(),
          "maternal_mother_name": maternalMotherController.text.trim(),
          "maternal_address": maternalAddressController.text.trim(),
          "maternal_surname": maternalSurnameController.text.trim(),
          "maternal_village_name": maternalVillageController.text.trim()
        }
            : null
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(payload),
      );

      isLoading.value = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ⚡ FIX 2: Beautiful Professional English Success Dialog Box with Safe Navigation Flow
        Get.defaultDialog(
            title: "Success!",
            titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),
            middleText: "Your registration form and family record have been successfully submitted to the live secure server.",
            middleTextStyle: const TextStyle(fontSize: 14, color: Colors.black87),
            textConfirm: "OK",
            confirmTextColor: Colors.white,
            buttonColor: Colors.green,
            barrierDismissible: false,
            onConfirm: () {
              // Close the dialog box first securely
              Get.back();
              firstNameController.clear();
              fatherHusbandController.clear();
              motherNameController.clear();
              surnameController.clear();
              currentAddressController.clear();
              currentDistrictController.clear();
              currentTalukaController.clear();
              currentCityVillageController.clear();
              pincodeController.clear();
              nativeVillageController.clear();
              birthDayController.clear();
              birthMonthController.clear();
              birthYearController.clear();
              maternalFatherController.clear();
              maternalMotherController.clear();
              maternalAddressController.clear();
              currentStep.value = 0;
              familyCount.value = 0;
              familyMembers.clear();


              // Get.offAllNamed('/home');
              }
        );
      } else {
        final responseData = jsonDecode(response.body);
        String serverMessage = responseData['message'] ?? "";

        // ⚡ FIX 1: User-friendly clean Gujarati translation if database throws a Duplicate phone number constraint exception
        if (serverMessage.contains("Duplicate entry") && serverMessage.contains("phone_number")) {
          serverMessage = "આ મોબાઈલ નંબર પહેલેથી રજીસ્ટર્ડ થયેલો છે! કૃપા કરીને બીજો નંબર વાપરો.";
        } else if (serverMessage.isEmpty) {
          serverMessage = "સર્વર ટ્રાન્ઝેક્શન એરર. સ્ટેટસ કોડ: ${response.statusCode}";
        }

        Get.snackbar(
          "નોંધણી નિષ્ફળ ભાઈ",
          serverMessage,
          backgroundColor: Colors.red.shade800,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.error_outline, color: Colors.white),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "નેટવર્ક એરર",
        "સર્વર કનેક્શન લોચો: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // ==========================================
  // ♻️ DISPOSE INSTANCES SAFELY ON CLOSING
  // ==========================================
  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    firstNameController.dispose();
    surnameController.dispose();
    fatherHusbandController.dispose();
    motherNameController.dispose();
    birthDayController.dispose();
    birthMonthController.dispose();
    birthYearController.dispose();
    currentAddressController.dispose();
    currentDistrictController.dispose();
    currentTalukaController.dispose();
    currentCityVillageController.dispose();
    pincodeController.dispose();
    nativeVillageController.dispose();
    maternalFatherController.dispose();
    maternalMotherController.dispose();
    maternalAddressController.dispose();
    maternalSurnameController.dispose();
    maternalVillageController.dispose();

    for (var member in familyMembers) {
      member['nameController']?.dispose();
      member['dayController']?.dispose();
      member['monthController']?.dispose();
      member['yearController']?.dispose();
      member['phoneController']?.dispose();
    }
    super.onClose();
  }
}