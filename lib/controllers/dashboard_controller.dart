import 'dart:convert'; // ➔ ⚡ ✅ jsonDecode વાપરવા માટે આ ઈમ્પોર્ટ જરૂરી છે ભાઈ
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_preferences_helper.dart';
// ➔ ⚡ શાર્ડ પ્રેફરન્સ વાપરીએ છીએ એટલે ગેટ સ્ટોરેજ ઈમ્પોર્ટ કાઢી નાખ્યું ભાઈ

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/shared_preferences_helper.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../utils/shared_preferences_helper.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var loggedInUserData = <String, dynamic>{}.obs;
  var loggedInUserMaternalData = <String, dynamic>{}.obs;
  var loggedInFamilyMembers = <Map<String, dynamic>>[].obs;
  var isAdmin = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSessionData();
  }

  void loadSessionData() {
    try {
      String? userStr = sharedPreferencesHelper.getPrefData('cached_user');
      if (userStr != null && userStr != "null") {
        // ➔ ⚡ અહિયાં `userData` નામનો વેરીએબલ બનાવી લો
        Map<String, dynamic> userData = jsonDecode(userStr);

        // ➔ ⚡ હવે આ વેરીએબલનો ઉપયોગ `loggedInUserData` માં અને એડમિન ચેકમાં કરો
        loggedInUserData.value = userData;
        debugPrint("User ID Loaded: ${loggedInUserData['id']}");

        // હવે આ લાઈન કામ કરશે
        if (userData.containsKey('role')) {
          isAdmin.value = userData['role'] == 'admin';
        }
      }

      String? famStr = sharedPreferencesHelper.getPrefData('cached_family');
      if (famStr != null && famStr != "null") {
        loggedInFamilyMembers.assignAll(List<Map<String, dynamic>>.from(jsonDecode(famStr)));
      }
    } catch (e) {
      debugPrint("ડેટા લોડિંગ એરર: $e");
    }
  }

  Future<void> generateMemberPdf(Map<String, dynamic> member, bool isMainUser) async {
    // ગુજરાતી ફોન્ટ લોડ કરો (તમારા સાચા પાથ સાથે)
    final ttf = await rootBundle.load("assets/fonts/noto_sans_gujarati_regular.ttf").then((data) => pw.Font.ttf(data));


    final logoImage = await _loadNetworkImage("https://rajyapurohitjamnagar.in/assets/assets/images/om_logo.png");
    // ⚡ ઈમેજ લોડ કરવા માટેનું નવું લોજિક
    pw.MemoryImage? userProfileImage;
    if (member['profile_photo'] != null && member['profile_photo'].toString().isNotEmpty) {
      try {
        userProfileImage = await _loadNetworkImage("https://rajyapurohitjamnagar.in/${member['profile_photo']}");
      } catch (e) {
        debugPrint("PDF Image Error: $e");
      }
    }

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(base: ttf),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Container(
              width: 350,
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex("#FDFBF7"),
                borderRadius: pw.BorderRadius.circular(15),
                border: pw.Border.all(color: PdfColors.grey300),
              ),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.ClipOval(child: pw.Container(width: 110, height: 110, child: pw.Image(logoImage))),
                      pw.Padding(padding: const pw.EdgeInsets.symmetric(horizontal: 10), child: pw.Text("X", style: pw.TextStyle(font: ttf, fontSize: 16, fontWeight: pw.FontWeight.bold))),
                      if (userProfileImage != null)
                        pw.Container(
                          width: 110,
                          height: 110,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white, // બેકગ્રાઉન્ડ
                            shape: pw.BoxShape.circle, // ગોળ આકાર
                          ),
                          child: pw.Center( // ઈમેજને સેન્ટરમાં લાવવા માટે
                            child: pw.ClipOval(
                              child: pw.Image(
                                userProfileImage,
                                fit: pw.BoxFit.contain, // આખી ઈમેજ દેખાશે
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text("RajyaPurohit (RajyaGor) Cast",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(font: ttf, fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 15),

                  // Membership ID
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: pw.BoxDecoration(color: PdfColor.fromHex("#800020"), borderRadius: pw.BorderRadius.circular(5)),
                    child: pw.Text("RGB-00${member['id'] ?? ''}", style: pw.TextStyle(color: PdfColors.white, fontSize: 14)),
                  ),
                  pw.SizedBox(height: 20),

                  // ડેટા બાઈન્ડિંગ - અહીં ચેક કરી લેજો કે 'first_name' ની જગ્યાએ તમારા JSON માં શું નામ છે!
                  _buildPdfRow("નામ (NAME)", "${member['first_name'] ?? ''} ${member['surname'] ?? ''}", ttf),
                  _buildPdfRow("મોબાઈલ (MOBILE)", "${member['whatsapp_number'] ?? '-'}", ttf),
                  _buildPdfRow("શહેર (CITY)", "Jamnagar", ttf),
                  _buildPdfRow("જન્મ તારીખ (BIRTHDATE)", "${member['birth_date'] ?? '-'}", ttf),
                ],
              ),
            ),
          );
        },
      ),
    );
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }

  // ➔ આ ફંક્શન તમારા DashboardController માં ક્લાસની અંદર ગમે ત્યાં મૂકી દો
  Future<pw.MemoryImage> _loadNetworkImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    return pw.MemoryImage(response.bodyBytes);
  }

  // ➔ 3. Helper function માં font પેરામીટર ઉમેરો
  pw.Widget _buildPdfRow(String label, String value, pw.Font ttf) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 5),
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(label, style: pw.TextStyle(font: ttf, fontSize: 10, color: PdfColors.grey))),
          pw.Expanded(child: pw.Text(value, style: pw.TextStyle(font: ttf, fontSize: 12, fontWeight: pw.FontWeight.bold))),
        ],
      ),
    );
  }

  // DashboardController ma add karo
  Future<void> refreshFromServer() async {
    try {
      // 1. લોગિન ડેટામાંથી ફોન અથવા ઈમેલ મેળવો
      String? phone = loggedInUserData['phone_number'];
      String? email = loggedInUserData['email'];
      String? password = loggedInUserData['password']; // જો તમે પાસવર્ડ કેશમાં રાખ્યો હોય તો

      if (phone == null && email == null) return;

      // 2. ફરીથી લોગિન API કોલ કરો (આનાથી લેટેસ્ટ ડેટા આવશે)
      final response = await http.post(
        Uri.parse("https://rajyapurohitjamnagar.in/api/login.php"),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode({
          "email": email ?? '',
          "phone_number": phone ?? '',
          "password": password ?? '' // અહીં પાસવર્ડ સિક્યોરલી હેન્ડલ કરજો
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // 3. નવો ડેટા સ્ટોરેજમાં અપડેટ કરો
        await sharedPreferencesHelper.storePrefData('cached_user', jsonEncode(responseData['user_data']));
        await sharedPreferencesHelper.storePrefData('cached_family', jsonEncode(responseData['family_members']));

        // 4. કંટ્રોલરના વેરીએબલ્સ અપડેટ કરો
        loadSessionData();

        Get.snackbar("સફળ", "ડેટા અપડેટ થઈ ગયો છે!", backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Refresh Error: $e");
      Get.snackbar("ભૂલ", "ડેટા અપડેટ કરવામાં નિષ્ફળતા.");
    }
  }

  Future<void> logout() async {
    await sharedPreferencesHelper.clearPrefData();
    Get.offAllNamed('/MembershipScreen');
  }
}

