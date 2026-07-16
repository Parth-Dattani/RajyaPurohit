import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/app_colors.dart';
import '../../widgets/custom_footer.dart';
import '../../controllers/membership_controller.dart';
import '../../widgets/widgets.dart';
import '../home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constant/app_colors.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_footer.dart';

class MembershipScreen extends GetView<MembershipController> {
  static const pageId = "/MembershipScreen";
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background, // ✅ અપડેટેડ: ગ્લોબલ સરફેસ બેકગ્રાઉન્ડ
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMembershipHeroSection(isWeb, screenWidth), // મુખ્ય આકર્ષક સેક્શન
            _buildWhyJoinSection(isWeb, screenWidth),
            const CustomFooter(), // આપણું કોમન રીયુઝેબલ ફૂટર
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 MAIN MEMBERSHIP HERO SECTION
  // ==========================================
  Widget _buildMembershipHeroSection(bool isWeb, double screenWidth) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 20.0,
        vertical: isWeb ? 100.0 : 60.0,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background, // ✅ અપડેટેડ
        image: DecorationImage(
          image: AssetImage('assets/images/mandala_pattern.png'),
          fit: BoxFit.contain,
          opacity: 0.04,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ૧. નાનું ગોળાકાર હાઇલાઇટ બેજ
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.buttonSecondary.withOpacity(0.25), // ✅ અપડેટેડ
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.buttonSecondary.withOpacity(0.5), width: 1), // ✅ અપડેટેડ
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(radius: 3, backgroundColor: AppColors.accent), // ✅ અપડેટેડ
                const SizedBox(width: 8),
                Text(
                  'ડિજિટલ સભ્ય નોંધણી અભિયાન',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.heading), // ✅ અપડેટેડ
                  ),

              ],
            ),
          ),
          const SizedBox(height: 30),

          // ૨. મુખ્ય મોટું ટાઇટલ (૨ લાઇન લુક)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style:  TextStyle(
                  fontSize: isWeb ? 64 : 38,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              children: const [
                TextSpan(text: 'સમસ્ત રાજ્યપુરોહિત (રાજગોર)\n', style: TextStyle(color: AppColors.heading)), // ✅ અપડેટેડ
                TextSpan(text: 'બ્રાહ્મણ જ્ઞાતિ', style: TextStyle(color: AppColors.accent)), // ✅ અપડેટેડ
              ],
            ),
          ),
          const SizedBox(height: 30),

          // ૩. સબટાઇટલ ડિસ્ક્રિપ્શન પેરેગ્રાફ
          Container(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Text(
              'સમાજના ઉત્કર્ષ અને સંગઠન માટેની આ ડિજિટલ પહેલમાં આજે જ જોડાઓ. તમારું ડિજિટલ ઓળખ પત્ર મેળવો.',
              textAlign: TextAlign.center,
              style:  TextStyle(
                  fontSize: isWeb ? 16 : 14,
                  color: AppColors.body.withOpacity(0.85), // ✅ અપડેટેડ
                  height: 1.6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

          const SizedBox(height: 50),

          // ૪. એક્શન બટન્સ રો / કોલમ ગ્રીડ
          isWeb
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildActionButtons(),
          )
              : Column(
            children: _buildActionButtons()
                .map((btn) => Padding(padding: const EdgeInsets.only(bottom: 16), child: SizedBox(width: double.infinity, child: btn)))
                .toList(),
          ),
        ],
      ),
    );
  }

  // --- બટન્સ જનરેટ કરવાનું હેલ્પર મોડ્યુલ ---
  List<Widget> _buildActionButtons() {
    return [
      // ➔ બટન ૧: સભ્ય નોંધણી શરૂ કરો (રોયલ ડાર્ક બ્લુ)
      _buildHeroButton(
        text: 'સભ્ય નોંધણી શરૂ કરો  ➔',
        bgColor: AppColors.primary, // ✅ અપડેટેડ: નવો મેઈન થીમ કલર
        textColor: AppColors.whiteText, // ✅ અપડેટેડ
        onPressed: () => controller.startNewRegistration(),
      ),
      const SizedBox(width: 16),

      // ➔ બટન ૨: જૂના સભ્ય લોગિન કરો (ગોલ્ડન એક્સેન્ટ)
      _buildHeroButton(
        text: 'જૂના સભ્ય લોગિન કરો  ➔',
        bgColor: AppColors.textOrange, // ✅ અપડેટેડ
        textColor: AppColors.whiteText, // ✅ અપડેટેડ
        onPressed: () => controller.loginExistingMember(),
      ),
      const SizedBox(width: 16),

      // // ➔ બટન ૩: મોબાઇલ એપ (સેકન્ડરી ગોલ્ડન / પીળો)
      // _buildHeroButton(
      //   text: 'મોબાઈલ એપ  ➔',
      //   bgColor: AppColors.buttonSecondary, // ✅ અપડેટેડ
      //   textColor: AppColors.primary, // ✅ અપડેટેડ: લખાણ ડાર્ક બ્લુ
      //   onPressed: () => controller.downloadMobileApp(),
      // ),
    ];
  }

  // ==========================================
  // 🔹 DYNAMIC HOVER BUTTONS WIDGET MODULE
  // ==========================================
  Widget _buildHeroButton({
    required String text,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    final RxBool isHovered = false.obs;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, isHovered.value ? -5.0 : 0.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(isHovered.value ? 0.35 : 0.2),
              blurRadius: isHovered.value ? 20 : 12,
              offset: isHovered.value ? const Offset(0, 10) : const Offset(0, 6),
            )
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 20),
            minimumSize: const Size(150, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
// 🔹 ૨. WHY JOIN SECTION (ગુજરાતી સ્પેલિંગ સુધારેલ ભાઈ)
// ==========================================
  Widget _buildWhyJoinSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 16.0,
      vertical: isWeb ? 80.0 : 40.0,
    );

    final cards = [
      _buildWhyJoinCard(
        isWeb: isWeb,
        title: 'વૈશ્વિક જોડાણ',
        description: 'વિશ્વભરના રાજયગોર પરિવારો સાથે જોડાઓ અને સમાજને મજબૂત બનાવો.',
        iconData: Icons.people_alt_outlined,
      ),
      _buildWhyJoinCard(
        isWeb: isWeb,
        title: 'સુરક્ષિત માહિતી',
        // ➔ ⚡ ⚡ ટકાટક ફિક્સ: 'khાનગી' માંથી બદલીને શુદ્ધ ગુજરાતીમાં 'ખાનગી' લોક કરી દીધું ભાઈ!
        description: 'તમારી અને તમારા પરિવારની માહિતી સંપૂર્ણપણે સુરક્ષિત અને ખાનગી રહેશે.',
        iconData: Icons.gpp_good_outlined,
      ),
      _buildWhyJoinCard(
        isWeb: isWeb,
        title: 'સમાજ સેવા',
        description: 'સમાજના વિવિધ પ્રકલ્પો અને સેવા કાર્યોમાં સહભાગી બનો.',
        iconData: Icons.favorite_border,
      ),
    ];

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'શા માટે જોડાવું જોઈએ?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppColors.heading,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 4.5,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 60),

          isWeb
              ? IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cards
                  .map((card) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: card,
                ),
              ))
                  .toList(),
            ),
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cards
                .map((card) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: card,
            ))
                .toList(),
          ),
        ],
      ),
    );
  }

