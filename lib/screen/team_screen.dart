import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';
import '../controllers/team_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

class TeamScreen extends GetView<TeamController> {
  static const pageId = "/TeamScreen";
  const TeamScreen({super.key});

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
            _buildTeamHeaderBanner(isWeb),
            _buildTeamFilterSection(isWeb, screenWidth),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૧. TEAM HEADER BANNER
  // ==========================================
  Widget _buildTeamHeaderBanner(bool isWeb) {
    return Container(
      width: double.infinity,
      height: isWeb ? 300 : 200,
      decoration: const BoxDecoration(
        color: AppColors.primary, // ✅ અપડેટેડ: મેઈન ડાર્ક બ્રાન્ડ બ્લુ
        image: DecorationImage(
          image: AssetImage('assets/images/team_bg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'અમારી ટીમ',
            style: GoogleFonts.notoSansGujarati(
              textStyle: TextStyle(
                fontSize: isWeb ? 54 : 36,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'હોમ',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('/', style: TextStyle(color: AppColors.accent, fontSize: 14)), // ✅ અપડેટેડ
              ),
              Text(
                'અમારી ટીમ',
                style: GoogleFonts.notoSansGujarati(
                  textStyle: const TextStyle(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.bold), // ✅ અપડેટેડ
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૨. TEAM FILTER SECTION
  // ==========================================
  Widget _buildTeamFilterSection(bool isWeb, double screenWidth) {
    return Container(
      width: double.infinity,
      color: AppColors.background, // ✅ અપડેટેડ
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 16.0,
        vertical: 40.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // હોરિઝોન્ટલ સ્ક્રોલેબલ ફિલ્ટર ચિપ્સ
          SizedBox(
            height: 46,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final cat = controller.categories[index];

                return Obx(() {
                  final isSelected = controller.selectedCategory.value == cat;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => controller.changeCategory(cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.white, // ✅ અપડેટેડ
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.heading.withOpacity(0.15), // ✅ અપડેટેડ
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              cat,
                              style: GoogleFonts.notoSansGujarati(
                                textStyle: TextStyle(
                                  fontSize: 13.5,
                                  color: isSelected ? Colors.white : AppColors.heading, // ✅ અપડેટેડ
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),

          const SizedBox(height: 40),

          // ડાયનેમિક કેટેગરીવાઇઝ સેક્શન્સ
          _buildCategorizedTeamList(isWeb),
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૩. CATEGORIZED TEAM LIST
  // ==========================================
  Widget _buildCategorizedTeamList(bool isWeb) {
    return Obx(() {
      final currentFilter = controller.selectedCategory.value;

      if (currentFilter == 'બધા') {
        final activeCategories = controller.categories.where((cat) => cat != 'બધા').toList();

        return Column(
          children: activeCategories.map((category) {
            final categoryMembers = controller.teamMembers.where((m) => m.role == category).toList();

            if (categoryMembers.isEmpty) return const SizedBox.shrink();

            return _buildCategoryGroup(category, categoryMembers, isWeb);
          }).toList(),
        );
      } else {
        final selectedMembers = controller.filteredMembers;
        return _buildCategoryGroup(currentFilter, selectedMembers, isWeb);
      }
    });
  }

  // --- હેલ્પર મોડ્યુલ: સિંગલ કેટેગરી બ્લોક ---
  Widget _buildCategoryGroup(String title, List<dynamic> members, bool isWeb) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.notoSansGujarati(
              textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.heading), // ✅ અપડેટેડ
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 45,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.accent, // ✅ અપડેટેડ
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 30),

          Wrap(
            spacing: 24.0,
            runSpacing: 24.0,
            alignment: WrapAlignment.center,
            children: members.map((member) => _buildMemberCard(member, isWeb)).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- હેલ્પર વિજેટ: સિંગલ ટીમ મેમ્બરカード ---
  Widget _buildMemberCard(dynamic member, bool isWeb) {
    final double cardWidth = isWeb ? 270 : double.infinity;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
      decoration: BoxDecoration(
        color: AppColors.cardBorder.withOpacity(0.2), // ✅ અપડેટેડ: થીમ મેચ સોફ્ટ કલર
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: member.imageUrl != null
                  ? Image.asset(member.imageUrl!, fit: BoxFit.cover)
                  : Container(
                color: AppColors.primary.withOpacity(0.1), // ✅ અપડેટેડ
                alignment: Alignment.center,
                child: Text(
                  member.name.replaceAll('શ્રી ', '').replaceAll('શ્રીમતી ', '')[0],
                  style: GoogleFonts.notoSansGujarati(
                    textStyle: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.primary), // ✅ અપડેટેડ
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            member.role,
            style: GoogleFonts.notoSansGujarati(
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.body.withOpacity(0.65)), // ✅ અપડેટેડ
            ),
          ),
          const SizedBox(height: 8),

          Text(
            member.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSansGujarati(
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.heading, height: 1.3), // ✅ અપડેટેડ
            ),
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_android_rounded, size: 13, color: AppColors.accent.withOpacity(0.8)), // ✅ અપડેટેડ
              const SizedBox(width: 4),
              Text(
                member.phone,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.body.withOpacity(0.8)), // ✅ અપડેટેડ
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}