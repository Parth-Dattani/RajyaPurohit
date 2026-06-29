import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/about_controller.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

class AboutScreen extends GetView<AboutController> {
  static const pageId = "/AboutScreen";
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background, // ✅ અપડેટેડ: ગ્લોબલ બેકગ્રાઉન્ડ
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAboutHeaderBanner(isWeb, screenWidth),   // ૧. મુખ્ય બેનર સેક્શન
            _buildMergedContentSection(isWeb, screenWidth), // ૨. મર્જડ કન્ટેન્ટ સેક્શન
            _buildMissionVisionValuesSection(isWeb, screenWidth), // ૪. મિશન, વિઝન, વેલ્યુ સેક્શન
            _buildDigitalConnectSection(isWeb, screenWidth),      // ૫. ડિજિટલ કનેક્ટ સેક્શન
            const CustomFooter(),                           // ૩. કોમન ફૂટર
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૧. MAIN HEADER BANNER
  // ==========================================
  Widget _buildAboutHeaderBanner(bool isWeb, double screenWidth) {
    return Container(
      width: double.infinity,
      height: isWeb ? 300 : 200,
      decoration: const BoxDecoration(
        color: AppColors.primary, // ✅ અપડેટેડ: ડાર્ક બ્રાન્ડ કલર
        image: DecorationImage(
          image: AssetImage('assets/images/community_bg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.25,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'અમારા વિષે',
            style: GoogleFonts.notoSansGujarati(
              textStyle: TextStyle(
                fontSize: isWeb ? 54 : 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'હોમ',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('/', style: TextStyle(color: AppColors.accent, fontSize: 14)), // ✅ અપડેટેડ
              ),
              Text(
                'અમારા વિષે',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: const TextStyle(
                    color: AppColors.accent, // ✅ અપડેટેડ
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૨. MERGED CONTENT SECTION
  // ==========================================
  Widget _buildMergedContentSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 70.0,
    );

    final imageStackContent = SizedBox(
      height: 480,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 40,
            bottom: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/images/about_group.jpg',
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: AppColors.cardBorder, child: const Icon(Icons.people, size: 50, color: AppColors.subtitle)), // ✅ અપડેટેડ
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 60,
            width: 220,
            height: 220,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.background, width: 8), // ✅ અપડેટેડ
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  'assets/images/about_hands.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: AppColors.cardBorder, child: const Icon(Icons.handshake, size: 40, color: AppColors.subtitle)), // ✅ અપડેટેડ
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final mergedTextContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'અમારા વિષે',
          style: GoogleFonts.notoSansGujarati(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.accent, // ✅ અપડેટેડ
            ),
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: GoogleFonts.notoSansGujarati(
              textStyle: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.w900,
                color: AppColors.heading, // ✅ અપડેટેડ
                height: 1.2,
              ),
            ),
            children: const [
              TextSpan(text: 'સમાજને જોડે છે '),
              TextSpan(text: 'Rajyapurohit', style: TextStyle(color: AppColors.accent)), // ✅ અપડેટેડ
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'ગુજરાત રાજ્યપુરોહિત સમાજનું આ એક અધિકૃત ડિજિટલ પ્લેટફોર્મ છે, જેનો મુખ્ય ઉદ્દેશ્ય સમગ્ર દેશ અને વિદેશમાં વસતા સમાજના પરિવારોને એક તાંતણે બાંધવાનો છે. આ માધ્યમ દ્વારા શૈક્ષણિક, સામાજિક, અને વ્યાપારી પ્રગતિ વેગવંતી બનશે.',
          style: GoogleFonts.notoSansGujarati(
            textStyle: TextStyle(
              fontSize: 15,
              color: AppColors.body.withOpacity(0.85), // ✅ અપડેટેડ
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 20),

        _buildCheckPointRow('ઈ-મેમ્બર_શીપ અને સમુદાય સેવાઓ'),
        const SizedBox(height: 12),
        _buildCheckPointRow('આપત્તિ વેળાએ સેવા-સમર્પણ'),
        const SizedBox(height: 30),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.02),
            border: const Border(left: BorderSide(color: AppColors.accent, width: 4)), // ✅ અપડેટેડ
            borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'સમાજ સેવા સપોર્ટ',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.heading), // ✅ અપડેટેડ
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'રાજ્યપુરોહિત સમાજના સર્વાંગી વિકાસ માટે સતત સેવા અને સહકાર.',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: TextStyle(fontSize: 14, color: AppColors.body.withOpacity(0.7), fontWeight: FontWeight.w500), // ✅ અપડેટેડ
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),

        Wrap(
          spacing: 25.0,
          runSpacing: 20.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent, // ✅ અપડેટેડ
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () {},
              child: Text(
                'અમારી સાથે જોડાઓ  ➔',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle), // ✅ અપડેટેડ
                  child: const Icon(Icons.phone, color: Colors.white, size: 18), // ✅ અપડેટેડ
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Call Us Anytime',
                      style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12, color: AppColors.subtitle, fontWeight: FontWeight.w500)), // ✅ અપડેટેડ
                    ),
                    Text(
                      '+91 95743-09096',
                      style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 15, color: AppColors.heading, fontWeight: FontWeight.bold)), // ✅ અપડેટેડ
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    );

