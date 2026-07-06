import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../screen/home_screen.dart';
import '../screen/team_screen.dart';
import '../screen/contact_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../screen/home_screen.dart';
import '../screen/team_screen.dart';
import '../screen/contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../screen/home_screen.dart';
import '../screen/team_screen.dart';
import '../screen/contact_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../screen/home_screen.dart';
import '../screen/team_screen.dart';
import '../screen/contact_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (currentRoute != HomeScreen.pageId) {
              Get.offAllNamed(HomeScreen.pageId);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'જામનગર રાજ્યગોર જ્ઞાતિ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMaroon,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 2),
              // ➔ ⚡ જાદુઈ ફિક્સ: રજીસ્ટ્રેશન લાઈન હવે શુદ્ધ ગુજરાતીમાં ટકાટક ગોઠવી દીધી ભાઈ!
              Text(
                'ટ્રસ્ટ રજીસ્ટ્રેશન નંબર: એ-૧૭૦ જામનગર',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMaroon.withOpacity(0.7),
                  fontSize: 12, // સહેજ સાઈઝ વધારી જેથી ગુજરાતી અક્ષરો ક્લીન વંચાય ભાઈ
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (!isMobile) ...[
          _buildNavButton('હોમ', HomeScreen.pageId, currentRoute == HomeScreen.pageId),
          _buildNavButton('અમારી ટીમ', TeamScreen.pageId, currentRoute == TeamScreen.pageId),
          _buildNavButton('અમારો ઉદ્દેશ', '/MissionScreen', currentRoute == '/MissionScreen'),
          _buildNavButton('મેમ્બરશીપ', '/MembershipScreen', currentRoute == '/MembershipScreen'),
          _buildNavButton('વિવિધ સંસ્થાઓ', '/SansthaScreen', currentRoute == '/SansthaScreen'),
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
        style: TextStyle(
          color: isActive ? AppColors.textOrange : AppColors.textMaroon,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

// ==========================================
// 🔹 ✅ REUSABLE MOBILE SIDEBAR DRAWER MODULE
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
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Get.back(); // ડ્રોઅર બંધ થશે ભાઈ
                              if (currentRoute != HomeScreen.pageId) {
                                Get.offAllNamed(HomeScreen.pageId);
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'જામનગર રાજ્યગોર જ્ઞાતિ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textMaroon,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                // ➔ ⚡ મોબાઈલ ડ્રોઅર હેડરમાં પણ રજીસ્ટ્રેશન લાઈન ગુજરાતીમાં લોક કરી ભાઈ
                                Text(
                                  'રજી. નં: એ-૧૭૦ જામનગર',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textMaroon.withOpacity(0.6),
                                    fontSize: 10.5,
                                  ),
                                ),
                              ],
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
                _buildDrawerItem('મેમ્બરશીપ', Icons.card_membership_outlined, '/MembershipScreen', currentRoute == '/MembershipScreen'),
                _buildDrawerItem('અમારી ટીમ', Icons.groups_outlined, TeamScreen.pageId, currentRoute == TeamScreen.pageId),
                _buildDrawerItem('અમારો ઉદ્દેશ', Icons.assignment_outlined, '/MissionScreen', currentRoute == '/MissionScreen'),
                _buildDrawerItem('વિવિધ સંસ્થાઓ', Icons.account_balance_outlined, '/SansthaScreen', currentRoute == '/SansthaScreen'),
                _buildDrawerItem('સંપર્ક', Icons.quick_contacts_mail_outlined, ContactScreen.pageId, currentRoute == ContactScreen.pageId),
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
        style: TextStyle(
          color: isActive ? AppColors.textOrange : AppColors.textMaroon,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          fontSize: 14.5,
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