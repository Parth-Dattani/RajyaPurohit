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

class MissionScreen extends GetView<MissionController> {
  static const pageId = "/MissionScreen";
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background, // ✅ અપડેટેડ: ગ્લોબલ સરફેસ
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMissionHeaderBanner(isWeb, screenWidth), // ૧. મુખ્ય હેડર બેનર
            _buildGridContentSection(isWeb, screenWidth),  // ૨. ઈમેજ ગ્રીડ બ્લોક
            const CustomFooter(),                          // ૩. કોમન રીયુઝેબલ ફૂટર
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
      height: isWeb ? 300 : 200,
      decoration: const BoxDecoration(
        color: AppColors.primary, // ✅ અપડેટેડ: મેઈન ડાર્ક બ્રાન્ડ કલર
        image: DecorationImage(
          image: AssetImage('assets/images/community_art_bg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'અમારો ઉદ્દેશ',
            style:  TextStyle(
                fontSize: isWeb ? 52 : 34,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'હોમ',
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w500),
                ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('/', style: TextStyle(color: AppColors.accent, fontSize: 14)), // ✅ અપડેટેડ
              ),
              Text(
                'અમારો ઉદ્દેશ',
                style:  const TextStyle(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.bold), // ✅ અપડેટેડ
                ),

            ],
          )
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૨. GRID CONTENT SECTION
  // ==========================================
  Widget _buildGridContentSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 60.0,
    );

    final gridItems = [
      _buildMissionCard(
        imagePath: 'assets/images/earth.png',
        placeholderIcon: Icons.handshake_outlined,
        title: 'સમાજની એકતા - Community Unity',
        description: 'રાજયગોર સમાજના દરેક સભ્યોને એક મંચ પર લાવવાનો ઉદ્દેશ છે - Fostering unity, mutual support, and a shared identity among all Rajyapurohit Families across Gujarat.',
      ),
      _buildMissionCard(
        imagePath: 'assets/images/earth.png',
        placeholderIcon: Icons.public,
        title: 'શિક્ષણ અને સહાય - Education & Empowerment',
        description: 'સમાજના યુવાનોને ઉચ્ચ શિક્ષણ, માર્ગદર્શન અને રોજગારીના અવસર ઉપલબ્ધ કરાવવાના પ્રયત્નો - empowering our new generation through learning and career support.',
      ),
      _buildMissionCard(
        imagePath: 'assets/images/earth.png',
        placeholderIcon: Icons.groups_outlined,
        title: 'સામાજિક સેવા - Social & Cultural Growth',
        description: 'આરોગ્ય, માનવ સેવા અને સાંસ્કૃતિક કાર્યક્રમો દ્વારા સમાજનો સર્વાંગી વિકાસ - promoting compassion, service, and cultural pride in every initiative.',
      ),
    ];

    return Container(
      padding: padding,
      color: AppColors.background, // ✅ અપડેટેડ
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
    );
  }

  // ==========================================
  // 🔹 ઈમેજ અને લખાણ એક જ કન્ટેનરમાં + સ્મૂથ હોવર ઇફેક્ટ
  // ==========================================
  // ==========================================
  // 🔹 ઈમેજ અને લખાણ એક જ કન્ટેનરમાં + સ્મૂથ હોવર ઇફેક્ટ (એરર ફિક્સ વર્ઝન)
  // ==========================================
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
        // ➔ ✅ અહીંયા છેલ્લે કૌંસ ')' બરાબર બંધ કરી દીધો છે ભાઈ!
        transform: Matrix4.identity()..translate(0.0, isCardHovered.value ? -6.0 : 0.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCardHovered.value
                ? AppColors.accent.withOpacity(0.4)
                : Colors.black.withOpacity(0.03),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isCardHovered.value
                  ? Colors.black.withOpacity(0.08)
                  : Colors.black.withOpacity(0.03),
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
                    child:  Icon(placeholderIcon, size: 45, color: AppColors.subtitle),
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

            Text(
              description,
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