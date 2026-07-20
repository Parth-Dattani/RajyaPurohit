import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/shared_preferences_helper.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/shared_preferences_helper.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';
import 'dart:js' as js;

class RegistrationController extends GetxController {
  var currentStep = 0.obs;
  var isLoading = false.obs;

  // સિંગલ સ્ક્રીન ફ્લો માટેના રીએક્ટિવ સ્ટેટ્સ
  var isOldUser = false.obs;
  var currentReqId = ''.obs;
  var isOtpSent = false.obs;
  // ➔ ⚡ ✅ પાસવર્ડ શો/હાઇડ કરવા માટેના નવા રીએક્ટિવ સ્ટેટ્સ ભાઈ
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  // ==========================================
  // 📝 UNIQUE TEXT EDITING CONTROLLERS
  // ==========================================
  // Step 1: Mobile & Email verification
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final otpController = TextEditingController();

  // Step 2: Primary Info
  final firstNameController = TextEditingController();
  final fatherHusbandController = TextEditingController();
  final motherNameController = TextEditingController();
  final surnameController = TextEditingController();
  final gotraController = TextEditingController();

  // Step 2 & Step 3: Address & Locations
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
  final bloodGroupController = TextEditingController();       // બ્લડ ગ્રુપ માટે
  final whatsappController = TextEditingController();
  final organizationNameController = TextEditingController();

  // Step 3: Maternal / Mosal Details
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
  var selectedImagePath = ''.obs;

  var selectedEducation = 'Select Option'.obs;
  var selectedOccupation = 'Select Option'.obs;

  var isMarriedSon = false.obs;
  var parentFamilyId = 5001.obs;


  var isGotrasLoading = false.obs;

  var familyMembers = <Map<String, dynamic>>[].obs;

  // ➔ ⚡ ✅ આંખના આઇકન પર ક્લિક થતાં ટોગલ કરવાનું લોજિક
  void togglePasswordVisibility() => isPasswordHidden.value = !isPasswordHidden.value;
  void toggleConfirmPasswordVisibility() => isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;

  @override
  void onInit() {
    super.onInit();
    OTPWidget.initializeWidget('36676f6d7953383734343736', '550824TZwKL7OI4HO46a592818P1');
    // ➔ ⚡ સ્ક્રીન લોડ થાય ત્યારે arguments ચેક કરો
    if (Get.arguments == "DIRECT_LOGIN") {
      isOldUser.value = true;
    } else {
      isOldUser.value = false;
    }
    passwordController.addListener(() => update());
  }

  Future<void> sendOtpToUser(String mobileNumber) async {
    if (mobileNumber.isEmpty) {
      Get.snackbar("ભૂલ", "મોબાઈલ નંબર લખો ભાઈ!");
      return;
    }

    try {
      isLoading.value = true;

      // ➔ JavaScript માં બનાવેલા window.initSendOTP ફંક્શનને ફ્લટરમાંથી કોલ કરો
      // આપણે index.html માં જે 'configuration' બનાવ્યું છે,
      // તેમાં ડાયનેમિક મોબાઈલ નંબર પાસ કરીશું.

      js.context.callMethod('initSendOTP', [
        js.JsObject.jsify({
          "widgetId": "36676f6d7953383734343736",
          "tokenAuth": "{token}",
          "identifier": mobileNumber, // ➔ યુઝરનો મોબાઈલ નંબર
          "success": (data) {
            debugPrint("OTP Success: $data");
            Get.snackbar("સફળ", "OTP વિજેટ ખુલી ગયું છે!");
          },
          "failure": (error) {
            debugPrint("OTP Failure: $error");
            Get.snackbar("ભૂલ", "OTP વિજેટમાં એરર આવી!");
          }
        })
      ]);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint("JS Interop Error: $e");
      Get.snackbar("એરર", "OTP લોડ કરવામાં લોચો છે!");
    }
  }