// ==========================================
// 🔹 ૪. WHY JOIN SINGLE CARD WIDGET (FULLY RESPONSIVE)
// ==========================================
  Widget _buildWhyJoinCard({
    required bool isWeb, // 👈 નવો પેરામીટર એડ કર્યો ભાઈ
    required String title,
    required String description,
    required IconData iconData,
  }) {
    final RxBool isCardHovered = false.obs;

    return MouseRegion(
        onEnter: (_) => isCardHovered.value = true,
        onExit: (_) => isCardHovered.value = false,
        child: Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()..translate(0.0, isCardHovered.value ? -6.0 : 0.0),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 45.0),
          // ➔ ⚡ ⚡ હાઇટ ફિક્સ: વેબ હોય તો જ 'double.infinity' લેશે, મોબાઈલમાં કન્ટેન્ટ પ્રમાણે ઓટોમેટીક એડજસ્ટ થશે!
          height: isWeb ? double.infinity : null,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCardHovered.value ? AppColors.accent.withOpacity(0.3) : AppColors.cardBorder.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isCardHovered.value ? Colors.black.withOpacity(0.08) : Colors.black.withOpacity(0.02),
                blurRadius: isCardHovered.value ? 20 : 10,
                offset: isCardHovered.value ? const Offset(0, 10) : const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max, // 👈 Column ને આખી સ્પેસ કવર કરવા દીધી ભાઈ
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondary.withOpacity(0.35),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  iconData,
                  size: 28,
                  color: AppColors.card,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.whiteText,
                ),
              ),
              const SizedBox(height: 14),

              // ➔ ⚡ ⚡ બીજો મોટો ફિક્સ: વેબ પર ટેક્સ્ટને Expanded માં રાખ્યો, જેથી નાના લખાણ વાળું કાર્ડ પણ આખું છેક નીચે સુધી ખેંચાઈ જાય!
              if (isWeb)
                Expanded(
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.card.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                  ),
                )
              else
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.card.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
            ],
          ),
        )),
    );
  }
}

