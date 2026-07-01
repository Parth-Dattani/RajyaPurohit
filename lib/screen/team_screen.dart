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
      backgroundColor: AppColors.background,
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
  // 🔹 ૧. TEAM HEADER BANNER (કોમ્પેક્ટ સાઈઝ)
  // ==========================================
  Widget _buildTeamHeaderBanner(bool isWeb) {
    return Container(
      width: double.infinity,
      height: isWeb ? 220 : 180, // ✅ અપડેટેડ: વેબ માટે હાઈટ 300 થી ઘટાડીને 220 કરી ભાઈ
      decoration: const BoxDecoration(
        color: AppColors.primary,
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
            style:  TextStyle(
                fontSize: isWeb ? 44 : 32, // ✅ સેહજ ફોન્ટ સાઈઝ પણ બેલેન્સ કરી
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),

          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'હોમ',
                style:  TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w500),
                ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('/', style: TextStyle(color: AppColors.accent, fontSize: 14)),
              ),
              Text(
                'અમારી ટીમ',
                style:const TextStyle(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.bold),
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
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 16.0,
        vertical: isWeb ? 25.0 : 30.0, // ✅ વેબ માટે વર્ટિકલ સ્પેસ થોડી ઓછી કરી
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                            color: isSelected ? AppColors.primary : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.heading.withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              cat,
                              style: TextStyle(
                                  fontSize: 13.5,
                                  color: isSelected ? Colors.white : AppColors.heading,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
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

          SizedBox(height: isWeb ? 25 : 35), // ✅ ફિલ્ટર ચિપ્સ પછીનું સ્પેસિંગ ઘટાડ્યું

          _buildCategorizedTeamList(isWeb),
        ],
      ),
    );
  }

