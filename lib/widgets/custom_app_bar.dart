import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../screen/home_screen.dart';
import '../screen/team_screen.dart';
import '../screen/contact_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70.0);

  @override
  Widget build(BuildContext context) {
    // 900 પિક્સલથી નાની સ્ક્રીન એટલે મોબાઈલ વ્યુ
    final isMobile = MediaQuery.of(context).size.width <= 900;
    final currentRoute = Get.currentRoute;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      centerTitle: false,

      // ➔ ✅ માત્ર મોબાઈલ વ્યુ હોય તો જ હેમબર્ગર આઈકોન દેખાશે, વેબમાં સાવ ગાયબ!
      leading: isMobile
          ? Builder(
        builder: (innerContext) => IconButton(
          icon: const Icon(Icons.menu_rounded, color: AppColors.textMaroon, size: 28),
          onPressed: () {
            Scaffold.of(innerContext).openDrawer();
          },
        ),
      )
          : null,

      title: Text(
        'RAJYAPUROHITONLINE.IN',
        style: GoogleFonts.cinzel(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textMaroon,
            fontSize: 18,
          ),
        ),
      ),

      actions: [
        if (!isMobile) ...[
          _buildNavButton('હોમ', HomeScreen.pageId, currentRoute == HomeScreen.pageId),
          _buildNavButton('અમારા વિષે', '/AboutScreen', currentRoute == '/AboutScreen'),
          _buildNavButton('મેમ્બરશીપ', '/MembershipScreen', currentRoute == '/MembershipScreen'),
          _buildNavButton('અમારી ટીમ', TeamScreen.pageId, currentRoute == TeamScreen.pageId),
          _buildNavButton('અમારો ઉદ્દેશ', '/MissionScreen', currentRoute == '/MissionScreen'),
          _buildNavButton('સંપર્ક', ContactScreen.pageId, currentRoute == ContactScreen.pageId),
          const SizedBox(width: 20),
        ]
      ],
    );
  }

  Widget _buildNavButton(String title, String routeId, bool isActive) {
    return TextButton(
      onPressed: () {
        if (!isActive) Get.toNamed(routeId);
      },
      child: Text(
        title,
        style: GoogleFonts.notoSansGujarati(
          textStyle: TextStyle(
            color: isActive ? AppColors.textOrange : AppColors.textMaroon,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 🔹 ✅ REUSABLE MOBILE SIDEBAR DRAWER MODULE (ઓવરફ્લો ફ્રી)
// ==========================================
class CustomMobileDrawer extends StatelessWidget {
  const CustomMobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;

    return Drawer(
      backgroundColor: const Color(0xFFFDF8F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔝 ૧. ઓવરફ્લો મુક્ત હેડર
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 25.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'RAJYAPUROHITONLINE.IN',
                            style: GoogleFonts.cinzel(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textMaroon,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.textMaroon, size: 24),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),

          Divider(color: AppColors.textMaroon.withOpacity(0.08), height: 1, thickness: 1),

          // ૨. લિસ્ટ આઈટમ્સ
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              children: [
                _buildDrawerItem('હોમ', Icons.home_mini_outlined, HomeScreen.pageId, currentRoute == HomeScreen.pageId),
                _buildDrawerItem('અમારા વિષે', Icons.info_outline_rounded, '/AboutScreen', currentRoute == '/AboutScreen'),
                _buildDrawerItem('મેમ્બરશીપ', Icons.card_membership_outlined, '/MembershipScreen', currentRoute == '/MembershipScreen'),
                _buildDrawerItem('અમારી ટીમ', Icons.groups_outlined, TeamScreen.pageId, currentRoute == TeamScreen.pageId),
                _buildDrawerItem('અમારો ઉદ્દેશ', Icons.assignment_outlined, '/MissionScreen', currentRoute == '/MissionScreen'),
                _buildDrawerItem('સંપર્ક', Icons.quick_contacts_mail_outlined, ContactScreen.pageId, currentRoute == ContactScreen.pageId),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'નમસ્તે!',
                  style: GoogleFonts.notoSansGujarati(
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMaroon),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'ગુજરાત રાજ્યપુરોહيت સમાજનું ડિજિટલ પ્લેટફોર્મ.',
                  style: GoogleFonts.notoSansGujarati(
                    textStyle: const TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, String routeId, bool isActive) {
    return ListTile(
      horizontalTitleGap: 12,
      leading: Icon(icon, color: isActive ? AppColors.textOrange : AppColors.textMaroon, size: 20),
      title: Text(
        title,
        style: GoogleFonts.notoSansGujarati(
          textStyle: TextStyle(
            color: isActive ? AppColors.textOrange : AppColors.textMaroon,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 14.5,
          ),
        ),
      ),
      selected: isActive,
      onTap: () {
        Get.back();
        if (!isActive) Get.toNamed(routeId);
      },
    );
  }
}