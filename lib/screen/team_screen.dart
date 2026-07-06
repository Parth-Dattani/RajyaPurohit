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
import '../controllers/team_controller.dart';

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
// 🔹 ૧. TEAM HEADER BANNER (ઊભી અને આડી લાઈનમાં પિક્સલ-પરફેક્ટ સેન્ટર ભાઈ)
// ==========================================
  Widget _buildTeamHeaderBanner(bool isWeb) {
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
      // ⚡ સેન્ટર લોજિક: ગુજરાતી ફોન્ટના કારણે જે નીચે નમતું હતું, એને લાઈન હાઈટથી પ્રોપર વચોવચ ખેંચી લીધું ભાઈ
      child: Padding(
        padding: const EdgeInsets.only(top: 4), // જો હજુ સહેજ નીચે લાગતું હોય તો આ બોટમ પેડિંગ ૨ થી ૪ પિક્સલ કરી લેવી ભાઈ
        child: Text(
          'અમારી ટીમ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isWeb ? 34 : 26, // હાઈટ નાની હોવાથી ફોન્ટ સાઈઝ સહેજ બેલેન્સ કરી ભાઈ જેથી વધુ ભીંસ ન લાગે
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
            height: 1.0, // ➔ ⚡ મેઈન ફિક્સ: લાઈન હાઈટ ફિક્સ કરવાથી ઊભી લાઈનમાં ટકાટક સેન્ટર થઈ જશે!
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૨. TEAM FILTER SECTION + RADIO BUTTONS (રિસ્પોન્સિવ Wrap લોજિક)
  // ==========================================
  Widget _buildTeamFilterSection(bool isWeb, double screenWidth) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 16.0,
        vertical: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔘 રેડિયો બટન્સ સેક્શન
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: 'હાલની કમિટી',
                groupValue: controller.activeTeamTab.value,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  controller.activeTeamTab.value = value!;
                },
              ),
              GestureDetector(
                onTap: () => controller.activeTeamTab.value = 'હાલની કમિટી',
                child: const Text('હાલની કમિટી', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.heading)),
              ),
              const SizedBox(width: 30),
              Radio<String>(
                value: 'પૂર્વ પ્રમુખશ્રીઓ',
                groupValue: controller.activeTeamTab.value,
                activeColor: AppColors.primary,
                onChanged: (value) {
                  controller.activeTeamTab.value = value!;
                },
              ),
              GestureDetector(
                onTap: () => controller.activeTeamTab.value = 'પૂર્વ પ્રમુખશ્રીઓ',
                child: const Text('પૂર્વ પ્રમુખશ્રીઓની યાદી', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.heading)),
              ),
            ],
          )),

          const SizedBox(height: 20),

          // 👑 ડાયનેમિક કન્ટેન્ટ વ્યુ કન્ડિશન
          Obx(() {
            if (controller.activeTeamTab.value == 'હાલની કમિટી') {
              return Column(
                children: [
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 10.0,
                    alignment: WrapAlignment.center,
                    children: controller.categories.map((cat) {
                      return Obx(() {
                        final isSelected = controller.selectedCategory.value == cat;
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => controller.changeCategory(cat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : AppColors.heading.withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                cat,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isSelected ? Colors.white : AppColors.heading,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  const SizedBox(height: 25),
                  _buildCategorizedTeamList(isWeb),
                ],
              );
            } else {
              return _buildPastPresidentsSection(isWeb, screenWidth);
            }
          }),
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૩. CATEGORIZED TEAM LIST (5-GRID) - ઓલ ફિલ્ટર ફિક્સ વર્ઝન ભાઈ
  // ==========================================
  Widget _buildCategorizedTeamList(bool isWeb) {
    return Obx(() {
      final currentFilter = controller.selectedCategory.value;

      if (currentFilter == 'બધા') {
        final activeCategories = controller.categories.where((cat) => cat != 'બધા').toList();

        if (isWeb) {
          final pramukhCategory = activeCategories.firstWhereOrNull((cat) => cat == 'પ્રમુખ');
          final otherCategories = activeCategories.where((cat) => cat != 'પ્રમુખ').toList();

          final singleMemberCategories = <String>[];
          final multiMemberCategories = <String>[];

          // ➔ ⚡ લાઈવ ચેક: કઈ કેટેગરીમાં કેટલા મેમ્બર્સ છે એ ગણવા માટેનું સ્માર્ટ લોજિક ભાઈ
          for (var cat in otherCategories) {
            int count = 0;
            if (cat == 'વિવિધ સમિતિના ચેરમેન') {
              final List<String> samitiRoles = ['શિક્ષણ', 'વ્યવસ્થાપક', 'સાંસ્કૃતિક', 'મેડિકલ', 'ફંડ એકત્રિત', 'મંદિર'];
              count = controller.teamMembers.where((m) => samitiRoles.contains(m.role)).length;
            } else {
              count = controller.teamMembers.where((m) => m.role == cat).length;
            }

            if (count == 1) {
              singleMemberCategories.add(cat);
            } else if (count > 1) {
              multiMemberCategories.add(cat);
            }
          }

          return Column(
            children: [
              if (pramukhCategory != null) ...[
                (() {
                  final members = controller.teamMembers.where((m) => m.role == pramukhCategory).toList();
                  if (members.isEmpty) return const SizedBox.shrink();
                  return _buildCategoryGroup(pramukhCategory, members, isWeb);
                }()),
              ],
              if (singleMemberCategories.isNotEmpty)
                Wrap(
                  spacing: 16.0,
                  runSpacing: 20.0,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: singleMemberCategories.map((category) {
                    List<dynamic> members;
                    if (category == 'વિવિધ સમિતિના ચેરમેન') {
                      final List<String> samitiRoles = ['શિક્ષણ', 'વ્યવस्थाપક', 'સાંસ્કૃતિક', 'મેડિકલ', 'ફંડ એકત્રિત', 'મંદિર'];
                      members = controller.teamMembers.where((m) => samitiRoles.contains(m.role)).toList();
                    } else {
                      members = controller.teamMembers.where((m) => m.role == category).toList();
                    }
                    return _buildCategoryGroup(category, members, isWeb, isFlexMode: true);
                  }).toList(),
                ),
              if (multiMemberCategories.isNotEmpty)
                ...multiMemberCategories.map((category) {
                  List<dynamic> members;
                  // ⚡ ફિક્સ: "બધા" સ્ક્રીન પર વિવિધ સમિતિના ચેરમેનનો આખો ડેટા લોડ કરાવવા માટે ભાઈ
                  if (category == 'વિવિધ સમિતિના ચેરમેન') {
                    final List<String> samitiRoles = ['શિક્ષણ', 'વ્યવસ્થાપક', 'સાંસ્કૃતિક', 'મેડિકલ', 'ફંડ એકત્રિત', 'મંદિર'];
                    members = controller.teamMembers.where((m) => samitiRoles.contains(m.role)).toList();
                  } else {
                    members = controller.teamMembers.where((m) => m.role == category).toList();
                  }
                  return _buildCategoryGroup(category, members, isWeb, isFlexMode: false);
                }).toList(),
            ],
          );
        } else {
          // મોબાઈલ વ્યુ માટેનું લોજિક ભાઈ
          return Column(
            children: activeCategories.map((category) {
              List<dynamic> categoryMembers;
              if (category == 'વિવિધ સમિતિના ચેરમેન') {
                final List<String> samitiRoles = ['શિક્ષણ', 'વ્યવસ્થાપક', 'સાંસ્કૃતિક', 'મેડિકલ', 'ફંડ એકત્રિત', 'મંદિર'];
                categoryMembers = controller.teamMembers.where((m) => samitiRoles.contains(m.role)).toList();
              } else {
                categoryMembers = controller.teamMembers.where((m) => m.role == category).toList();
              }
              if (categoryMembers.isEmpty) return const SizedBox.shrink();
              return _buildCategoryGroup(category, categoryMembers, isWeb);
            }).toList(),
          );
        }
      } else {
        final selectedMembers = controller.filteredMembers;
        final bool isSingleFilter = selectedMembers.length == 1;
        return _buildCategoryGroup(currentFilter, selectedMembers, isWeb, isFlexMode: isSingleFilter);
      }
    });
  }

  Widget _buildCategoryGroup(String title, List<dynamic> members, bool isWeb, {bool isFlexMode = false}) {
    final double? blockWidth = (isWeb && isFlexMode) ? 215.0 : null;

    // ➔ ⚡ ચેન્જ: જો હેડિંગ 'સમિતિ ચેરમેન' આવે તો લાઈવ કન્ડિશનથી બદલીને "વિવિધ સમિતિના ચેરમેન" કરવું ભાઈ
    String displayTitle = title;
    if (displayTitle == 'સમિતિ ચેરમેન') {
      displayTitle = 'વિવિધ સમિતિના ચેરમેન';
    }

    return Container(
      width: blockWidth,
      padding: EdgeInsets.symmetric(
        vertical: isWeb ? 12.0 : 20.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            displayTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: (isWeb && !isFlexMode && displayTitle != 'પ્રમુખ') ? 22 : 17,
                fontWeight: FontWeight.w900,
                color: AppColors.heading
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: (isWeb && !isFlexMode && displayTitle != 'પ્રમુખ') ? 45 : 25,
            height: 2.5,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: isWeb ? 14 : 20),
          Wrap(
            spacing: 16.0,
            runSpacing: 20.0,
            alignment: WrapAlignment.center,
            children: members.map((member) => _buildMemberCard(member, isWeb)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(dynamic member, bool isWeb) {
    final double cardWidth = isWeb ? 210 : double.infinity;
    final currentFilter = controller.selectedCategory.value;

    // ➔ ૧. વિવિધ સમિતિના ચેરમેન માટેનું લોજિક ભાઈ
    final List<String> samitiRoles = ['શિક્ષણ', 'વ્યવસ્થાપક', 'સાંસ્કૃતિક', 'મેડિકલ', 'ફંડ એકત્રિત', 'મંદિર'];
    final bool isSamitiChairman = samitiRoles.contains(member.role);

    // ➔ ૨. કારોબારી સભ્ય માટેનું લોજિક ભાઈ
    final bool isKarobari = member.role == 'કારોબારી સભ્ય';

    // ⚡ ➔ જાદુઈ ફિક્સ: કારોબારી સભ્યનો રોલ ગમે તે કન્ડિશન હોય (બધા કે સિંગલ ચિપ) હંમેશા હાઇડ જ રહેશે ભાઈ!
    bool shouldShowRole = isSamitiChairman;

    // પિક્સલ-પરફેક્ટ ટેક્સ્ટ મોડિફિકેશન
    String displaySubRole = member.role;
    if (isSamitiChairman) {
      displaySubRole = "${member.role} સમિતિ"; // -> ઉદાહરણ તરીકે: "શિક્ષણ સમિતિ", "મંદિર સમિતિ" ભાઈ
    }

    return Container(
      width: cardWidth,
      padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: isWeb ? 14.0 : 24.0
      ),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: isWeb ? 100 : 110,
            height: isWeb ? 100 : 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(55),
              child: (member.imageUrl != null && member.imageUrl!.isNotEmpty)
                  ? Image.network(
                member.imageUrl!,
                fit: BoxFit.cover,
                cacheWidth: 300,
                cacheHeight: 300,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                      color: AppColors.primary,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallbackLetterAvatar(member.name, isWeb);
                },
              )
                  : _buildFallbackLetterAvatar(member.name, isWeb),
            ),
          ),

          // ➔ 👑 શોર્ટ એન્ડ ક્લીન સબ-રોલ સેક્શન ભાઈ
          if (shouldShowRole) ...[
            SizedBox(height: isWeb ? 12 : 16),
            Text(
              displaySubRole,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: AppColors.accentDark,
              ),
            ),
          ],

          if (!shouldShowRole) SizedBox(height: isWeb ? 12 : 16),

          Text(
            member.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: isWeb ? 14.5 : 15.5,
                fontWeight: FontWeight.w900,
                color: AppColors.heading,
                height: 1.25
            ),
          ),
          SizedBox(height: isWeb ? 8 : 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone_android_rounded, size: 12, color: AppColors.accent.withOpacity(0.8)),
              const SizedBox(width: 4),
              Text(
                member.phone,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.body.withOpacity(0.8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackLetterAvatar(String name, bool isWeb) {
    final cleanName = name.replaceAll('શ્રી ', '').replaceAll('શ્રીમતી ', '');
    final firstLetter = cleanName.isNotEmpty ? cleanName[0] : '?';

    return Container(
      color: AppColors.primary.withOpacity(0.1),
      alignment: Alignment.center,
      child: Text(
        firstLetter,
        style: TextStyle(
          fontSize: isWeb ? 26 : 30,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

// ==========================================
  // 🔹 ૪. પૂર્વ પ્રમુખશ્રીઓની ગૌરવશાળી યાદી સેક્શન (કોમ્પેક્ટ સાઈઝ ફિક્સ ભાઈ)
  // ==========================================
  Widget _buildPastPresidentsSection(bool isWeb, double screenWidth) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'પૂર્વ પ્રમુખશ્રીઓની યાદી',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.heading),
          ),
          const SizedBox(height: 4),
          Container(
            width: 50,
            height: 3,
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 30),

          controller.pastPresidents != null && controller.pastPresidents!.isNotEmpty
              ? (isWeb
              ? Center(
            child: SizedBox(
              width: 900, // ⚡ ➔ જાદુઈ ફિક્સ: ટેબલને વધુ પડતું ફેલાતું અટકાવવા વિડ્થ સંકોચી દીધી ભાઈ!
              child: _buildPastPresidentsTable(),
            ),
          )
              : _buildPastPresidentsListMobile())
              : const Center(child: Text("માહિતી ઉપલબ્ધ નથી ભાઈ.")),
        ],
      ),
    );
  }

  Widget _buildPastPresidentsTable() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(4),
          3: FlexColumnWidth(3),
          4: FlexColumnWidth(1.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            children: ['ક્રમ', 'ફોટો', 'પૂર્વ પ્રમુખશ્રીનું નામ', 'કાર્યકાળ', 'વર્ષ'].map((text) {
              return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
              );
            }).toList(),
          ),
          ...controller.pastPresidents!.map((p) {
            return TableRow(
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.cardBorder))),
              children: [
                Padding(padding: const EdgeInsets.all(12.0), child: Text('${p.srNo}', style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),

                // ➔ ⚡ વ્હાઇટ ભાગ અને કટિંગ બંને સમસ્યાનું કાયમી સોલ્યુશન ભાઈ (વેબ વ્યુ)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 58, // પાસપોર્ટ સાઇઝ રેશિયો મુજબ વિડ્થ સેટ કરી ભાઈ
                      height: 70, // હાઇટ થોડી વધારે રાખી જેથી ઊભો ફોટો પરફેક્ટ ગોઠવાય
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(6), // ખૂણા સેહેજ ગોળ કર્યા
                        border: Border.all(color: AppColors.cardBorder.withOpacity(0.8), width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: (p.imageUrl != null && p.imageUrl!.isNotEmpty)
                            ? Image.network(
                          p.imageUrl!,
                          fit: BoxFit.cover, // ⚡ હવે ફોટો આખા લંબચોરસ કાર્ડને ટકાટક કવર કરશે, વ્હાઇટ ભાગ ગાયબ!
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Text(p.name.replaceAll('પટેલ ', '')[0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ),
                        )
                            : Center(
                          child: Text(p.name.replaceAll('પટેલ ', '')[0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(padding: const EdgeInsets.all(12.0), child: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.heading))),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    p.duration,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13.5, color: AppColors.heading),
                    ),
                  ),
                ),
                Padding(padding: const EdgeInsets.all(12.0), child: Text(p.years, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.accentDark))),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPastPresidentsListMobile() {
    return Column(
      children: controller.pastPresidents!.map((p) {
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: const BorderSide(color: AppColors.cardBorder, width: 0.8)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // ➔ ⚡ વ્હાઇટ ભાગ અને કટિંગ બંને સમસ્યાનું કાયમી સોલ્યુશન ભાઈ (મોબાઈલ વ્યુ)
                Container(
                  width: 44,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.cardBorder.withOpacity(0.8), width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: (p.imageUrl != null && p.imageUrl!.isNotEmpty)
                        ? Image.network(
                      p.imageUrl!,
                      fit: BoxFit.cover, // ⚡ મોબાઈલમાં પણ લંબચોરસ કાર્ડ લુક મસ્ત લાગશે ભાઈ
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Text(p.name.replaceAll('પટેલ ', '')[0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
                      ),
                    )
                        : Center(
                      child: Text(p.name.replaceAll('પટેલ ', '')[0], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.name, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold, color: AppColors.heading)),
                      const SizedBox(height: 4),
                      Text('કાર્યકાળ: ${p.duration}', style: TextStyle(fontSize: 12, color: AppColors.body.withOpacity(0.8), fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                  child: Text(p.years, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.accentDark)),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
