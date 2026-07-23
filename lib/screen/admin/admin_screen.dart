import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../controllers/admin_controller.dart';

class AdminScreen extends GetView<AdminController> {
  static const pageId = "/AdminScreen";

  const AdminScreen({super.key});

  // ===========================================================================
  // 🔧 FIX: robust boolean parser.
  // ===========================================================================
  bool _isTrue(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final s = value.toString().trim().toLowerCase();
    return s == '1' || s == 'true' || s == 'yes';
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AdminController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          "સભ્યોની યાદી (એડમિન)",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmerLoader();
        }

        if (controller.userList.isEmpty) {
          return _buildEmptyState();
        }

        // ➔ ⚡ કુલ પરિવારો અને વેરિફાઈડની ગણતરી
        final total = controller.userList.length;
        final verifiedCount = controller.userList.where((u) => _isTrue(u['is_verified'])).length;

        // ➔ ⚡ લિસ્ટમાં માત્ર વેરિફિકેશન બાકી હોય તેવા જ પરિવારો બતાવવા માટેનું ફિલ્ટર
        final pendingList = controller.userList.where((u) => !_isTrue(u['is_verified'])).toList();

        return RefreshIndicator(
          color: Colors.red.shade700,
          onRefresh: () => controller.fetchAllUsers(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              _buildStatsRow(total: total, verified: verifiedCount),
              const SizedBox(height: 20),
              if (pendingList.isEmpty)
                _buildEmptyState()
              else
                ...pendingList.map((user) => _buildUserCard(context, user)),
            ],
          ),
        );
      }),
    );
  }

  // ===========================================================================
  // 📊 STATS ROW
  // ===========================================================================
  Widget _buildStatsRow({required int total, required int verified}) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            label: "કુલ પરિવારો",
            value: "$total",
            icon: Icons.groups_outlined,
            color: Colors.blue.shade600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            label: "વેરિફાઈડ",
            value: "$verified",
            icon: Icons.verified_outlined,
            color: Colors.green.shade600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            label: "બાકી",
            value: "${total - verified}",
            icon: Icons.pending_outlined,
            color: Colors.orange.shade600,
          ),
        ),
      ],
    );
  }

  Widget _statCard({required String label, required String value, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87)),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ===========================================================================
  // 🧑 USER CARD
  // ===========================================================================
  Widget _buildUserCard(BuildContext context, Map<String, dynamic> user) {
    final isVerified = _isTrue(user['is_verified']);
    final isAdmin = user['role'] == 'admin';
    final name = "${user['first_name'] ?? ''} ${user['surname'] ?? ''}".trim();
    final initial = (user['first_name'] != null && user['first_name'].toString().isNotEmpty)
        ? user['first_name'].toString()[0].toUpperCase()
        : '?';
    final avatarColor = isAdmin ? Colors.orange : Colors.red;

    // પરિવારના સભ્યોની સંખ્યા કાઉન્ટ કરો
    final familyList = user['family_members'] as List? ?? [];
    final familyCount = familyList.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showUserDetailsDialog(context, user),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: avatarColor.shade50,
                      child: Text(
                        initial,
                        style: TextStyle(fontWeight: FontWeight.w700, color: avatarColor.shade700, fontSize: 16),
                      ),
                    ),
                    if (isVerified)
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: Icon(Icons.verified, size: 15, color: Colors.green.shade600),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isEmpty ? "નામ ઉપલબ્ધ નથી" : name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.phone_outlined, size: 13, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            user['phone_number'] ?? 'N/A',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                          ),
                          const SizedBox(width: 12),
                          Icon(Icons.family_restroom, size: 13, color: Colors.blue.shade600),
                          const SizedBox(width: 4),
                          Text(
                            "સભ્યો: $familyCount",
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: isAdmin ? Colors.orange.shade50 : Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: isAdmin ? Colors.orange.shade200 : Colors.blue.shade200),
                  ),
                  child: Text(
                    isAdmin ? "એડમિન" : "યુઝર",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isAdmin ? Colors.orange.shade800 : Colors.blue.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Switch(
                  value: isVerified,
                  activeColor: Colors.green.shade600,
                  onChanged: (bool value) {
                    int newStatus = value ? 1 : 0;
                    controller.verifyUser(user['id'].toString(), newStatus);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 🪟 USER DETAILS DIALOG
  // ===========================================================================
  void _showUserDetailsDialog(BuildContext context, Map<String, dynamic> user) {
    final isVerified = _isTrue(user['is_verified']);
    final name = "${user['first_name'] ?? ''} ${user['surname'] ?? ''}".trim();
    final initial = (user['first_name'] != null && user['first_name'].toString().isNotEmpty)
        ? user['first_name'].toString()[0].toUpperCase()
        : '?';
    final familyList = user['family_members'] as List? ?? [];

    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 650),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.red.shade50,
                          child: Text(
                            initial,
                            style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red.shade700, fontSize: 18),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.isEmpty ? "નામ ઉપલબ્ધ નથી" : name,
                                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),
                              ),
                              const SizedBox(height: 3),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isVerified ? Colors.green.shade50 : Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  isVerified ? "વેરિફાઈડ" : "વેરિફિકેશન બાકી",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: isVerified ? Colors.green.shade700 : Colors.orange.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.pop(dialogContext),
                          splashRadius: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F7FB),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailRow(Icons.phone_outlined, "મોબાઈલ", user['phone_number'] ?? 'N/A'),
                          _detailRow(Icons.email_outlined, "ઈમેલ", user['email'] ?? 'N/A'),
                          _detailRow(Icons.cake_outlined, "જન્મ તારીખ", user['birth_date'] ?? 'N/A'),
                          _detailRow(Icons.account_tree_outlined, "ગોત્ર", user['gotra'] ?? 'N/A'),
                          _detailRow(Icons.work_outline, "વ્યવસાય", user['occupation'] ?? 'N/A'),
                          _detailRow(Icons.location_on_outlined, "સરનામું", user['current_address'] ?? 'N/A', isLast: true),
                        ],
                      ),
                    ),

                    // ➔ ⚡ પરિવારના સભ્યોની યાદી ડાયલોગમાં બતાવવા માટે
                    if (familyList.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        "પરિવારના સભ્યોની વિગતો:",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 10),
                      ...familyList.map((member) => Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
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
                                  member['name'] ?? 'નામ નથી',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "સંબંધ: ${member['relation'] ?? '-'}",
                                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                            Text(
                              member['birth_date'] ?? '',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      )),
                    ],

                    const SizedBox(height: 20),
                    if (!isVerified)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                          label: const Text(
                            "સભ્યને વેરિફાય કરો",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                          onPressed: () {
                            controller.verifyUser(user['id'].toString(), 1);
                            Navigator.pop(dialogContext);
                          },
                        ),
                      )
                    else
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("બંધ કરો", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(IconData icon, String label, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 17, color: Colors.grey.shade500),
          const SizedBox(width: 10),
          SizedBox(
            width: 90,
            child: Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 💤 EMPTY & LOADING STATES
  // ===========================================================================
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.groups_outlined, size: 90, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            "કોઈ સભ્યો મળ્યા નથી",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLoader() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 76,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}