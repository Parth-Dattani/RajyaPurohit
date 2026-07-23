import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajya_purohit/screen/screen.dart';
import '../controllers/dashboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_colors.dart';
import '../../controllers/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 950;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isWeb ? 60 : 16,
          vertical: 24,
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Obx(() => _buildBody(isWeb)),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // APP BAR
  // ==========================================
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          // ➔ ડાબી બાજુ: લોગો અને ડેશબોર્ડ ટેક્સ્ટ
          Row(
            children: [
              const Icon(Icons.account_balance_rounded, color: Colors.amber, size: 28),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("સભ્ય ડેશબોર્ડ", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
                  Obx(() => Text(
                    "+91 ${controller.loggedInUserData['phone_number'] ?? ''}",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  )),
                ],
              ),
            ],
          ),

          // ➔ ⚡ આ Spacer વચ્ચેની બધી ખાલી જગ્યા લઈ લેશે, જેથી બાકીના બટનો જમણી બાજુ આવી જશે
          const Spacer(),

          // ➔ જમણી બાજુના બટનો (એડમિન + રિફ્રેશ + લોગઆઉટ)
          Obx(() => controller.isAdmin.value
              ? TextButton.icon(
            onPressed: () => Get.toNamed(AdminScreen.pageId),
            icon: const Icon(Icons.admin_panel_settings, color: Colors.blue, size: 18),
            label: const Text("એડમિન", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          )
              : const SizedBox.shrink()
          ),

          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF800020)),
            onPressed: () => controller.refreshFromServer(),
            tooltip: 'Refresh',
          ),

          TextButton.icon(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout, color: Colors.redAccent, size: 18),
            label: const Text("લોગઆઉટ", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // MAIN BODY
  // ==========================================
  Widget _buildBody(bool isWeb) {
    if (controller.loggedInUserData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final user = controller.loggedInUserData;
    final family = controller.loggedInFamilyMembers;

    // Welcome banner
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ➔ Welcome header (lohanaonline.in jevu)
        _buildWelcomeBanner(user),
        const SizedBox(height: 24),

        // ➔ Main 2-column layout
        isWeb
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: ID Card + Family
            SizedBox(
              width: 360,
              child: Column(
                children: [
                  _buildIdCard(user),
                  const SizedBox(height: 20),
                  _buildFamilySection(family),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Right: Details panels
            Expanded(
              child: Column(
                children: [
                  _buildPrimaryInfoPanel(user),
                  const SizedBox(height: 16),
                  _buildContactPanel(user),
                  const SizedBox(height: 16),
                  _buildPersonalInfoPanel(user),
                ],
              ),
            ),
          ],
        )
            : Column(
          children: [
            _buildIdCard(user),
            const SizedBox(height: 16),
            _buildFamilySection(family),
            const SizedBox(height: 16),
            _buildPrimaryInfoPanel(user),
            const SizedBox(height: 16),
            _buildContactPanel(user),
            const SizedBox(height: 16),
            _buildPersonalInfoPanel(user),
          ],
        ),
      ],
    );
  }

  // ==========================================
  // WELCOME BANNER
  // ==========================================
  Widget _buildWelcomeBanner(Map<String, dynamic> user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "સ્વાગત છે, ${user['first_name'] ?? ''}",
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF800020)),
              ),
              Text(
                "સભ્ય નંબર: ${user['id'] != null ? 'RBG-00${user['id']}' : '-'}",
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          // OutlinedButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF800020)),
          //   label: const Text("વિગતો સુધારો",
          //       style: TextStyle(color: Color(0xFF800020), fontSize: 13)),
          //   style: OutlinedButton.styleFrom(
          //     side: const BorderSide(color: Color(0xFF800020)),
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          //   ),
          // ),
        ],
      ),
    );
  }

  // ==========================================
  // ID CARD (Left top)
  // ==========================================
  Widget _buildIdCard(Map<String, dynamic> user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade100, width: 1.5),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.badge_outlined, color: Colors.orange),
              SizedBox(width: 8),
              Text("ઓળખ પત્ર (ID Card)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20),

          // Avatar
          Container(
            width: 75, height: 75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child:
         (user['profile_photo'] != null && user['profile_photo'].toString().isNotEmpty)
        ? ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
        "https://rajyapurohitjamnagar.in/${user['profile_photo']}",
        fit: BoxFit.cover,
        errorBuilder: (c, o, s) => const Icon(Icons.person, size: 40, color: Colors.grey),
        ),
        )
            :
            const Icon(Icons.person, size: 40, color: Colors.grey),
          ),
          const SizedBox(height: 12),

          Text(
            "${user['first_name'] ?? ''} ${user['surname'] ?? ''}",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),
          ),
          const SizedBox(height: 4),

          // Membership badge
          // Membership badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF800020).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              // ➔ અહીં આપણે user['id'] નો ઉપયોગ કરીને સભ્ય નંબર બનાવીએ છીએ
              "RBG-00${user['id'] ?? ''}",
              style: const TextStyle(
                  color: Color(0xFF800020),
                  fontSize: 12,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(height: 16),

          /// tem Download button
          // ElevatedButton.icon(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: const Color(0xFFFF4500),
          //     minimumSize: const Size(double.infinity, 44),
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          //   ),
          //   onPressed: () => controller.generateMemberPdf(user, true),
          //   icon: const Icon(Icons.download, color: Colors.white, size: 18),
          //   label: const Text("કાર્ડ ડાઉનલોડ કરો",
          //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          // ),
        ],
      ),
    );
  }

  // ==========================================
  // FAMILY SECTION (Left bottom)
  // ==========================================
  Widget _buildFamilySection(List<Map<String, dynamic>> family) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text("👥", style: TextStyle(fontSize: 16)),
              SizedBox(width: 8),
              Text("પરિવારના ઓળખપત્રો",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),

          if (family.isEmpty)
            const Text("કોઈ પરિવારના સભ્ય ઉમેર્યા નથી.",
                style: TextStyle(color: Colors.grey)),

          ...family.map((member) => _buildFamilyMemberTile(member)),
        ],
      ),
    );
  }

  Widget _buildFamilyMemberTile(Map<String, dynamic> member) {
    final name = member['first_name'] ?? '-';
    final relation = member['relation'] ?? member['relation_with_head'] ?? '-';
    final dob = member['birth_date'] ?? '-';
    final phone = member['whatsapp_number'] ?? '-';
    final memberId = member['id'] != null ? 'RBG-00${member['id']}-A' : '-';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + relation
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16, color: Colors.orange),
              const SizedBox(width: 6),
              Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(relation,
                    style: TextStyle(color: Colors.green.shade700, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text("જન્મ તારીખ: $dob  |  મોબાઈલ: $phone",
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text("સભ્ય નંબર: RBG-00${member['id'] ?? ''}",
              style: const TextStyle(color: Color(0xFF800020), fontSize: 11)),
          const SizedBox(height: 8),

          /// Avatar + download
          // Row(
          //   children: [
          //
          //     Expanded(
          //       child: ElevatedButton.icon(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: const Color(0xFFFF4500),
          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          //           padding: const EdgeInsets.symmetric(vertical: 10),
          //         ),
          //         onPressed: () => controller.generateMemberPdf(member, false),
          //         icon: const Icon(Icons.download, color: Colors.white, size: 16),
          //         label: const Text("કાર્ડ ડાઉનલોડ કરો",
          //             style: TextStyle(color: Colors.white, fontSize: 12)),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  // ==========================================
  // RIGHT PANELS
  // ==========================================
  Widget _buildPrimaryInfoPanel(Map<String, dynamic> user) {
    return _buildInfoPanel(
      icon: Icons.person_outline,
      title: "પ્રાથમિક વિગતો",
      rows: [
        ["પૂરું નામ", "${user['first_name'] ?? '-'}"],
        ["પિતા/પતિ નામ", "${user['father_or_husband_name'] ?? '-'}"],
        ["માતાનું નામ", "${user['mother_name'] ?? '-'}"],
        ["જિલ્લો", "${user['current_district'] ?? '-'}"],
        ["લિંગ", "${user['gender'] ?? '-'}"],
        ["જન્મ તારીખ", "${user['birth_date'] ?? '-'}"],
        ["વૈવાહિક સ્થિતિ", "${user['marital_status'] ?? '-'}"],
        ["ઘરના સભ્યોની સંખ્યા", "${user['family_count'] ?? '-'}"],
      ],
    );
  }

  Widget _buildContactPanel(Map<String, dynamic> user) {
    return _buildInfoPanel(
      icon: Icons.location_on_outlined,
      title: "સંપર્ક વિગતો",
      rows: [
        ["સરનામું", "${user['current_address'] ?? '-'}"],
        ["જિલ્લો", "${user['current_district'] ?? '-'}"],
        ["તાલુકો", "${user['current_taluka'] ?? '-'}"],
        ["પીનકોડ", "${user['pincode'] ?? '-'}"],
        ["મોબાઈલ નંબર", "${user['phone_number'] ?? '-'}"],
        ["ઈમેલ", "${user['email'] ?? '-'}"],
      ],
    );
  }

  Widget _buildPersonalInfoPanel(Map<String, dynamic> user) {
    return _buildInfoPanel(
      icon: Icons.info_outline,
      title: "અંગત વિગતો",
      rows: [
        ["જન્મ તારીખ", "${user['birth_date'] ?? '-'}"],
        ["વૈવાહિક સ્થિતિ", "${user['marital_status'] ?? '-'}"],
        ["શિક્ષણ", "${user['education'] ?? '-'}"],
        ["વ્યવસાય", "${user['occupation'] ?? '-'}"],
        ["મૂળ ગામ", "${user['native_village'] ?? '-'}"],
        ["ગામ / શહેર", "${user['current_city'] ?? '-'}"],
        ["ઘરના સભ્યોની સંખ્યા", "-"],
      ],
    );
  }

  Widget _buildInfoPanel({
    required IconData icon,
    required String title,
    required List<List<String>> rows,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.redAccent, size: 20),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          const Divider(height: 20),
          // Grid: 2 per row on wide, 1 per row on narrow
          Wrap(
            spacing: 20,
            runSpacing: 12,
            children: rows
                .map((row) => SizedBox(
              width: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(row[0],
                      style: const TextStyle(
                          color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text(row[1],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 14)),
                ],
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
