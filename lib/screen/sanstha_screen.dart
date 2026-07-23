import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../controllers/sanstha_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../controllers/sanstha_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../controllers/sanstha_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

class SansthaScreen extends GetView<SansthaController> {
  static const pageId = "/SansthaScreen";
  const SansthaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    // ➔ ⚡ માત્ર નામ અને સ્થાન ધરાવતી ક્લીન લિસ્ટ ભાઈ
    final List<Map<String, String>> sansthaList = [
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'જામનગર'},
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'સિક્કા'},
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'ખંભાળિયા'},
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'મોરબી'},
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'રાજકોટ'},

      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'અમદાવાદ'},
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'વાપી'},

      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'મુંબઈ'},
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'કેન્યા (આફ્રિકા)'},
      {'name': 'રાજ્યપુરોહિત બ્રાહ્મણ જ્ઞાતિ', 'location': 'લંડન (U.K)'},
      {'name': 'રાજ્યપુરોહિત વિદ્યાર્થી ભુવન', 'location': 'જામનગર'},
      {'name': 'રાજ્યપુરોહિત વિદ્યાર્થી ભુવન', 'location': 'ખંભાળિયા'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? screenWidth * 0.08 : 16.0,
                vertical: 60.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // હેડર સેક્શન ભાઈ
                  Row(
                    children: [
                      Icon(Icons.account_balance_outlined, size: 32, color: AppColors.textMaroon),
                      const SizedBox(width: 12),
                      const Text(
                        'રાજગોર (રાજ્યપુરોહિત) બ્રાહ્મણ જ્ઞાતિ ના ઘટકો',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.heading,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'આપણી જ્ઞાતિ હસ્તકના વિવિધ વૈશ્વિક સામાજિક ઘટકો તથા વિદ્યાર્થી ભુવનોની સત્તાવાર યાદી નીચે મુજબ છે.',
                    style: TextStyle(fontSize: 15, color: AppColors.body),
                  ),
                  const SizedBox(height: 40),

                  // 📊 ⚡ માત્ર ૨ કોલમ વાળું મોર્ડન કસ્ટમ ટેબલ ભાઈ
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        )
                      ],
                      border: Border.all(color: AppColors.cardBorder.withOpacity(0.6), width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(6), // સંસ્થાનું નામ (૬૦% જગ્યા ભાઈ)
                          1: FlexColumnWidth(4), // સ્થાન / લોકેશન (૪૦% જગ્યા ભાઈ)
                        },
                        border: TableBorder(
                          horizontalInside: BorderSide(color: AppColors.cardBorder.withOpacity(0.4), width: 1),
                        ),
                        children: [
                          // ➔ ૧. ફક્ત ૨ કોલમ વાળું Table Header ભાઈ
                          TableRow(
                            decoration: const BoxDecoration(
                              color: AppColors.textMaroon,
                            ),
                            children: [
                              _buildHeaderCell('સંસ્થા / ઘટકનું નામ'),
                              _buildHeaderCell('સ્થાન (ગામ/શહેર)'),
                            ],
                          ),

                          // ➔ ૨. ડેટા રો (Data Rows)
                          ...sansthaList.map((item) {
                            final int index = sansthaList.indexOf(item);
                            final bool isEven = index % 2 == 0;
                            return TableRow(
                              decoration: BoxDecoration(
                                color: isEven ? Colors.white : AppColors.secondary.withOpacity(0.05),
                              ),
                              children: [
                                _buildDataCell(item['name']!, isBold: true),
                                _buildDataCell(item['location']!, isLocation: true),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15.5,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {bool isBold = false, bool isLocation = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          color: isLocation ? AppColors.textOrange : AppColors.heading, // લોકેશન હાઈલાઈટ કરવા ઓરેન્જ કલર ભાઈ
        ),
      ),
    );
  }
}