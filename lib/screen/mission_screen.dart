import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/mission_controller.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/mission_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/mission_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/mission_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mission_controller.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

class MissionScreen extends GetView<MissionController> {
  static const pageId = "/MissionScreen";
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMissionHeaderBanner(isWeb, screenWidth),    // ૧. મુખ્ય હેડર બેનર
            _buildDetailedVisionMission(isWeb, screenWidth),  // ૨. વિગતવાર વિઝન અને મિશન બ્લોક્સ
            _buildOriginalThreeBoxes(isWeb, screenWidth),     // ⚡ ૩. જાદુઈ ફિક્સ: તમારા ઓરિજિનલ ૩ બોક્સ અહીંયા એક્ટિવ કરી દીધા ભાઈ!
            const CustomFooter(),                             // ૪. કોમન રીયુઝેબલ ફૂટર
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૧. MAIN MISSION HEADER BANNER
  // ==========================================
  Widget _buildMissionHeaderBanner(bool isWeb, double screenWidth) {
    return Container(
      width: double.infinity,
      height: isWeb ? 75 : 60,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        image: DecorationImage(
          image: AssetImage('assets/images/team_bg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          'અમારો ઉદ્દેશ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isWeb ? 34 : 26,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૨. DETAILED VISION & MISSION SECTION (Equal Height Fixed)
  // ==========================================
  Widget _buildDetailedVisionMission(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 60.0,
    );

    final visionContent = _buildDetailedCard(
      icon: Icons.remove_red_eye_outlined,
      title: 'વિઝન (Vision)',
      tagline: '"પરંપરાનું ગૌરવ • એકતાનું બળ • પ્રગતિનો સંકલ્પ"',
      description: 'રાજ્ય પુરોહિત બ્રાહ્મણ જ્ઞાતને એકતાસભર, સંસ્કારસભર, શિક્ષિત, આત્મનિર્ભર અને પ્રગતિશીલ જ્ઞાત તરીકે વિકસાવવો, જે પોતાની વૈદિક પરંપરા, સાંસ્કૃતિક વારસા અને માનવમૂલ્યોનું ગૌરવપૂર્વક સંરક્ષણ કરે, શિક્ષણ, સેવા અને સંસ્કારોને જીવનનો આધાર બનાવે તથા દરેક પરિવારને સમાજ અને રાષ્ટ્રના સર્વાંગી વિકાસમાં સક્રિય અને ગૌરવપૂર્ણ યોગદાન આપવા માટે સશક્ત બનાવે.',
    );

    final missionContent = _buildDetailedCard(
      icon: Icons.track_changes_outlined,
      title: 'મિશન (Mission)',
      tagline: '"સંસ્કારથી સશક્તિકરણ • શિક્ષણથી ઉત્કર્ષ • સેવાથી જ્ઞાત કલ્યાણ"',
      description: 'રાજ્ય પુરોહિત બ્રાહ્મણ જ્ઞાતના દરેક સભ્યમાં એકતા, સહકાર અને સમર્પણની ભાવના વિકસાવવી; ગુણવત્તાયુક્ત શિક્ષણ, કૌશલ્ય વિકાસ, રોજગાર અને ઉદ્યોગસાહસિકતાને પ્રોત્સાહન આપવું; યુવાનો અને મહિલાઓને નેતૃત્વ તથા આત્મનિર્ભરતા માટે સશક્ત બનાવવું; જ્ઞાતની વૈદિક, ધાર્મિક અને સાંસ્કૃતિક પરંપરાનું જતન અને સંવર્ધન કરવું; જ્ઞાત કલ્યાણ, સેવા અને પરસ્પર સહયોગની પ્રવૃત્તિઓને મજબૂત બનાવવી; આધુનિક ટેક્નોલોજી અને ડિજિટલ પરિવર્તનને સ્વીકારી જ્ઞાતને નવી દિશા આપવી તથા રાજ્ય પુરોહિત બ્રાહ્મણ જ્ઞાતના દરેક પરિવારના સર્વાંગી વિકાસ, સુખાકારી અને સમૃદ્ધિ માટે સતત કાર્ય કરવું.',
    );

    return Container(
      padding: padding,
      color: AppColors.background,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isWeb
              ? IntrinsicHeight( // ➔ ⚡ ⚡ જાદુઈ વિજેટ: આ વ્હાઇટ સ્ક્રીનની એરર કાઢીને બંને બોક્સની સાઈઝ સમાન રાખશે ભાઈ!
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: visionContent),
                const SizedBox(width: 40),
                Expanded(child: missionContent),
              ],
            ),
          )
              : Column(
            children: [
              visionContent,
              const SizedBox(height: 40),
              missionContent,
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૩. ORIGINAL THREE BOXES SECTION (પુનઃસ્થાપિત ભાઈ)
  // ==========================================
  Widget _buildOriginalThreeBoxes(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 50.0,
    );

    final gridItems = [
      _buildMissionCard(
        imagePath: 'assets/images/earth.png',
        placeholderIcon: Icons.handshake_outlined,
        title: 'સમાજની એકતા - Community Unity',
        description: 'રાજયગોર જ્ઞાતના દરેક સભ્યોને એક મંચ પર લાવવાનો ઉદ્દેશ છે - Fostering unity, mutual support, and a shared identity among all RajyaGor Families across Gujarat.',
      ),
      _buildMissionCard(
        imagePath: 'assets/images/earth.png',
        placeholderIcon: Icons.public,
        title: 'શિક્ષણ અને સહાય - Education & Empowerment',
        description: 'જ્ઞાતના યુવાનોને ઉચ્ચ શિક્ષણ, માર્ગદર્શન અને રોજગારીના અવસર ઉપલબ્ધ કરાવવાના પ્રયત્નો - empowering our new generation through learning and career support.',
      ),
      _buildMissionCard(
        imagePath: 'assets/images/earth.png',
        placeholderIcon: Icons.groups_outlined,
        title: 'સામાજિક સેવા - Social & Cultural Growth',
        description: 'આરોગ્ય, માનવ સેવા અને સાંસ્કૃતિક કાર્યક્રમો દ્વારા જ્ઞાતનો સર્વાંગી વિકાસ - promoting compassion, service, and cultural pride in every initiative.',
      ),
    ];

    return Container(
      padding: padding,
      color: Colors.black.withOpacity(0.012), // આછો સોફ્ટ ટોન સેપરેશન માટે ભાઈ
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isWeb
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: gridItems
                .map((card) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: card,
              ),
            ))
                .toList(),
          )
              : Column(
            children: gridItems
                .map((card) => Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: card,
            ))
                .toList(),
          ),
        ),
      ),
    );
  }

  // ➔ ૧. DETAILED CARD WITH JUSTIFIED TEXT (વિઝન/મિશન માટે ભાઈ)
  // ========================================================
  Widget _buildDetailedCard({
    required IconData icon,
    required String title,
    required String tagline,
    required String description,
  }) {
    final RxBool isHovered = false.obs;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(30.0),
        height: double.infinity, // ➔ ⚡ IntrinsicHeight સાથે કમ્બાઈન થઈને આપોઆપ બોક્સ ખેંચાઈ જશે ભાઈ
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHovered.value
                ? AppColors.accent.withOpacity(0.5)
                : Colors.black.withOpacity(0.04),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered.value ? Colors.black.withOpacity(0.08) : Colors.black.withOpacity(0.02),
              blurRadius: isHovered.value ? 20 : 10,
              offset: isHovered.value ? const Offset(0, 8) : const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.accent, size: 32),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.heading,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              tagline,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 15),

            // ➔ ⚡ ટકાટક જસ્ટિફાય લખાણ કોઈ પણ એરર વગર રન થશે ભાઈ
            Expanded(
              child: Text(
                description,
                textAlign: TextAlign.justify, // કમ્પ્લીટલી જસ્ટિફાય લોક છે ભાઈ
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.body.withOpacity(0.9),
                  height: 1.7,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  // ========================================================
  // ➔ ૨. MISSION CARD WITH JUSTIFIED TEXT (ઈમેજ વાળું કાર્ડ ભાઈ)
  // ========================================================
  // ========================================================
  // ➔ ૨. MISSION CARD WITH JUSTIFIED TEXT (ઈમેજ વાળું કાર્ડ ભાઈ)
  // ========================================================
  Widget _buildMissionCard({
    required String imagePath,
    required IconData placeholderIcon,
    required String title,
    required String description,
  }) {
    final RxBool isCardHovered = false.obs;

    return MouseRegion(
      onEnter: (_) => isCardHovered.value = true,
      onExit: (_) => isCardHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: Obx(() => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        // ➔ ⚡ ⚡ જાદુઈ ફિક્સ: ત્રણ ડોટ (...) કાઢીને બે ડોટ (.. ) કમ્પ્લીટ લોક કર્યા ભાઈ!
        transform: Matrix4.identity()..translate(0.0, isCardHovered.value ? -6.0 : 0.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCardHovered.value ? AppColors.accent.withOpacity(0.4) : Colors.black.withOpacity(0.03),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isCardHovered.value ? Colors.black.withOpacity(0.08) : Colors.black.withOpacity(0.03),
              blurRadius: isCardHovered.value ? 20 : 10,
              offset: isCardHovered.value ? const Offset(0, 10) : const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 11,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    color: AppColors.cardBorder.withOpacity(0.5),
                    alignment: Alignment.center,
                    child: Icon(placeholderIcon, size: 45, color: AppColors.subtitle),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.w900,
                color: AppColors.heading,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),

            // ➔ ⚡ મિશન ડિસ્ક્રિપ્શન ટકાટક જસ્ટિફાય ચાલુ જ રહેશે ભાઈ
            Text(
              description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 13.5,
                color: AppColors.body.withOpacity(0.85),
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