// ==========================================
  // 🔹 ૩. CATEGORIZED TEAM LIST (સ્માર્ટ સિંગલ/મલ્ટીપલ સભ્ય કન્ડીશન)
  // ==========================================
  Widget _buildCategorizedTeamList(bool isWeb) {
    return Obx(() {
      final currentFilter = controller.selectedCategory.value;

      if (currentFilter == 'બધા') {
        final activeCategories = controller.categories.where((cat) => cat != 'બધા').toList();

        if (isWeb) {
          // ૧. પ્રમુખ સેક્શન હંમેશા ટોપ પર સેન્ટર જ રહેશે
          final pramukhCategory = activeCategories.firstWhereOrNull((cat) => cat == 'પ્રમુખ');

          // ૨. બાકીની કેટેગરીઝમાંથી સિંગલ અને મલ્ટીપલ સભ્યોને અલગ પાડીએ ભાઈ
          final otherCategories = activeCategories.where((cat) => cat != 'પ્રમુખ').toList();

          final singleMemberCategories = <String>[];
          final multiMemberCategories = <String>[];

          for (var cat in otherCategories) {
            final count = controller.teamMembers.where((m) => m.role == cat).length;
            if (count == 1) {
              singleMemberCategories.add(cat);
            } else if (count > 1) {
              multiMemberCategories.add(cat);
            }
          }

          return Column(
            children: [
              // 👑 પ્રમુખ સેક્શન
              if (pramukhCategory != null) ...[
                (() {
                  final members = controller.teamMembers.where((m) => m.role == pramukhCategory).toList();
                  if (members.isEmpty) return const SizedBox.shrink();
                  return _buildCategoryGroup(pramukhCategory, members, isWeb);
                }()),
              ],

              // 🤝 ૧ જ સભ્ય ધરાવતા હોદ્દાઓ (ઉપપ્રમુખ, મંત્રી વગેરે બાજુ-બાજુમાં ગોઠવાશે ભાઈ)
              if (singleMemberCategories.isNotEmpty)
                Wrap(
                  spacing: 35.0,
                  runSpacing: 25.0,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: singleMemberCategories.map((category) {
                    final members = controller.teamMembers.where((m) => m.role == category).toList();
                    return _buildCategoryGroup(category, members, isWeb, isFlexMode: true);
                  }).toList(),
                ),

              // 👥 ૧ થી વધુ સભ્યો ધરાવતા હોદ્દાઓ (સમિતિ ચેરમેન, કારોબારી સભ્ય માટે ફૂલ વિડ્થ સેક્શન)
              if (multiMemberCategories.isNotEmpty)
                ...multiMemberCategories.map((category) {
                  final members = controller.teamMembers.where((m) => m.role == category).toList();
                  return _buildCategoryGroup(category, members, isWeb, isFlexMode: false);
                }).toList(),
            ],
          );
        } else {
          // મોબાઈલ માટે નોર્મલ વ્યુ
          return Column(
            children: activeCategories.map((category) {
              final categoryMembers = controller.teamMembers.where((m) => m.role == category).toList();
              if (categoryMembers.isEmpty) return const SizedBox.shrink();
              return _buildCategoryGroup(category, categoryMembers, isWeb);
            }).toList(),
          );
        }
      } else {
        final selectedMembers = controller.filteredMembers;
        return _buildCategoryGroup(currentFilter, selectedMembers, isWeb);
      }
    });
  }

  // --- હેલ્પર મોડ્યુલ: સિંગલ કેટેગરી બ્લોક (ડાયનેમિક પહોળાઈ) ---
  Widget _buildCategoryGroup(String title, List<dynamic> members, bool isWeb, {bool isFlexMode = false}) {
    // જો સિંગલ મેમ્બર હોય તો જ બોક્સ સાઈઝ નાની કરવાની, મલ્ટીપલ સભ્યો હોય તો આખી લાઈન વાપરશે ભાઈ
    final double? blockWidth = (isWeb && isFlexMode) ? 260.0 : null;

    return Container(
      width: blockWidth,
      padding: EdgeInsets.symmetric(
        vertical: isWeb ? 20.0 : 24.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style:  TextStyle(
                  fontSize: (isWeb && !isFlexMode && title != 'પ્રમુખ') ? 24 : 20, // મલ્ટીપલ સભ્યો વાળા હેડિંગ મોટા દેખાશે
                  fontWeight: FontWeight.w900,
                  color: AppColors.heading
              ),
            ),

          const SizedBox(height: 4),
          Container(
            width: (isWeb && !isFlexMode && title != 'પ્રમુખ') ? 50 : 35, // હેડિંગ પ્રમાણે નીચેની લાઈન સેટ કરી
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: isWeb ? 20 : 24),

          // સભ્યોને ગોઠવવાનું ગ્રીડ/રેપ લોજિક
          Wrap(
            spacing: 24.0,
            runSpacing: 24.0,
            alignment: WrapAlignment.center,
            children: members.map((member) => _buildMemberCard(member, isWeb)).toList(),
          ),
        ],
      ),
    );
  }



  // --- હેલ્પર વિજેટ: સિંગલ ટીમ મેમ્બર કાર્ડ ---
  Widget _buildMemberCard(dynamic member, bool isWeb) {
    final double cardWidth = isWeb ? 240 : double.infinity; // ✅ વેબ કાર્ડની વિડ્થ 270 થી 240 કરી જેથી પ્રોપર ફિટ થાય

    return Container(
      width: cardWidth,
      padding: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: isWeb ? 22.0 : 26.0 // ✅ કાર્ડની અંદરનું પેડિંગ પણ કોમ્પેક્ટ કર્યું ભાઈ
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBorder.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: isWeb ? 110 : 120, // ✅ ઇમેજ સાઈઝ વેબ માટે થોડી નાની કરી
            height: isWeb ? 110 : 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: member.imageUrl != null
                  ? Image.asset(member.imageUrl!, fit: BoxFit.cover)
                  : Container(
                color: AppColors.primary.withOpacity(0.1),
                alignment: Alignment.center,
                child: Text(
                  member.name.replaceAll('શ્રી ', '').replaceAll('શ્રીમતી ', '')[0],
                  style:  TextStyle(
                        fontSize: isWeb ? 28 : 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary
                    ),
                  ),
                ),
              ),
            ),

          SizedBox(height: isWeb ? 14 : 18),

          Text(
            member.role,
            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: AppColors.body.withOpacity(0.65)),
            ),

          const SizedBox(height: 6),

          Text(
            member.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                  fontSize: isWeb ? 15 : 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.heading,
                  height: 1.25
              ),
            ),

          SizedBox(height: isWeb ? 10 : 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_android_rounded, size: 12, color: AppColors.accent.withOpacity(0.8)),
              const SizedBox(width: 4),
              Text(
                member.phone,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.body.withOpacity(0.8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}