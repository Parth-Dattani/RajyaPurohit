// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class SubscriptionExpiredDialog extends StatefulWidget {
//   @override
//   _SubscriptionExpiredDialogState createState() => _SubscriptionExpiredDialogState();
// }
//
// class _SubscriptionExpiredDialogState extends State<SubscriptionExpiredDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       duration: Duration(milliseconds: 600),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.elasticOut,
//     ));
//
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     ));
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Prevent back button from closing dialog
//         return false;
//       },
//       child: Dialog(
//         backgroundColor: Colors.transparent,
//         insetPadding: EdgeInsets.all(20),
//         child: ScaleTransition(
//           scale: _scaleAnimation,
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: _buildDialogContent(),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDialogContent() {
//     return Container(
//       padding: EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 20,
//             offset: Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Warning Icon
//           Container(
//             width: 80,
//             height: 80,
//             decoration: BoxDecoration(
//               color: Colors.red.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.warning_rounded,
//               size: 40,
//               color: Colors.red,
//             ),
//           ),
//
//           SizedBox(height: 20),
//
//           // Title
//           Text(
//             'Subscription Expired',
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.red,
//             ),
//             textAlign: TextAlign.center,
//           ),
//
//           SizedBox(height: 16),
//
//           // Message
//           Text(
//             'Your subscription has ended. Renew now to continue accessing all premium features and property analytics.',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey[700],
//               height: 1.5,
//             ),
//             textAlign: TextAlign.center,
//           ),
//
//           SizedBox(height: 24),
//
//           // Features that are locked
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               children: [
//                 _buildFeatureRow('Property Analytics', Icons.analytics_outlined),
//                 _buildFeatureRow('Cash Flow Projections', Icons.trending_up),
//                 _buildFeatureRow('Valuation Reports', Icons.assessment),
//                 _buildFeatureRow('Premium Support', Icons.support_agent),
//               ],
//             ),
//           ),
//
//           SizedBox(height: 24),
//
//           // Status indicator
//           Obx(() {
//             final controller = Get.find<DashboardController>();
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.blue.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.info_outline,
//                     size: 16,
//                     color: Colors.blue,
//                   ),
//                   SizedBox(width: 8),
//                   Text(
//                     'Current Status: ${controller.userStatus.value.toUpperCase()}',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//
//           SizedBox(height: 20),
//
//           // Buttons
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed: () {
//                     // Don't close dialog - just contact support
//                     _contactSupport();
//                   },
//                   style: OutlinedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     'Contact Support',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(width: 12),
//
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Don't close dialog - just navigate to subscription
//                     _navigateToSubscription();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     'Renew Now',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFeatureRow(String text, IconData icon) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 18,
//             color: Colors.grey,
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Icon(
//             Icons.lock_outline,
//             size: 16,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _contactSupport() {
//     // Implement contact support logic without closing dialog
//     Get.snackbar(
//       'Contact Support',
//       'Please contact our support team to resolve subscription issues.',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: Duration(seconds: 3),
//     );
//   }
//
//   void _navigateToSubscription() {
//     // Implement navigation to subscription page without closing dialog
//     Get.snackbar(
//       'Renew Subscription',
//       'Please visit our website or contact support to renew your subscription.',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: Duration(seconds: 3),
//     );
//   }
// }