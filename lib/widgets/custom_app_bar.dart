import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../screen/home_screen.dart';
import '../screen/team_screen.dart';
import '../screen/contact_screen.dart';
import '../screen/event_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../screen/home_screen.dart';
import '../screen/team_screen.dart';
import '../screen/contact_screen.dart';
import '../screen/event_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  // ➔ ⚡ વેબ માટે હાઇટ ૧૫૦ થી ઘટાડીને એકદમ પ્રીમિયમ ૯૦ સેટ કરી દીધી ભાઈ!
  Size get preferredSize {
    final double width = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
    return Size.fromHeight(width <= 900 ? 70.0 : 90.0);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 900;
    final currentRoute = Get.currentRoute;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      automaticallyImplyLeading: false,
      toolbarHeight: isMobile ? 70.0 : 90.0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 12.0 : 24.0,
              vertical: isMobile ? 4.0 : 8.0
          ),
          child: isMobile
              ? _buildMobileLayout(context, currentRoute)
              : _buildWebLayout(currentRoute),
        ),
      ),
    );
  }

  // 📱 ૧. મોબાઈલ લેઆઉટ — હવે વેબ જેવો જ સિંગલ rajyagor_header.png ઈમેજ વાપરે છે.
  // પહેલા અલગ logo_icon.png + text + om_logo.png (૩ અલગ widgets) હતું, જે
  // load થવામાં વાર લેતું હતું અને web sાથે અસંગત દેખાતું હતું. હવે web ની
  // જેમ એક જ combined હેડર ઈમેજ વપરાય છે — ઝડપી ane consistent.
  Widget _buildMobileLayout(BuildContext context, String currentRoute) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Builder(
            builder: (innerContext) => IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.menu_rounded, color: AppColors.textMaroon, size: 28),
              onPressed: () => Scaffold.of(innerContext).openDrawer(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  if (currentRoute != HomeScreen.pageId) {
                    Get.offAllNamed(HomeScreen.pageId);
                  }
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/rajyagor_header.png',
                    height: 56,
                    fit: BoxFit.contain,
                    // 🔧 Loading feels slow mainly because this same image
                    // also renders large (height: 160) on the web layout.
                    // If it's a big/high-res PNG, consider adding a smaller
                    // pre-resized version (e.g. rajyagor_header_sm.png) just
                    // for mobile to cut load time further.
                    errorBuilder: (c, e, s) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 💻 ૨. વેબ લેઆઉટ (સ્લિમ હાઇટ ૯૦ અને ઈમેજ કમ્પ્લીટ સ્વેપ લોક ભાઈ!)
  // 💻 ૨. વેબ લેઆઉટ (ડાબે-જમણે બંને લોગો ૧૦૦% એક જ સીધી લીટીમાં સમાંતર લોક ભાઈ!)
  Widget _buildWebLayout(String currentRoute) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ડાબી બાજુનો આખો બ્રાન્ડ બ્લોક (લોગો + ટેક્સ્ટ + લોગો)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                if (currentRoute != HomeScreen.pageId) {
                  Get.offAllNamed(HomeScreen.pageId);
                }
              },
              // ➔ ⚡ ⚡ મુખ્ય જાદુ: crossAxisAlignment.center એટલે ત્રણેય વસ્તુ ઊંચાઈમાં એકદમ સેન્ટર રહેશે ભાઈ
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Image.asset(
                        'assets/images/rajyagor_header.png',
                        height: 160,
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // જમણી બાજુના નેવિગેશન બટન્સ
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavButton('હોમ', HomeScreen.pageId, currentRoute == HomeScreen.pageId),
              _buildNavButton('અમારી ટીમ', TeamScreen.pageId, currentRoute == TeamScreen.pageId),
              _buildNavButton('અમારો ઉદ્દેશ', '/MissionScreen', currentRoute == '/MissionScreen'),
              _buildNavButton('મેમ્બરશીપ', '/MembershipScreen', currentRoute == '/MembershipScreen'),
              _buildNavButton('પ્રવૃત્તિઓ', EventScreen.pageId, currentRoute == EventScreen.pageId),
              _buildNavButton('વિવિધ સંસ્થાઓ', '/SansthaScreen', currentRoute == '/SansthaScreen'),
              _buildNavButton('સંપર્ક', ContactScreen.pageId, currentRoute == ContactScreen.pageId),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, String routeId, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: () {
          if (!isActive) Get.toNamed(routeId);
        },
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? AppColors.textOrange : AppColors.textMaroon,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            fontSize: 14.5,
          ),
        ),
      ),
    );
  }
}

// ============================================================
// 👥 REUSABLE MOBILE SIDEBAR DRAWER MODULE (અહીંયા પણ સ્વેપ મેચ ભાઈ)
// ============================================================
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
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 4.0, top: 25.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                        if (currentRoute != HomeScreen.pageId) {
                          Get.offAllNamed(HomeScreen.pageId);
                        }
                      },
                      child: Image.asset(
                        'assets/images/rajyagor_header.png',
                        height: 40,
                        fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                        errorBuilder: (c, e, s) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.textMaroon, size: 22),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.textMaroon.withOpacity(0.08), height: 1, thickness: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              children: [
                _buildDrawerItem('હોમ', Icons.home_mini_outlined, HomeScreen.pageId, currentRoute == HomeScreen.pageId),
                _buildDrawerItem('અમારી ટીમ', Icons.groups_outlined, TeamScreen.pageId, currentRoute == TeamScreen.pageId),
                _buildDrawerItem('અમારો ઉદ્દેશ', Icons.assignment_outlined, '/MissionScreen', currentRoute == '/MissionScreen'),
                _buildDrawerItem('મેમ્બરશીપ', Icons.card_membership_outlined, '/MembershipScreen', currentRoute == '/MembershipScreen'),
                _buildDrawerItem('પ્રવૃત્તિઓ', Icons.event_available_outlined, EventScreen.pageId, currentRoute == EventScreen.pageId),
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