    return Container(
      padding: padding,
      child: isWeb
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 10, child: imageStackContent),
          const SizedBox(width: 65),
          Expanded(flex: 12, child: mergedTextContent),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageStackContent,
          const SizedBox(height: 50),
          mergedTextContent,
        ],
      ),
    );
  }

  Widget _buildCheckPointRow(String pointText) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.primary, // ✅ અપડેટેડ
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 15),
        Text(
          pointText,
          style: GoogleFonts.notoSansGujarati(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.heading, // ✅ અપડેટેડ
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 🔹 ૪. MISSION, VISION, VALUES SECTION
  // ==========================================
  Widget _buildMissionVisionValuesSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 60.0,
    );

    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.015), // સોફ્ટ લાઈટ ટોન લાવવા માટે આછો ઓપેસિટી કલર
      padding: padding,
      child: Column(
        children: [
          isWeb
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildValueColumn(
                  title: 'અમારું મિશન',
                  description: 'ગુજરાતમાં 1,0,000+ રાજ્યપુરોહિત પરિવારોને ઓનલાઇન જોડવા અને સશક્ત બનાવવું.',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildValueColumn(
                  title: 'અમારી વિઝન',
                  description: 'એકતા, પારદર્શિતા અને ટેક્નોલોજીથી સમાજ વિકાસ માટે મજબૂત પ્લેટફોર્મ.',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildValueColumn(
                  title: 'અમારી મૂલ્યો',
                  description: 'સેવા, વિશ્વાસ, સહકાર અને સંસ્કારોનું સંવર્ધન.',
                ),
              ),
            ],
          )
              : Column(
            children: [
              _buildValueColumn(
                title: 'અમારું મિશન',
                description: 'ગુજરાતમાં 1,0,000+ રાજ્યપુરોહિત પરિવારોને ઓનલાઇન જોડવા અને સશક્ત બનાવવું.',
              ),
              _buildHorizontalDivider(),
              _buildValueColumn(
                title: 'અમારી વિઝન',
                description: 'એકતા, પારદર્શિતા અને ટેક્નોલોજીથી સમાજ વિકાસ માટે મજબૂત પ્લેટફોર્મ.',
              ),
              _buildHorizontalDivider(),
              _buildValueColumn(
                title: 'અમારી મૂલ્યો',
                description: 'સેવા, વિશ્વાસ, સહકાર અને સંસ્કારોનું સંવર્ધન.',
              ),
            ],
          ),
          const SizedBox(height: 50),

          Text(
            "You're always welcome here.",
            style: GoogleFonts.alexBrush(
              textStyle: const TextStyle(
                fontSize: 32,
                color: AppColors.accent, // ✅ અપડેટેડ
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueColumn({required String title, required String description}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSansGujarati(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppColors.heading, // ✅ અપડેટેડ
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 290),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansGujarati(
              textStyle: TextStyle(
                fontSize: 14.5,
                color: AppColors.body.withOpacity(0.9), // ✅ અપડેટેડ
                height: 1.6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 100,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.divider, // ✅ અપડેટેડ
    );
  }

  Widget _buildHorizontalDivider() {
    return Container(
      width: 120,
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 35),
      color: AppColors.divider, // ✅ અપડેટેડ
    );
  }

  // ==========================================
  // 🔹 ૫. DIGITAL CONNECT SECTION
  // ==========================================
  Widget _buildDigitalConnectSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.only(
      left: isWeb ? screenWidth * 0.08 : 24.0,
      right: isWeb ? screenWidth * 0.08 : 24.0,
      top: 80.0,
      bottom: isWeb ? 0.0 : 60.0,
    );

    final leftColumnContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '>ગુજરાત રાજ્યપુરોહિત સમાજ',
          style: GoogleFonts.notoSansGujarati(
            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.accent), // ✅ અપડેટેડ
          ),
        ),
        const SizedBox(height: 12),
        RichText(
          text: TextSpan(
            style: GoogleFonts.notoSansGujarati(
              textStyle: const TextStyle(
                fontSize: 54,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1.15,
              ),
            ),
            children: const [
              TextSpan(text: 'સમાજને\n'),
              TextSpan(text: 'ડિજિટલ રીતે જોડીએ', style: TextStyle(color: AppColors.accent)), // ✅ અપડેટેડ
            ],
          ),
        ),
        const SizedBox(height: 40),

        // ઈમેજ બ્લોક
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          child: Image.asset(
            'assets/images/earth_blue.png',
            height: isWeb ? 340 : 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              height: 300,
              color: Colors.white10,
              child: const Icon(Icons.remove_red_eye, size: 60, color: Colors.white24),
            ),
          ),
        ),
      ],
    );

    final rightColumnContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'ઈ-મેમ્બરશીપ, બિઝનેસ કોમ્યુનિટી સર્ચ, મેટ્રિમોની અને સહાય જેવી સેવાઓને એક પ્લેટફોર્મ પર સુરક્ષિત રીતે ઉપલબ્ધ કરાવવાનું અમારું ધ્યેય છે.',
          style: GoogleFonts.notoSansGujarati(
            textStyle: TextStyle(
              fontSize: 16,
              color: AppColors.whiteText.withOpacity(0.85), // ✅ અપડેટેડ
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 45),

        isWeb
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 140,
              child: Text(
                'Our Mission',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'OTP વેરીફિકેશનથી ઝડપી નોંધણી, પરિવારની વિગતો સાથે સચોટ ડેટાબેઝ અને પારદર્શિતાથી સમાજ વિકાસ.',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: TextStyle(color: AppColors.whiteText.withOpacity(0.65), fontSize: 14, height: 1.5, fontWeight: FontWeight.w500), // ✅ અપડેટેડ
                ),
              ),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Mission',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'OTP વેરીફિકેશનથી ઝડપી નોંધણી, પરિવારની વિગતો સાથે સચોટ ડેટાબેઝ અને પારદર્શિતાથી સમાજ વિકાસ.',
              style: GoogleFonts.notoSansGujarati(
                textStyle: TextStyle(color: AppColors.whiteText.withOpacity(0.65), fontSize: 14, height: 1.5, fontWeight: FontWeight.w500), // ✅ અપડેટેડ
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'અમારી સેવાઓ ',
                  style: GoogleFonts.notoSansGujarati(
                    textStyle: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold, fontSize: 14), // ✅ અપડેટેડ
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, color: AppColors.accent, size: 14), // ✅ અપડેટેડ
              ],
            ),
          ),
        ),
        if (isWeb) const SizedBox(height: 50),
      ],
    );

    return Container(
      width: double.infinity,
      color: AppColors.primary, // ✅ અપડેટેડ: ડાર્ક થીમ બેકગ્રાઉન્ડ બ્લોક
      padding: padding,
      child: isWeb
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(flex: 9, child: leftColumnContent),
          const SizedBox(width: 80),
          Expanded(flex: 11, child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: rightColumnContent,
          )),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leftColumnContent,
          const SizedBox(height: 40),
          rightColumnContent,
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}