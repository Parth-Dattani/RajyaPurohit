import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EventController extends GetxController {
  var isLoading = false.obs;
  var eventsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLiveEvents();
  }

  Future<void> fetchLiveEvents() async {
    final String apiUrl = "https://rajyapurohitjamnagar.in/api/get_events.php";
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData['status'] == 'success' && decodedData['data'] != null) {
          eventsList.assignAll(List<Map<String, dynamic>>.from(decodedData['data']));
        } else {
          _loadMockEvents();
        }
      } else {
        _loadMockEvents();
      }
    } catch (e) {
      _loadMockEvents();
    } finally {
      isLoading.value = false;
    }
  }

  // ➔ ⚡ સત્કાર સમારંભના ૧ થી ૧૦ અને નવરાત્રીના ૧ થી ૧૩ બધા જ ફોટા લોક ભાઈ!
  void _loadMockEvents() {
    eventsList.assignAll([
      {
        'title': 'વિદ્યાર્થી સત્કાર સમારંભ ૨૦૨૪',
        'date': '૧૫-ઓગસ્ટ-૨૦૨૪',
        'venue': 'શ્રી રાજગોર જ્ઞાતિ વાડી, જામનગર',
        'description': 'જ્ઞાતિના તેજસ્વી વિદ્યાર્થીઓ જેમણે શૈક્ષણિક વર્ષમાં ઉત્કૃષ્ટ પ્રદર્શન કર્યું છે, તેમને પ્રોત્સાહિત કરવા માટે ભવ્ય ઇનામ વિતરણ અને સરસ્વતી સન્માન સમારોહનું સુંદર આયોજન કરવામાં આવ્યું હતું ભાઈ.',
        'image_url': 'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/3.jpg',
        'images': [
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/1.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/2.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/3.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/4.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/5.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/6.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/7.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/8.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/9.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/SatkarSamaroh/10.jpg',
        ],
      },
      {
        'title': 'મહિલા મંડળ આયોજિત બાય બાય નવરાત્રી',
        'date': '૦૫-ઓક્ટોબર-૨૦૨૫',
        'venue': 'જામનગર જ્ઞાતિ પ્લોટ, જામનગર',
        'description': 'જામનગર રાજ્યગોર જ્ઞાતિ મહિલા મંડળ દ્વારા સમસ્ત જ્ઞાતિની બહેનો માટે ભવ્ય અને સાંસ્કૃતિક "બાય બાય નવરાત્રી" રાસ-ગરબાના ધમાકેદાર કાર્યક્રમનું સુંદર આયોજન કરવામાં આવ્યું હતું ભાઈ.',
        // ➔ મુખપૃષ્ઠ પર ૧ નંબરનો અસલી ગરબાનો ફોટો લોક ભાઈ!
        'image_url': 'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/1.jpg',

        // ➔ ⚡ ⚡ મેગા અપડેટ: ૧ થી લઈને ૧૩ સુધીના બધા જ લાઈવ ફોટા અહીંયા સેટ થઈ ગયા ભાઈ!
        'images': [
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/1.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/2.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/3.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/4.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/5.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/6.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/7.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/8.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/9.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/10.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/11.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/12.jpg',
          'https://rajyapurohitjamnagar.in/assets/assets/images/navratri/13.jpg',
        ],
      }
    ]);
  }
}