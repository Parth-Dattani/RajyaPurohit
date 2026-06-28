// import 'dart:math' show Random;
// import 'dart:ui';
//
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../constant/const.dart';
// import '../../controllers/auth_controller.dart';
// import '../../controllers/controller.dart';
// import '../../widgets/widgets.dart';
//
//
//
//
//
// class AuthScreen extends GetView<AuthController> {
//   static const pageId = "/AuthScreen";
//
//   const AuthScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     if (!Get.isRegistered<AuthController>()) {
//       Get.put(AuthController());
//     }
//
//     final bool webWide = kIsWeb && screenWidth >= 900;
//
//     return Scaffold(
//       backgroundColor: AppColors.deepSpaceBlue,
//       // Web + focus: resizing the scaffold rebuilds the stack and breaks
//       // BlinkingStar state/tickers unless every star has a stable key.
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           ...controller.stars.asMap().entries.map((entry) {
//             final i = entry.key;
//             final star = entry.value;
//             return BlinkingStar(
//               key: ValueKey('auth_star_$i'),
//               top: star.top * screenHeight,
//               left: star.left * screenWidth,
//               size: star.size,
//               duration: star.duration,
//             );
//           }),
//
//           if (!webWide)
//             Positioned(
//               bottom: -screenHeight * 0.35,
//               left: -50,
//               right: -50,
//               height: screenHeight * 0.47,
//               child: Opacity(
//                 opacity: 0.3,
//                 child: Image.asset(
//                   "assets/images/earth_blue.png",
//                   fit: BoxFit.cover,
//                   alignment: Alignment.topCenter,
//                 ),
//               ),
//             ),
//
//           SafeArea(
//             child: webWide
//                 ? Row(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(
//                         child: _buildWebAuthBranding(screenHeight),
//                       ),
//                       Expanded(
//                         child: Center(
//                           child: SingleChildScrollView(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 40,
//                               vertical: 36,
//                             ),
//                             child: ConstrainedBox(
//                               constraints:
//                                   const BoxConstraints(maxWidth: 440),
//                               child: Material(
//                                 color: const Color(0xE60F1419),
//                                 elevation: 8,
//                                 shadowColor: Colors.black54,
//                                 borderRadius: BorderRadius.circular(24),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(24),
//                                     border: Border.all(
//                                       color: AppColors.healingTeal
//                                           .withOpacity(0.22),
//                                     ),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 32,
//                                     vertical: 36,
//                                   ),
//                                   child: _buildAuthFormColumn(
//                                     context,
//                                     showLogo: false,
//                                     headlineFontSize: 28,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 : Center(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 32,
//                         vertical: 48,
//                       ),
//                       child: ConstrainedBox(
//                         constraints: const BoxConstraints(maxWidth: 450),
//                         child: _buildAuthFormColumn(
//                           context,
//                           showLogo: true,
//                           headlineFontSize: 26,
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//
//           Positioned(
//             top: 0,
//             left: 0,
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 12, top: 4),
//                 child: GestureDetector(
//                   onTap: () => Get.back(),
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.1),
//                       ),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back_ios_new,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildWebAuthBranding(double screenHeight) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Color(0xFF0c1f38),
//             Color(0xFF0a1628),
//             Color(0xFF071018),
//           ],
//         ),
//       ),
//       child: Stack(
//         clipBehavior: Clip.hardEdge,
//         children: [
//           // Full-height earth, brighter; only top & edges softly vignette.
//           Positioned.fill(
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Opacity(
//                   opacity: 0.62,
//                   child: Image.asset(
//                     "assets/images/earth_blue.png",
//                     fit: BoxFit.cover,
//                     alignment: const Alignment(0, 0.35),
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       gradient: RadialGradient(
//                         center: const Alignment(0, -0.15),
//                         radius: 1.15,
//                         colors: [
//                           AppColors.deepSpaceBlue.withOpacity(0.25),
//                           Colors.transparent,
//                         ],
//                         stops: const [0.0, 0.55],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: const Alignment(0, 0.22),
//                         colors: [
//                           AppColors.deepSpaceBlue,
//                           AppColors.deepSpaceBlue.withOpacity(0.72),
//                           Colors.transparent,
//                         ],
//                         stops: const [0.0, 0.45, 1.0],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Subtle star specks (static, cheap on web).
//           Positioned.fill(
//             child: CustomPaint(
//               painter: _AuthBrandStarsPainter(seed: 42),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(40, 36, 28, 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(14),
//                       child: Image.asset(
//                         'assets/images/app_logo.jpg',
//                         width: 52,
//                         height: 52,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 14),
//                     const Text(
//                       'Compassiona',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 21,
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: 0.35,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 28),
//                 Expanded(
//                   child: Center(
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(maxWidth: 420),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Heal the World.',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.98),
//                               fontSize: 34,
//                               fontWeight: FontWeight.w700,
//                               height: 1.12,
//                               shadows: [
//                                 Shadow(
//                                   color: Colors.black.withOpacity(0.45),
//                                   blurRadius: 12,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Together.',
//                             style: TextStyle(
//                               color: AppColors.healingTeal,
//                               fontSize: 38,
//                               fontWeight: FontWeight.w800,
//                               height: 1.1,
//                               shadows: [
//                                 Shadow(
//                                   color: AppColors.healingTeal.withOpacity(0.35),
//                                   blurRadius: 18,
//                                   offset: Offset.zero,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 22),
//                           Text(
//                             'Join live global sync, track your sessions, and see your impact — one mindful moment at a time.',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.78),
//                               fontSize: 15,
//                               height: 1.55,
//                             ),
//                           ),
//                           const SizedBox(height: 22),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               _authBrandFeatureLine(
//                                 Icons.public_rounded,
//                                 'Live healing globe — see who’s meditating worldwide',
//                               ),
//                               const SizedBox(height: 10),
//                               _authBrandFeatureLine(
//                                 Icons.bolt_rounded,
//                                 'Join synchronized group sessions in real time',
//                               ),
//                               const SizedBox(height: 10),
//                               _authBrandFeatureLine(
//                                 Icons.history_rounded,
//                                 'Track sessions and your personal journey',
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _authBrandFeatureLine(IconData icon, String label) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(top: 2),
//           child: Icon(
//             icon,
//             size: 16,
//             color: AppColors.healingTeal.withOpacity(0.72),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Text(
//             label,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.68),
//               fontSize: 14,
//               height: 1.4,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAuthFormColumn(
//     BuildContext context, {
//     required bool showLogo,
//     required double headlineFontSize,
//   }) {
//     // Avoid one huge Obx: rebuilding the whole column (especially all TextFields)
//     // on password visibility / mode changes breaks focus on web →
//     // "Assertion failed: _elements.contains(element) is not true".
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         if (showLogo) ...[
//           Center(
//             child: Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.healingTeal.withOpacity(0.5),
//                   width: 2,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.healingTeal.withOpacity(0.2),
//                     blurRadius: 20,
//                     spreadRadius: 5,
//                   ),
//                 ],
//                 image: const DecorationImage(
//                   image: AssetImage('assets/images/app_logo.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//         ] else
//           const SizedBox(height: 4),
//
//         Obx(
//           () => Text(
//             controller.isRegistering.value ? 'Create Account' : 'Welcome Back',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: headlineFontSize,
//               fontWeight: FontWeight.w600,
//               letterSpacing: 0.5,
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Obx(
//           () => Text(
//             controller.isRegistering.value
//                 ? 'Join the community to track your impact.'
//                 : 'Sign in to continue your journey.',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.5),
//               fontSize: 15,
//               height: 1.5,
//             ),
//           ),
//         ),
//
//         SizedBox(height: showLogo ? 40 : 28),
//
//         Obx(
//           () {
//             if (!controller.isRegistering.value) {
//               return const SizedBox.shrink();
//             }
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _buildMinimalField(
//                   controller.nameController,
//                   'Full Name',
//                   Icons.person_outline,
//                   fieldKey: const ValueKey('auth_name'),
//                 ),
//                 const SizedBox(height: 16),
//                 _buildMinimalField(
//                   controller.phoneController,
//                   'Phone Number (Optional)',
//                   Icons.phone_outlined,
//                   inputType: TextInputType.phone,
//                   fieldKey: const ValueKey('auth_phone'),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Gender Identity (Optional)',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.5),
//                     fontSize: 12,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 _buildGenderSelector(),
//                 const SizedBox(height: 16),
//               ],
//             );
//           },
//         ),
//
//         _buildMinimalField(
//           controller.emailController,
//           'Email Address',
//           Icons.email_outlined,
//           inputType: TextInputType.emailAddress,
//           fieldKey: const ValueKey('auth_email'),
//         ),
//         const SizedBox(height: 16),
//
//         const _AuthPasswordField(),
//
//         Obx(
//           () {
//             if (controller.isRegistering.value) {
//               return const SizedBox.shrink();
//             }
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(height: 8),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: controller.showForgotPasswordDialog,
//                     style: TextButton.styleFrom(
//                       foregroundColor:
//                           AppColors.healingTeal.withOpacity(0.8),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 0, vertical: 4),
//                       minimumSize: Size.zero,
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                     child: const Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//
//         const SizedBox(height: 22),
//
//         Obx(
//           () => SizedBox(
//             height: 56,
//             child: ElevatedButton(
//               onPressed: controller.isLoading.value ? null : controller.submitAuth,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.healingTeal,
//                 foregroundColor: Colors.white,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               child: controller.isLoading.value
//                   ? const SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ),
//                     )
//                   : Text(
//                       controller.isRegistering.value ? 'Sign Up' : 'Log In',
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 20),
//
//         Row(
//           children: [
//             Expanded(
//               child: Divider(
//                 color: Colors.white.withOpacity(0.12),
//                 thickness: 1,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'or continue with',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.35),
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Divider(
//                 color: Colors.white.withOpacity(0.12),
//                 thickness: 1,
//               ),
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 20),
//
//         Obx(
//           () => SizedBox(
//             height: 56,
//             child: OutlinedButton(
//               onPressed: controller.isLoading.value
//                   ? null
//                   : controller.signInWithGoogle,
//               style: OutlinedButton.styleFrom(
//                 side: BorderSide(
//                   color: Colors.white.withOpacity(0.15),
//                   width: 1.5,
//                 ),
//                 backgroundColor: const Color(0xFF1A1D24),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/images/google_logo.png',
//                     height: 22,
//                     width: 22,
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Sign In with Google',
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 16),
//         Obx(
//           () => SizedBox(
//             height: 56,
//             child: OutlinedButton(
//               onPressed: controller.isLoading.value
//                   ? null
//                   : controller.signInWithApple,
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//               ),
//               child: const Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.apple, color: Colors.black, size: 26),
//                   SizedBox(width: 12),
//                   Text(
//                     'Sign In with Apple',
//                     style:
//                         TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 24),
//
//         Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 controller.isRegistering.value
//                     ? 'Already have an account?'
//                     : "Don't have an account?",
//                 style: TextStyle(color: Colors.white.withOpacity(0.6)),
//               ),
//               TextButton(
//                 onPressed: controller.toggleMode,
//                 style: TextButton.styleFrom(
//                   foregroundColor: AppColors.healingTeal,
//                 ),
//                 child: Text(
//                   controller.isRegistering.value ? 'Log In' : 'Sign Up',
//                   style: const TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         SizedBox(
//           height: MediaQuery.of(context).viewInsets.bottom > 0
//               ? (kIsWeb ? 48 : 200)
//               : 0,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildGenderSelector() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1A1D24),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.wc, color: Colors.white38, size: 22),
//           const SizedBox(width: 12),
//           Text("Gender:",
//               style: TextStyle(
//                   color: Colors.white.withOpacity(0.4), fontSize: 16)),
//           const SizedBox(width: 16),
//           Expanded(
//             child: GestureDetector(
//               onTap: () => controller.selectGender("Male"),
//               child: Obx(() => Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: controller.selectedGender.value == "Male"
//                       ? AppColors.healingTeal.withOpacity(0.2)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                       color: controller.selectedGender.value == "Male"
//                           ? AppColors.healingTeal
//                           : Colors.transparent),
//                 ),
//                 child: Center(
//                     child: Text("Male",
//                         style: TextStyle(
//                             color:
//                             controller.selectedGender.value == "Male"
//                                 ? AppColors.healingTeal
//                                 : Colors.white54,
//                             fontWeight: FontWeight.bold))),
//               )),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: GestureDetector(
//               onTap: () => controller.selectGender("Female"),
//               child: Obx(() => Container(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: controller.selectedGender.value == "Female"
//                       ? Colors.pinkAccent.withOpacity(0.2)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                       color:
//                       controller.selectedGender.value == "Female"
//                           ? Colors.pinkAccent
//                           : Colors.transparent),
//                 ),
//                 child: Center(
//                     child: Text("Female",
//                         style: TextStyle(
//                             color:
//                             controller.selectedGender.value ==
//                                 "Female"
//                                 ? Colors.pinkAccent
//                                 : Colors.white54,
//                             fontWeight: FontWeight.bold))),
//               )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMinimalField(
//       TextEditingController textController,
//       String hint,
//       IconData icon, {
//         bool isPassword = false,
//         TextInputType inputType = TextInputType.text,
//         bool isPasswordField = false,
//         VoidCallback? onToggleVisibility,
//         Key? fieldKey,
//       }) {
//     return TextField(
//       key: fieldKey,
//       controller: textController,
//       obscureText: isPassword,
//       keyboardType: inputType,
//       style: const TextStyle(color: Colors.white),
//       cursorColor: AppColors.healingTeal,
//       decoration: InputDecoration(
//         labelText: hint,
//         labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
//         prefixIcon: Icon(icon, color: Colors.white38, size: 22),
//         suffixIcon: isPasswordField
//             ? IconButton(
//           onPressed: onToggleVisibility,
//           icon: Icon(
//               isPassword ? Icons.visibility_off : Icons.visibility,
//               color: Colors.white38),
//         )
//             : null,
//         filled: true,
//         fillColor: const Color(0xFF1A1D24),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide:
//             const BorderSide(color: AppColors.healingTeal, width: 1.5)),
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//       ),
//     );
//   }
// }
//
// /// Password visibility without [Obx] wrapping a [TextField] (avoids web focus tree
// /// crashes: `_elements.contains(element) is not true`).
// class _AuthPasswordField extends StatefulWidget {
//   const _AuthPasswordField();
//
//   @override
//   State<_AuthPasswordField> createState() => _AuthPasswordFieldState();
// }
//
// class _AuthPasswordFieldState extends State<_AuthPasswordField> {
//   late final AuthController _auth;
//   Worker? _visibilityWorker;
//
//   @override
//   void initState() {
//     super.initState();
//     _auth = Get.find<AuthController>();
//     _visibilityWorker = ever<bool>(_auth.isPasswordHidden, (_) {
//       if (mounted) setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     _visibilityWorker?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hidden = _auth.isPasswordHidden.value;
//     return TextField(
//       key: const ValueKey('auth_password'),
//       controller: _auth.passwordController,
//       obscureText: hidden,
//       style: const TextStyle(color: Colors.white),
//       cursorColor: AppColors.healingTeal,
//       decoration: InputDecoration(
//         labelText: 'Password',
//         labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
//         prefixIcon:
//             const Icon(Icons.lock_outline, color: Colors.white38, size: 22),
//         suffixIcon: IconButton(
//           onPressed: _auth.togglePasswordVisibility,
//           icon: Icon(
//             hidden ? Icons.visibility_off : Icons.visibility,
//             color: Colors.white38,
//           ),
//         ),
//         filled: true,
//         fillColor: const Color(0xFF1A1D24),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide:
//               const BorderSide(color: AppColors.healingTeal, width: 1.5),
//         ),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//       ),
//     );
//   }
// }
//
// /// Lightweight static stars for web branding (no per-star AnimationControllers).
// class _AuthBrandStarsPainter extends CustomPainter {
//   _AuthBrandStarsPainter({required this.seed});
//
//   final int seed;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final random = Random(seed);
//     final paint = Paint()..color = Colors.white.withOpacity(0.28);
//     for (var i = 0; i < 48; i++) {
//       final x = random.nextDouble() * size.width;
//       final y = random.nextDouble() * size.height;
//       final r = random.nextDouble() * 1.2 + 0.35;
//       canvas.drawCircle(Offset(x, y), r, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _AuthBrandStarsPainter oldDelegate) =>
//       oldDelegate.seed != seed;
// }
