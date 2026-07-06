
import 'package:universal_html/html.dart' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html; // 👈 Required import to fix the red error line
import '../../constant/const.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      color: AppColors.footerBackground,
      padding: EdgeInsets.only(
        // ⚡ જાદુઈ ફિક્સ: આખા કન્ટેનરમાં નીચેનું પેડિંગ ૬૦ માંથી ઘટાડીને ૩૦ કરી દીધું ભાઈ!
        left: isWeb ? screenWidth * 0.08 : 24.0,
        right: isWeb ? screenWidth * 0.08 : 24.0,
        top: 60.0,
        bottom: 30.0,
      ),
      child: Column(
        children: [
          isWeb ? _buildWebLayout() : _buildMobileLayout(),
          const SizedBox(height: 50),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 25), // સેહેજ સ્પેસિંગ બેલેન્સ કર્યું ભાઈ
          _buildBottomBar(isWeb),
        ],
      ),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: _buildBrandColumn(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 3,
          child: _buildLinksColumn(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 5,
          child: _buildMapColumn(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 6,
          child: _buildAddressCard(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: 40),
        _buildLinksColumn(),
        const SizedBox(height: 40),
        _buildMapColumn(),
        const SizedBox(height: 40),
        _buildAddressCard(),
      ],
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RAJYAPUROHITJAMNAGAR.IN',
          style: GoogleFonts.cinzel(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.footerHeading,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'ગુજરાત રાજયગોર જ્ઞાતિ દ્વારા બનાવાયેલ RAJYAPUROHIJAMNAGAR.IN એક ડિજિટલ સામાજિક પ્લેટફોર્મ છે. અહીં સભ્યના, બિઝનેસ, મે્ટ્રિમોની, હેલ્થ અને એજ્યુકેશન જેવી સેવાઓ ઉપલબ્ધ કરવાનુ આયોજન છે.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.footerText,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ઝડપી કરો',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20),
        _buildFooterLink('હોમ'),
        _buildFooterLink('મેમ્બરશીપ'),
        _buildFooterLink('અમારી ટીમ'),
        _buildFooterLink('અમારો ઉદ્દેશ'),
        _buildFooterLink('પ્રસંગો'),
        _buildFooterLink('સંપર્ક'),
      ],
    );
  }

  Widget _buildFooterLink(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () {
          if (title == 'હોમ') {
            Get.offAllNamed('/HomeScreen');
          } else if (title == 'મેમ્બરશીપ') {
            Get.toNamed('/MembershipScreen');
          } else if (title == 'અમારો ઉદ્દેશ') {
            Get.toNamed('/MissionScreen');
          } else if (title == 'અમારી ટીમ') {
            Get.toNamed('/TeamScreen');
          } else if (title == 'સંપર્ક') {
            Get.toNamed('/ContactScreen');
          }
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 14, color: AppColors.footerText.withOpacity(0.8)),
        ),
      ),
    );
  }

  Widget _buildMapColumn() {
    const String footerMapTag = "google-maps-footer-jamnagar";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(footerMapTag, (int viewId) {
      return html.IFrameElement()
        ..src = 'https://www.google.com/maps/embed?pb=!1m13!1m8!1m3!1d3686.993510531557!2d70.0737843!3d22.4668749!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMjLCsDI4JzAwLjciTiA3MMKwMDQnMjUuNiJF!5e0!3m2!1sgu!2sin!4v1719945000000!5m2!1sgu!2sin'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ગૂગલ મેપ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: const HtmlElementView(viewType: footerMapTag),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.buttonSecondary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ગુજરાત રાજયગોર જ્ઞાતિ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          _buildAddressRow(Icons.phone, '(૦૨૮૮) ૨૬૭૯૮૧૯'),
          _buildAddressRow(Icons.email, 'contact@rajyapurohitjamnagar.in'),
          _buildAddressRow(
            Icons.location_on,
            'જામનગર રાજ્યગોર જ્ઞાતિ બ્રહ્મપુરી,\n રાજ્યગોર ફળી શેરી નં. ૧,\nજામનગર - ૩૬૧૦૦૧. ગુજરાત. ઇન્ડિયા.',
          ),
        ],
      ),
    );
  }

  Widget _buildAddressRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(bool isWeb) {
    final textStyle = TextStyle(fontSize: 13, color: AppColors.footerText.withOpacity(0.8));

    final content = [
      Text(
        '© 2026 ગુજરાત રાજયગોર જ્ઞાત | RajyapurohitJamnagar.in',
        style: textStyle,
      ),
      if (isWeb) const Spacer(),
      if (!isWeb) const SizedBox(height: 10),
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse('https://intelligenttech.in/');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              debugPrint('Could not launch $url');
            }
          },
          child: Text(
            'Powered by iNTELLIGENT tECH',
            style: textStyle.copyWith(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    ];

    return isWeb ? Row(children: content) : Column(children: content);
  }
}