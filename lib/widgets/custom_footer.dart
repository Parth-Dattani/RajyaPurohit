import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      color: AppColors.footerBackground, // ✅ અપડેટેડ: ગ્લોબલ ફૂટર ડાર્ક બેકગ્રાઉન્ડ
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 24.0,
        vertical: 60.0,
      ),
      child: Column(
        children: [
          isWeb ? _buildWebLayout() : _buildMobileLayout(),
          const SizedBox(height: 50),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 30),
          _buildBottomBar(isWeb),
        ],
      ),
    );
  }

  // --- વેબ વ્યુ આડો લેઆઉટ (૪ કોલમ) ---
  Widget _buildWebLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // કોલમ ૧: બ્રાન્ડિંગ અને સોશિયલ લિંક્સ
        Expanded(
          flex: 5,
          child: _buildBrandColumn(),
        ),
        const SizedBox(width: 40),

        // કોલમ ૨: ઝડપી કરો (લિંક્સ)
        Expanded(
          flex: 3,
          child: _buildLinksColumn(),
        ),
        const SizedBox(width: 40),

        // કોલમ ૩: ગૂગલ મેપ પ્લેસહોલ્ડર
        Expanded(
          flex: 5,
          child: _buildMapColumn(),
        ),
        const SizedBox(width: 40),

        // કોલમ ૪: યેલો એડ્રેસ કાર્ડ
        Expanded(
          flex: 6,
          child: _buildAddressCard(),
        ),
      ],
    );
  }

  // --- મોબાઇલ વ્યુ ઉભો લેઆઉટ ---
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

  // 🔹 કોલમ ૧: બ્રાન્ડિંગ
  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RAJYAPUROHITONLINE.IN',
          style: GoogleFonts.cinzel(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.footerHeading, // ✅ અપડેટેડ
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'ગુજરાત રાજ્યપુરોહિત સમાજ દ્વારા બનાવાયેલ RajyapurohitOnline.in એક ડિજિટલ સામાજિક પ્લેટફોર્મ છે. અહીં સભ્યતા, બિઝનેસ, મે્ટ્રિમોની, હેલ્થ અને એજ્યુકેશન જેવી સેવાઓ ઉપલબ્ધ છે.',
          style: GoogleFonts.notoSansGujarati(
            textStyle: TextStyle(
              fontSize: 14,
              color: AppColors.footerText, // ✅ અપડેટેડ
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 25),
        // સોશિયલ મીડિયા આઈકોન્સ રો
        Row(
          children: [
            _buildSocialIcon(Icons.g_mobiledata, () {}),
            const SizedBox(width: 10),
            _buildSocialIcon(Icons.phone, () {}),
            const SizedBox(width: 10),
            _buildSocialIcon(Icons.android, () {}),
            const SizedBox(width: 10),
            _buildSocialIcon(Icons.apple, () {}),
          ],
        )
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child:  Icon(icon, color: AppColors.footerIcon, size: 18), // ✅ અપડેટેડ
      ),
    );
  }

  // 🔹 કોલમ ૨: લિંક્સ
  Widget _buildLinksColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ઝડપી કરો',
          style: GoogleFonts.notoSansGujarati(
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        _buildFooterLink('હોમ'),
        _buildFooterLink('અમારા વિષે'),
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
          } else if (title == 'અમારા વિષે') {
            Get.toNamed('/AboutScreen');
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
          style: GoogleFonts.notoSansGujarati(
            textStyle: TextStyle(fontSize: 14, color: AppColors.footerText.withOpacity(0.8)), // ✅ અપડેટેડ
          ),
        ),
      ),
    );
  }

  // 🔹 કોલમ ૩: ગૂગલ મેપ પ્લેસહોલ્ડર
  Widget _buildMapColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ગૂગલ મેપ',
          style: GoogleFonts.notoSansGujarati(
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 180,
            width: double.infinity,
            color: Colors.white.withOpacity(0.1), // ✅ અપડેટેડ: ડાર્ક થીમ અનુકૂળ પ્લેસહોલ્ડર
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.map, color: AppColors.footerIcon, size: 40), // ✅ અપડેટેડ
                const SizedBox(height: 10),
                Text(
                  'Open in Maps',
                  style: TextStyle(color: AppColors.footerText.withOpacity(0.7), fontSize: 13), // ✅ અપડેટેડ
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 કોલમ ૪: ગોલ્ડન સરનામું કાર્ડ
  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.buttonSecondary, // ✅ અપડેટેડ: ગ્લોબલ સેકન્ડરી ગોલ્ડન/પીળો
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ગુજરાતamp; રાજ્યપુરોહિત સમાજ',
            style: GoogleFonts.notoSansGujarati(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary, // ✅ અપડેટેડ: ડાર્ક પ્રાઈમરી ટેક્સ્ટ
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildAddressRow(Icons.phone, '+91 95743-09096'),
          _buildAddressRow(Icons.email, 'info@rayapurohitonline.in'),
          _buildAddressRow(
            Icons.location_on,
            'ગુજરાત રાજ્યપુરોહિત સમાજ,\nમહાજન વાડી, પંચેશ્વર ટાવર,\nજામનગર - ૩૬૧૦૦૧. ગુજરાત. ઇન્ડિયા.',
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
          Icon(icon, size: 16, color: AppColors.primary), // ✅ અપડેટેડ
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.notoSansGujarati(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary, // ✅ અપડેટેડ
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 બોટમ કોપીરાઈટ અને ક્રાફ્ટેડ બાય લીંક
  Widget _buildBottomBar(bool isWeb) {
    final textStyle = GoogleFonts.notoSansGujarati(
      textStyle: TextStyle(fontSize: 13, color: AppColors.footerText.withOpacity(0.4)), // ✅ અપડેટેડ
    );

    final content = [
      Text(
        '© 2026 ગુજરાત રાજ્યપુરોહિત સમાજ | Powered by RajyapurohitOnline.in',
        style: textStyle,
      ),
      if (isWeb) const Spacer(),
      if (!isWeb) const SizedBox(height: 10),
      Text(
        'Crafted by iNTELLIGENT tECH',
        style: textStyle,
      ),
    ];

    return isWeb ? Row(children: content) : Column(children: content);
  }
}