  Future<void> openOtpWidget(String mobile) async {
    try {
      isLoading.value = true;
      final data = {'identifier': '91$mobile'};

      final response = await OTPWidget.sendOTP(data);
      debugPrint("OTP Response: $response");

      // IPBlocked એરર ચેક
      if (response != null && response['type'] == 'error' && response['message'] == 'IPBlocked') {
        Get.snackbar("સાવધાન! ⚠️", "તમારો IP બ્લોક છે, કૃપા કરીને નેટવર્ક બદલીને ફરી પ્રયાસ કરો.");
        return;
      }

      // ➔ ફેરફાર: response['reqId'] ને બદલે response['message'] ચેક કરો
      if (response != null && response['message'] != null) {
        currentReqId.value = response['message'].toString(); // ➔ અહીં ID સેવ થશે
        isOtpSent.value = true;
        Get.snackbar("સફળ", "OTP મોકલાઈ ગયો છે.");
      } else {
        Get.snackbar("ભૂલ", "સર્વરથી રિસ્પોન્સ નથી મળ્યો!");
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar("ભૂલ", "OTP મોકલવામાં નિષ્ફળતા!");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleVerifyOtp(String reqId, String otp) async {
    try {
      isLoading.value = true;
      final data = {'reqId': reqId, 'otp': otp};
      final response = await OTPWidget.verifyOTP(data);

      debugPrint("Verify Response: $response");

      if (response != null && response['type'] == 'success') {
        // ➔ ⚡ જો જૂનો યુઝર OTP થી લોગિન કરે તો ડાયરેક્ટ ડેશબોર્ડ પર મોકલો
        if (isOldUser.value) {
          // અહિયાં તમારે તમારા લોગિન API જેવું જ કામ કરવું પડશે
          await loginByOtpOnly(phoneController.text.trim());
          // Get.offAllNamed('/DashboardScreen');
          // Get.snackbar("સફળ", "OTP થી લોગિન થઈ ગયું!");
        } else {
          nextStep(); // નવો યુઝર હોય તો સ્ટેપર આગળ વધારો
        }
      } else {
        Get.snackbar("ભૂલ", "ખોટો OTP છે!");
      }
    } catch (e) {
      Get.snackbar("ભૂલ", "વેરિફિકેશનમાં લોચો!");
    } finally {
      isLoading.value = false; // ➔ ⚡ ગમે તે થાય લોડર અટકશે જ
    }
  }

  Future<void> loginByOtpOnly(String phone) async {
    final String loginUrl = "https://rajyapurohitjamnagar.in/api/login.php";

    try {
      isLoading.value = true;
      // OTP દ્વારા લોગિન કરવા માટે આપણે પાસવર્ડ ખાલી રાખીને અથવા
      // અલગ ફ્લેગ સાથે રિક્વેસ્ટ મોકલી શકીએ છીએ
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode({
          "phone_number": phone,
          "is_otp_login": true // ➔ સર્વરમાં આ ફ્લેગ ચેક કરજો
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          // ડેટા સેવ કરો
          await sharedPreferencesHelper.storeBoolPrefData('isLoggedIn', true);
          await sharedPreferencesHelper.storePrefData('cached_user', jsonEncode(responseData['user_data']));
          await sharedPreferencesHelper.storePrefData('cached_family', jsonEncode(responseData['family_members']));

          Get.offAllNamed('/DashboardScreen');
          Get.snackbar("સફળ", "OTP થી લોગિન થઈ ગયું!");
        }
      }
    } catch (e) {
      debugPrint("Login Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ==========================================
  // 🔍 ⚡ યુઝર સ્ટેટસ ચેક (મોબાઈલ અથવા ઈમેલ - બેમાંથી કોઈ પણ એક ભાઈ!)
  // ==========================================
  Future<void> checkUserStatus() async {
    final String checkUrl = "https://rajyapurohitjamnagar.in/api/check_user.php";

    if (phoneController.text.trim().isEmpty && emailController.text.trim().isEmpty) {
      Get.snackbar(
          "વિગત ખૂટે છે ભાઈ",
          "કૃપા કરીને આગળ વધવા માટે મોબાઈલ નંબર અથવા ઈમેલ આઈડી બેમાંથી કોઈ પણ એક દાખલ કરો.",
          backgroundColor: Colors.amber.shade800,
          colorText: Colors.white
      );
      return;
    }

    try {
      isLoading.value = true;
      final response = await http.post(
        Uri.parse(checkUrl),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "phone_number": phoneController.text.trim()
        }),
      );

      isLoading.value = false;
      final responseData = jsonDecode(response.body);

      // ➔ ⚡ ⚡ કિલર જુગાડ ફિક્સ: સર્વરનું 'exists' સ્ટેટસ અથવા 'User exists' મેસેજ બંને કન્ડિશન લૉક ભાઈ!
      if (responseData['status'] == 'exists' || responseData['message'] == 'User exists') {
        isOldUser.value = true; // પાસવર્ડ ફિલ્ડ્સ ઓપન થશે અને યુઝર અહીં જ રોકાશે

        Get.snackbar(
            "જૂના સભ્ય 🪪",
            "તમારું એકાઉન્ટ ઓલરેડી બનેલું છે, તમે પાસવર્ડ દાખલ કરો અથવા નીચે OTP દ્વારા લોગિન કરો.",
            backgroundColor: Colors.amber.shade800,
            colorText: Colors.white,
            duration: const Duration(seconds: 4)
        );
      } else {
        isOldUser.value = false;
        nextStep();
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("કનેક્શન લોચો", "સર્વર ચેકિંગ નિષ્ફળ: $e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // ==========================================
  // 🔑 ⚡ જૂના સભ્યો માટે ડાયરેક્ટ લોગિન ફ્લો
  // ==========================================
  Future<void> directLoginFromStepper() async {
    final String loginUrl = "https://rajyapurohitjamnagar.in/api/login.php";

    if (passwordController.text.trim().isEmpty) {
      Get.snackbar("વિગત ખૂટે છે ભાઈ", "કૃપા કરીને તમારો લોગિન પાસવર્ડ દાખલ કરો.",
          backgroundColor: Colors.amber.shade800, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      debugPrint("Sending Password: '${passwordController.text.trim()}'");
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "phone_number": phoneController.text.trim(), // 👈 મોબાઇલ સબમિશન પણ મોકલી આપ્યું ભાઈ સેફ્ટી માટે
          "password": passwordController.text.trim()
        }),
      );

      isLoading.value = false;
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        try {
          await sharedPreferencesHelper.storeBoolPrefData('isLoggedIn', true);
          await sharedPreferencesHelper.storePrefData('cached_user', jsonEncode(responseData['user_data']));
          await sharedPreferencesHelper.storePrefData('cached_maternal', jsonEncode(responseData['maternal_data']));
          await sharedPreferencesHelper.storePrefData('cached_family', jsonEncode(responseData['family_members']));
        } catch (_) {}

        Get.offAllNamed('/DashboardScreen');
        Get.snackbar("લોગિન સફળ ભાઈ!", "તમારા પરિવારનો આખો ડેટા લાઈવ સિંક થઈ ગયો છે.", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        passwordController.clear();
        // ➔ ⚡ હોસ્ટિંગર ModSecurity બાયપાસ પ્રમાણે ગુજરાતી કન્વર્ઝન લોક
        String errorMsg = "ખોટો પાસવર્ડ! કૃપા કરીને ફરી પ્રયાસ કરો .";
        if (responseData['message'] == "Account not found") {
          errorMsg = "આ મોબાઈલ નંબર અથવા ઈમેલ રજીસ્ટર્ડ નથી ભાઈ.";
        }
        Get.snackbar("લોગિન નિષ્ફળ", errorMsg, backgroundColor: Colors.red.shade800, colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("ने트워크 એરર", "સર્વર કનેક્શન લોચો: $e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


  // RegistrationController.dart માં
  void fillEditData(Map<String, dynamic> data) {
    // 1. Text Controllers
    firstNameController.text = data['first_name'] ?? '';
    surnameController.text = data['surname'] ?? '';
    fatherHusbandController.text = data['father_or_husband_name'] ?? '';
    motherNameController.text = data['mother_name'] ?? '';
    phoneController.text = data['phone_number'] ?? '';
    emailController.text = data['email'] ?? '';
    gotraController.text = data['gotra_'] ?? '';

    // 2. Address & Location
    currentAddressController.text = data['current_address'] ?? '';
    currentDistrictController.text = data['current_district'] ?? '';
    currentTalukaController.text = data['current_taluka'] ?? '';
    currentCityVillageController.text = data['current_city'] ?? '';
    pincodeController.text = data['pincode'] ?? '';
    nativeVillageController.text = data['native_village'] ?? '';

    // 3. Birth Date Splitting (જો તમારી પાસે ડેટા YYYY-MM-DD ફોર્મેટમાં હોય)
    if (data['birth_date'] != null) {
      List<String> dateParts = data['birth_date'].toString().split('-');
      if (dateParts.length == 3) {
        birthYearController.text = dateParts[0];
        birthMonthController.text = dateParts[1];
        birthDayController.text = dateParts[2];
      }
    }

    // 4. Other Details
    whatsappController.text = data['whatsapp_number'] ?? '';
    bloodGroupController.text = data['blood_group'] ?? '';
    organizationNameController.text = data['organization_name'] ?? '';

    // 5. Maternal Details
    maternalFatherController.text = data['maternal_father_name'] ?? '';
    maternalMotherController.text = data['maternal_mother_name'] ?? '';
    maternalAddressController.text = data['maternal_address'] ?? ''; // આ ચેક કરી લેજો
    maternalSurnameController.text = data['maternal_surname'] ?? ''; // જો ડેટાબેઝમાં હોય તો
    maternalVillageController.text = data['maternal_village'] ?? '';

    // 6. Reactive Values (Dropdowns)
    selectedGender.value = data['gender'] ?? 'Male';
    selectedMaritalStatus.value = data['marital_status'] ?? 'Single';
    selectedEducation.value = data['education'] ?? 'Select Option';
    selectedOccupation.value = data['occupation'] ?? 'Select Option';

    // 7. Profile Photo
    if (data['profile_photo'] != null) {
      selectedImagePath.value = data['profile_photo'];
    }
  }

  void addFamilyMember() {
    familyMembers.add({
      'nameController': TextEditingController(),
      'relation': 'પસંદ કરો',
      'dayController': TextEditingController(),
      'monthController': TextEditingController(),
      'yearController': TextEditingController(),
      'phoneController': TextEditingController(),
      'bloodGroupController': TextEditingController(),
      'education': 'Select Option',
      'maritalStatus': 'Single',
      'occupation': 'Select Option',
      'organizationNameController': TextEditingController(),


      'maternalFatherController': TextEditingController(),
      'maternalMotherController': TextEditingController(),
      'maternalVillageController': TextEditingController(),

    });
  }

  void removeFamilyMember(int index) {
    var member = familyMembers[index];

    member['nameController']?.dispose();
    member['dayController']?.dispose();
    member['monthController']?.dispose();
    member['yearController']?.dispose();
    member['phoneController']?.dispose();
    member['organizationNameController']?.dispose();
    member['maternalFatherController']?.dispose();
    member['maternalMotherController']?.dispose();
    member['maternalVillageController']?.dispose();

    familyMembers.removeAt(index);
  }



  void nextStep() {
    if (currentStep.value < 4) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<void> submitMemberToLiveSQL() async {
    String base64Image = "";
    if (selectedImagePath.value.isNotEmpty) {
      // વેબ અને મોબાઈલ બંને માટે કામ કરે તેવું લોજિક
      try {
        if (kIsWeb) {
          // વેબ માટે bytes મેળવો
          final bytes = await XFile(selectedImagePath.value).readAsBytes();
          base64Image = base64Encode(bytes);
        } else {
          // મોબાઈલ માટે File માંથી bytes મેળવો
          File imageFile = File(selectedImagePath.value);
          List<int> imageBytes = await imageFile.readAsBytes();
          base64Image = base64Encode(imageBytes);
        }
      } catch (e) {
        debugPrint("Base64 Conversion Error: $e");
      }
    }
    // ➔ ⚡ પાસવર્ડ વેલિડેશન
    // if (passwordController.text.trim().isEmpty || confirmPasswordController.text.trim().isEmpty) {
    //   Get.snackbar("પાસવર્ડ ખૂટે છે", "બંને પાસવર્ડ ફિલ્ડ ભરો.", backgroundColor: Colors.amber.shade800, colorText: Colors.white);
    //   return;
    // }

    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar("પાસવર્ડ ભૂલ ❌", "પાસવર્ડ મેચ નથી થતા!", backgroundColor: Colors.red.shade800, colorText: Colors.white);
      return;
    }

    final String apiUrl = "https://rajyapurohitjamnagar.in/api/add_member.php";
    bool isMarriedRelation(String relation) {
      return ['પતિ', 'પત્ની', 'પુત્રવધૂ', 'માતા', 'પિતા', 'દાદા', 'દાદી'].contains(relation);
    }
    try {
      isLoading.value = true;

      // ➔ ડેટા મેપિંગ લોજિક - ફેમિલી મેમ્બર્સ માટે
      List<Map<String, dynamic>> mappedMembers = [];

      for (var member in familyMembers) {
        mappedMembers.add({
          "name": member['nameController'].text.trim(),
          "relation": member['relation'],
          "gender": "Male",

          "birth_date":
          "${member['yearController'].text.trim()}-${member['monthController'].text.trim()}-${member['dayController'].text.trim()}",

          "phone_number": null,
          "whatsapp_number": member['phoneController'].text.trim(),
          "blood_group": member['bloodGroupController'].text.trim(),
          "education": member['education'],
          "marital_status": isMarriedRelation(member['relation']) ? 'Married' : member['maritalStatus'],

          "occupation": member['occupation'],

          "organization_name":
          member['organizationNameController'].text.trim(),

          "maternal_father_name":
          member['maternalFatherController'].text.trim(),

          "maternal_mother_name":
          member['maternalMotherController'].text.trim(),

          "maternal_village":
          member['maternalVillageController'].text.trim(),
          "is_family_head": 0,
        });
      }

      // ➔ ફાઈનલ પેલોડ
      final Map<String, dynamic> payload = {
        "user_data": {
          "surname": surnameController.text.trim(),
          "first_name": firstNameController.text.trim(),
          "father_or_husband_name": fatherHusbandController.text.trim(),
          "mother_name": motherNameController.text.trim(),
          "phone_number": phoneController.text.trim(),
          "whatsapp_number": whatsappController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "gender": selectedGender.value,
          "birth_date": "${birthYearController.text.trim()}-${birthMonthController.text.trim()}-${birthDayController.text.trim()}",
          "blood_group": bloodGroupController.text.trim(),
          "gotra_": gotraController.text.trim(),
          "native_village_id": int.tryParse(selectedVillageId.value) ?? 1,
          "marital_status": selectedMaritalStatus.value,
          "education": selectedEducation.value,
          "occupation": selectedOccupation.value,
          "organization_name": organizationNameController.text.trim(),
          "relation_with_head": selectedRelation.value,
          "current_address": currentAddressController.text.trim(),
          "current_district": currentDistrictController.text.trim(),
          "current_taluka": currentTalukaController.text.trim(),
          "current_city": currentCityVillageController.text.trim(),
          "pincode": pincodeController.text.trim(),
          "native_village": nativeVillageController.text.trim(),
          "profile_photo_base64": base64Image,
          "is_family_head":1,
        },
        "family_members": mappedMembers,
      };

      debugPrint("Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(payload),
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        debugPrint("Server Response: ${responseData['user_data']}");

        // ➔ ડેટા સેવ કરો જેથી ડેશબોર્ડ પર દેખાય
        await sharedPreferencesHelper.storePrefData('cached_user', jsonEncode(responseData['user_data']));
        await sharedPreferencesHelper.storePrefData('cached_family', jsonEncode(responseData['family_members']));

        Get.offAllNamed('/DashboardScreen');

        // ➔ અહીં તમે તમારી ઈચ્છા મુજબ મેસેજ બદલી શકો છો
        Get.snackbar(
            "અભિનંદન! 🎉",
            "તમારા પરિવારની નોંધણી સફળતાપૂર્વક થઈ ગઈ છે.",
            backgroundColor: Colors.green,
            colorText: Colors.white
        );
      } else {
        debugPrint("Server Error: ${response.body}");
        Get.snackbar("ભૂલ આવી !", "સર્વર રિસ્પોન્સમાં કંઈક લોચો છે.", backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("એરર", "કનેક્શન લોચો: $e");
    }
  }

  Future<void> pickImage(ImageSource source) async {
    // ➔ કેમેરા ઓપ્શન કાઢી નાખવા માટે અહીં ફક્ત gallery જ વાપરો
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // ➔ સાઈઝ ચેક કરવા માટે (bytes માં)
      final bytes = await image.length();
      final kb = bytes / 1024;

      // ➔ 50KB થી વધુ હોય તો એરર આપો
      if (kb > 50) {
        Get.snackbar(
            "મોટી ફાઇલ ❌",
            "ફોટો 50KB થી ઓછી સાઈઝનો હોવો જોઈએ! (તમારો ફોટો: ${kb.toStringAsFixed(1)} KB)",
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      } else {
        selectedImagePath.value = image.path;
        debugPrint("ફોટો પાથ: ${image.path} (સાઇઝ: ${kb.toStringAsFixed(2)} KB)");
      }
    } else {
      Get.snackbar("ભૂલ", "ફોટો સિલેક્ટ નથી થયો", backgroundColor: Colors.red);
    }
  }




  @override
  void onClose() {
    phoneController.dispose(); emailController.dispose(); passwordController.dispose(); confirmPasswordController.dispose(); otpController.dispose();
    firstNameController.dispose(); fatherHusbandController.dispose(); motherNameController.dispose();
    surnameController.dispose(); gotraController.dispose(); currentAddressController.dispose();
    bloodGroupController.dispose(); whatsappController.dispose();
    currentDistrictController.dispose(); currentTalukaController.dispose(); currentCityVillageController.dispose();
    pincodeController.dispose(); nativeVillageController.dispose(); birthDayController.dispose();
    birthMonthController.dispose(); birthYearController.dispose(); organizationNameController.dispose();
    maternalFatherController.dispose(); maternalMotherController.dispose(); maternalAddressController.dispose();
    maternalSurnameController.dispose(); maternalVillageController.dispose();

    for (var member in familyMembers) {
      member['nameController']?.dispose();
      member['dayController']?.dispose();
      member['monthController']?.dispose();
      member['yearController']?.dispose();
      member['phoneController']?.dispose();
      member['organizationNameController']?.dispose();
      member['maternalFatherController']?.dispose();
      member['maternalMotherController']?.dispose();
      member['maternalVillageController']?.dispose();
      member['bloodGroupController']?.dispose();
    }
    super.onClose();
  }
}
