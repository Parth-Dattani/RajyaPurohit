import 'package:flutter/material.dart';
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
      color: const Color(0xFF4A0E17), // સ્ક્રીનશોટ મુજબ ઘાટો ડાર્ક મરૂન કલર
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

        // コલમ ૩: ગૂગલ મેપ પ્લેસહોલ્ડર
        Expanded(
          flex: 5,
          child: _buildMapColumn(),
        ),
        const SizedBox(width: 40),

        // કોલમ ૪: યેલો એડ્રેસ કાર્ડ (૧૦૦% કટોકટ લુક)
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
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'ગુજરાત રાજ્યપુરોહિત સમાજ દ્વારા બનાવાયેલ RajyapurohitOnline.in એક ડિજિટલ સામાજિક પ્લેટફોર્મ છે. અહીં સભ્યતા, બિઝનેસ, મે્ટ્રિમોની, હેલ્થ અને એજ્યુકેશન જેવી સેવાઓ ઉપલબ્ધ છે.',
          style: GoogleFonts.notoSansGujarati(
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
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
        child: Icon(icon, color: Colors.white70, size: 18),
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
        onTap: () {},
        child: Text(
          title,
          style: GoogleFonts.notoSansGujarati(
            textStyle: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7)),
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
            color: Colors.white70,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Icon(Icons.map, color: Colors.white70, size: 40),
                const SizedBox(height: 10),
                Text(
                  'Open in Maps',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 કોલમ ૪: પીળું સરનામું કાર્ડ
  Widget _buildAddressCard() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.btnYellow, // ગ્લોબલ યેલો/ગોલ્ડન કલર
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ગુજરાત રાજ્યપુરોહિત સમાજ',
            style: GoogleFonts.notoSansGujarati(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textMaroon,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildAddressRow(Icons.phone, '+91 95743-09096'),
          _buildAddressRow(Icons.email, 'info@rayapurohitonline.in'),
          _buildAddressRow(
            Icons.location_on,
            'ગુજરાત રાજ્યપુરોહિત સમાજ,\nજામનગર - 361006. ગુજરાત. ઇન્ડિયા.',
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
          Icon(icon, size: 16, color: AppColors.textMaroon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.notoSansGujarati(
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMaroon,
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
      textStyle: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.4)),
    );

    final content = [
      Text(
        '© 2026 ગુજરાત રાજ્યપુરોહિત સમાજ | Powered by RajyapurohitOnline.in',
        style: textStyle,
      ),
      if (isWeb) const Spacer(),
      if (!isWeb) const SizedBox(height: 10),
      Text(
        'Crafted by iNTELLIGENT tECH', // તમારા નવા બ્રાન્ડ નેમ સાથે પ્રોફેશનલ ટચ
        style: textStyle,
      ),
    ];

    return isWeb ? Row(children: content) : Column(children: content);
  }
}