// import 'dart:math' as math;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/foundation.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import '../firebase_options.dart';
// import '../widgets/widgets.dart';
// import 'profile_controller.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../constant/const.dart';
//
// /// Apple Developer → Identifiers → Services ID (for Web + Android “Sign in with Apple”).
// /// Must match Firebase Console → Authentication → Apple → Services ID.
// const String _appleSignInServiceId = 'com.meditation.compassiona.web';
//
// /// User closed the “enter password to link Google” dialog without linking.
// class _GoogleAuthUserCancelled implements Exception {}
//
// class AuthController extends GetxController {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//
//   final isPasswordHidden = true.obs;
//   void togglePasswordVisibility() =>
//       isPasswordHidden.value = !isPasswordHidden.value;
//
//   final isLoading = false.obs;
//   final isRegistering = false.obs;
//
//   final List<StarData> stars = [];
//   final selectedGender = "".obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _generateStars();
//   }
//
//   void _generateStars() {
//     final int starCount = kIsWeb ? 30 : 50;
//     final random = math.Random();
//     for (int i = 0; i < starCount; i++) {
//       stars.add(StarData(
//         top: random.nextDouble(),
//         left: random.nextDouble(),
//         size: random.nextDouble() * 3 + 2,
//         duration: random.nextInt(1500) + 1000,
//       ));
//     }
//   }
//
//   void toggleMode() {
//     FocusManager.instance.primaryFocus?.unfocus();
//     isRegistering.value = !isRegistering.value;
//   }
//
//   // ============================================================
//   // ✅ NEW: FORGOT PASSWORD
//   // ============================================================
//   void showForgotPasswordDialog() {
//     FocusManager.instance.primaryFocus?.unfocus();
//     final resetEmailController = TextEditingController();
//
//     Get.dialog(
//       Dialog(
//         backgroundColor: const Color(0xFF1A1D24),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//         child: Builder(
//           builder: (dialogContext) {
//             final screenW = MediaQuery.sizeOf(dialogContext).width;
//             final dialogW = math.min(400.0, screenW - 40).clamp(0.0, 400.0);
//             return SizedBox(
//               width: dialogW > 0 ? dialogW : 320,
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: AppColors.healingTeal.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Icon(Icons.lock_reset_rounded,
//                               color: AppColors.healingTeal, size: 22),
//                         ),
//                         const SizedBox(width: 12),
//                         const Expanded(
//                           child: Text(
//                             'Reset Password',
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Enter your email address and we\'ll send you a link to reset your password.',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.5),
//                         fontSize: 13,
//                         height: 1.5,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: resetEmailController,
//                       keyboardType: TextInputType.emailAddress,
//                       style: const TextStyle(color: Colors.white),
//                       cursorColor: AppColors.healingTeal,
//                       decoration: InputDecoration(
//                         labelText: 'Email Address',
//                         labelStyle: TextStyle(
//                             color: Colors.white.withOpacity(0.4)),
//                         prefixIcon: const Icon(Icons.email_outlined,
//                             color: Colors.white38, size: 22),
//                         filled: true,
//                         fillColor: const Color(0xFF0F1115),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: BorderSide.none,
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(14),
//                           borderSide: const BorderSide(
//                               color: AppColors.healingTeal, width: 1.5),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextButton(
//                             onPressed: () => Get.back(),
//                             style: TextButton.styleFrom(
//                               foregroundColor: Colors.white38,
//                               minimumSize: Size.zero,
//                               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 12, horizontal: 8),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 side: const BorderSide(color: Colors.white12),
//                               ),
//                             ),
//                             child: const Text('Cancel'),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () => _sendPasswordReset(
//                                 resetEmailController.text.trim()),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.healingTeal,
//                               foregroundColor: Colors.white,
//                               elevation: 0,
//                               minimumSize: Size.zero,
//                               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 12, horizontal: 8),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Text(
//                               'Send Link',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<void> _sendPasswordReset(String email) async {
//     if (email.isEmpty) {
//       Get.snackbar(
//         'Missing Email',
//         'Please enter your email address.',
//         colorText: Colors.white,
//         backgroundColor: Colors.redAccent.withOpacity(0.8),
//       );
//       return;
//     }
//
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       Get.back(); // Close dialog
//       Get.snackbar(
//         'Email Sent ✉️',
//         'Password reset link sent to $email',
//         colorText: Colors.white,
//         backgroundColor: const Color(0xFF00A86B),
//         duration: const Duration(seconds: 4),
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = 'Could not send reset email.';
//       if (e.code == 'invalid-credential' || e.code == 'wrong-password' || e.code == 'user-not-found') {
//         message = "Invalid email or password. Please check and try again.";
//       } else if (e.code == 'email-already-in-use') {
//         message = "This email is already registered. Try logging in instead.";
//       } else if (e.code == 'network-request-failed') {
//         message = "No internet connection. Please check your network.";
//       } else if (e.code == 'too-many-requests') {
//         message = "Too many failed attempts. Please try again later.";
//       }
//       Get.snackbar(
//         'Error',
//         message,
//         colorText: Colors.white,
//         backgroundColor: Colors.redAccent.withOpacity(0.8),
//       );
//     }
//   }
//
//   /// Same email can exist as **password** user vs **Google** user until linked.
//   /// Firebase returns [account-exists-with-different-credential]; we sign in with
//   /// password then [linkWithCredential] so Google works on the same account.
//   Future<UserCredential?> _promptPasswordThenLinkGoogle(
//     FirebaseAuth auth,
//     AuthCredential googleCredential,
//     String email,
//   ) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//     final passwordController = TextEditingController();
//
//     return Get.dialog<UserCredential?>(
//       Dialog(
//         backgroundColor: const Color(0xFF1A1D24),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Link Google to your account',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'This email is already registered with a password. Enter your password once to add Google sign-in to the same account.',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.55),
//                   fontSize: 13,
//                   height: 1.45,
//                 ),
//               ),
//               const SizedBox(height: 18),
//               Text(
//                 email,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: passwordController,
//                 obscureText: true,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: const BorderSide(color: Color(0xFF00A86B)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () => Get.back(result: null),
//                     child: Text(
//                       'Cancel',
//                       style: TextStyle(color: Colors.white.withOpacity(0.7)),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF00A86B),
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () async {
//                       final password = passwordController.text.trim();
//                       if (password.isEmpty) {
//                         Get.snackbar(
//                           'Missing',
//                           'Please enter your password.',
//                           colorText: Colors.white,
//                           backgroundColor: Colors.redAccent.withOpacity(0.8),
//                         );
//                         return;
//                       }
//                       try {
//                         final emailCred = await auth.signInWithEmailAndPassword(
//                           email: email,
//                           password: password,
//                         );
//                         try {
//                           final linked = await emailCred.user!
//                               .linkWithCredential(googleCredential);
//                           Get.back(result: linked);
//                         } on FirebaseAuthException catch (le) {
//                           if (le.code == 'provider-already-linked' ||
//                               le.code == 'credential-already-in-use') {
//                             Get.back(result: emailCred);
//                             return;
//                           }
//                           rethrow;
//                         }
//                       } on FirebaseAuthException catch (e) {
//                         String msg = e.message ?? e.code;
//                         if (e.code == 'wrong-password' ||
//                             e.code == 'invalid-credential') {
//                           msg = 'Wrong password. Try again.';
//                         } else if (e.code == 'user-not-found') {
//                           msg = 'No password account for this email.';
//                         }
//                         Get.snackbar(
//                           'Auth Error',
//                           msg,
//                           colorText: Colors.white,
//                           backgroundColor: Colors.redAccent.withOpacity(0.85),
//                         );
//                       }
//                     },
//                     child: const Text('Continue'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     ).whenComplete(() => passwordController.dispose());
//   }
//
//   Future<UserCredential> _completeGoogleCredentialSignIn({
//     required FirebaseAuth auth,
//     required AuthCredential credential,
//     String? googleEmail,
//   }) async {
//     Future<UserCredential> primary() async {
//       if (auth.currentUser != null && auth.currentUser!.isAnonymous) {
//         try {
//           return await auth.currentUser!.linkWithCredential(credential);
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'credential-already-in-use' ||
//               e.code == 'email-already-in-use') {
//             return await auth.signInWithCredential(credential);
//           }
//           rethrow;
//         }
//       }
//       return await auth.signInWithCredential(credential);
//     }
//
//     try {
//       return await primary();
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'account-exists-with-different-credential') {
//         final email = (e.email != null && e.email!.isNotEmpty)
//             ? e.email!
//             : ((googleEmail != null && googleEmail.isNotEmpty)
//                 ? googleEmail
//                 : null);
//         if (email != null) {
//           final linked =
//               await _promptPasswordThenLinkGoogle(auth, credential, email);
//           if (linked != null) return linked;
//           throw _GoogleAuthUserCancelled();
//         }
//       }
//       rethrow;
//     }
//   }
//
//   // Future<UserCredential> _signInWithGoogleWeb(FirebaseAuth auth) async {
//   //   final googleProvider = GoogleAuthProvider();
//   //   googleProvider.addScope('email');
//   //   googleProvider.addScope('profile');
//   //
//   //   final GoogleSignIn googleSignIn = GoogleSignIn(
//   //     clientId: '37665814224-arh8aacb1ia2jnggqr89821a7vgplbg6.apps.googleusercontent.com',
//   //   );
//   //
//   //   Future<UserCredential> primary() async {
//   //     if (auth.currentUser != null && auth.currentUser!.isAnonymous) {
//   //       try {
//   //         return await auth.currentUser!.linkWithPopup(googleProvider);
//   //       } on FirebaseAuthException catch (e) {
//   //         if (e.code == 'credential-already-in-use' ||
//   //             e.code == 'email-already-in-use') {
//   //           return await auth.signInWithPopup(googleProvider);
//   //         }
//   //         rethrow;
//   //       }
//   //     }
//   //     return await auth.signInWithPopup(googleProvider);
//   //   }
//   //
//   //   try {
//   //     return await primary();
//   //   } on FirebaseAuthException catch (e) {
//   //     if (e.code == 'account-exists-with-different-credential') {
//   //       final cred = e.credential;
//   //       final em = e.email;
//   //       if (cred != null && em != null && em.isNotEmpty) {
//   //         final linked = await _promptPasswordThenLinkGoogle(auth, cred, em);
//   //         if (linked != null) return linked;
//   //         throw _GoogleAuthUserCancelled();
//   //       }
//   //     }
//   //     rethrow;
//   //   }
//   // }
//
//   Future<UserCredential> _signInWithGoogleWeb(FirebaseAuth auth) async {
//     // 1. Initialize GoogleSignIn object for Web with the proper OAuth Client ID
//     final GoogleSignIn googleSignIn = GoogleSignIn(
//       clientId: '37665814224-t2pk9gii2bkc028dc9rii23a1qsf0dka.apps.googleusercontent.com',
//     );
//
//     Future<UserCredential> primary() async {
//       // 2. Trigger the native Google sign-in account picker
//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//
//       if (googleUser == null) {
//         throw FirebaseAuthException(
//           code: 'sign_in_canceled',
//           message: 'User cancelled the Google sign-in flow.',
//         );
//       }
//
//       // 3. Obtain the authentication tokens from the sign-in session
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//       // 4. Create a new credential for Firebase using the tokens
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       // 5. If currentUser is anonymous, link the credential; otherwise, sign in directly
//       if (auth.currentUser != null && auth.currentUser!.isAnonymous) {
//         try {
//           return await auth.currentUser!.linkWithCredential(credential);
//         } on FirebaseAuthException catch (e) {
//           if (e.code == 'credential-already-in-use' || e.code == 'email-already-in-use') {
//             return await auth.signInWithCredential(credential);
//           }
//           rethrow;
//         }
//       }
//       return await auth.signInWithCredential(credential);
//     }
//
//     try {
//       return await primary();
//     } on FirebaseAuthException catch (e) {
//       // 6. Handle account linking if the email is already registered with a password
//       if (e.code == 'account-exists-with-different-credential') {
//         final GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
//         final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//
//         if (googleAuth != null) {
//           final cred = GoogleAuthProvider.credential(
//             accessToken: googleAuth.accessToken,
//             idToken: googleAuth.idToken,
//           );
//           final em = googleUser?.email;
//           if (em != null && em.isNotEmpty) {
//             final linked = await _promptPasswordThenLinkGoogle(auth, cred, em);
//             if (linked != null) return linked;
//             throw _GoogleAuthUserCancelled();
//           }
//         }
//       }
//       rethrow;
//     }
//   }
//
//   /// ============================================================
//   // ✅ NEW: GOOGLE SIGN-IN
//   // ============================================================
//
//   Future<void> signInWithGoogle() async {
//     try {
//       isLoading.value = true;
//       late final UserCredential userCredential;
//       final auth = FirebaseAuth.instance;
//
//       if (kIsWeb) {
//         userCredential = await _signInWithGoogleWeb(auth);
//       } else {
//         final GoogleSignIn googleSignIn = GoogleSignIn();
//
//         // પહેલા ડિવાઇસ પરનું Google સેશન વાપરો; નહિ તો ખાલી ત્યારે એકાઉન્ટ પિકર દેખાડો.
//         // દર વખતે signOut() કરતા લૉગ ઇન પછી પણ ફરી ફરી Google પૂછાતું હતું.
//         GoogleSignInAccount? googleUser = await googleSignIn.signInSilently();
//         googleUser ??= await googleSignIn.signIn();
//
//         if (googleUser == null) {
//           isLoading.value = false;
//           return;
//         }
//
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//
//         userCredential = await _completeGoogleCredentialSignIn(
//           auth: auth,
//           credential: credential,
//           googleEmail: googleUser.email,
//         );
//       }
//
//       // ✅ HD Photo Logic: ગૂગલના ફોટોને High Resolution માં ફેરવો
//       String? hdPhoto = userCredential.user?.photoURL;
//       if (hdPhoto != null && hdPhoto.contains("googleusercontent.com")) {
//         hdPhoto = hdPhoto.replaceAll("s96-c", "s400-c"); // 400px HD Photo
//       }
//
//       // ડેટાબેઝમાં સેવ અથવા અપડેટ કરો
//       await _saveUserToDatabase(userCredential.user, hdPhoto);
//
//       Get.back();
//       Get.snackbar(
//         'Welcome! 🚀',
//         'Signed in with Google successfully.',
//         colorText: Colors.white,
//         backgroundColor: const Color(0xFF00A86B),
//       );
//
//       if (Get.isRegistered<ProfileController>()) {
//         Get.find<ProfileController>().onInit();
//       }
//
//     } on _GoogleAuthUserCancelled {
//       // User cancelled password dialog — no snackbar.
//     } on FirebaseAuthException catch (e) {
//       String msg = e.message ?? 'Authentication failed';
//       if (e.code == 'account-exists-with-different-credential') {
//         msg =
//             'This email is registered with a password. Use “Continue” in the dialog to link Google, or sign in with Email first.';
//       }
//       Get.snackbar(
//         'Auth Error',
//         msg,
//         backgroundColor: Colors.redAccent.withOpacity(0.8),
//         colorText: Colors.white,
//       );
//     } catch (e) {
//       Get.snackbar('Error', 'Google Sign-In failed: $e',
//           backgroundColor: Colors.redAccent.withOpacity(0.8), colorText: Colors.white);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ✅ Apple: Web uses Firebase popup (no custom Apple Service ID in app code).
//   //    iOS/macOS/Android use sign_in_with_apple + credential.
//   Future<void> signInWithApple() async {
//     try {
//       isLoading.value = true;
//       final auth = FirebaseAuth.instance;
//
//       if (kIsWeb) {
//         final appleProvider = OAuthProvider('apple.com');
//         appleProvider.addScope('email');
//         appleProvider.addScope('name');
//         final UserCredential userCredential =
//             await auth.signInWithPopup(appleProvider);
//         await _saveUserToDatabase(userCredential.user);
//         Get.back();
//         Get.snackbar(
//           'Success 🍎',
//           'Signed in with Apple successfully.',
//           colorText: Colors.white,
//           backgroundColor: const Color(0xFF00A86B),
//         );
//         if (Get.isRegistered<ProfileController>()) {
//           Get.find<ProfileController>().onInit();
//         }
//         return;
//       }
//
//       // Android: Chrome Custom Tab needs Service ID + redirect.
//       WebAuthenticationOptions? webOpts;
//       if (defaultTargetPlatform == TargetPlatform.android) {
//         final domain = DefaultFirebaseOptions.web.authDomain;
//         webOpts = WebAuthenticationOptions(
//           clientId: _appleSignInServiceId,
//           redirectUri: Uri.parse('https://$domain/__/auth/handler'),
//         );
//       }
//
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//         webAuthenticationOptions: webOpts,
//       );
//
//       final OAuthCredential credential = OAuthProvider("apple.com").credential(
//         idToken: appleCredential.identityToken,
//         accessToken: appleCredential.authorizationCode,
//       );
//
//       final UserCredential userCredential =
//           await auth.signInWithCredential(credential);
//
//       String? firstName = appleCredential.givenName;
//       String? lastName = appleCredential.familyName;
//
//       if (firstName != null || lastName != null) {
//         String fullName = "${firstName ?? ''} ${lastName ?? ''}".trim();
//         await userCredential.user?.updateDisplayName(fullName);
//       }
//
//       await _saveUserToDatabase(userCredential.user);
//
//       Get.back();
//       Get.snackbar(
//         'Success 🍎',
//         'Signed in with Apple successfully.',
//         colorText: Colors.white,
//         backgroundColor: const Color(0xFF00A86B),
//       );
//
//       if (Get.isRegistered<ProfileController>()) {
//         Get.find<ProfileController>().onInit();
//       }
//     } on FirebaseAuthException catch (e) {
//       debugPrint('Apple Auth FirebaseAuthException: ${e.code} ${e.message}');
//       Get.snackbar(
//         'Apple Sign-In',
//         e.message ?? e.code,
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//         duration: const Duration(seconds: 6),
//       );
//     } catch (e) {
//       debugPrint('Apple Auth Error: $e');
//       Get.snackbar(
//         'Apple Sign-In',
//         kIsWeb
//             ? 'Enable Apple in Firebase Auth, add localhost to Authorized domains, and complete Apple provider setup. ($e)'
//             : '$e',
//         backgroundColor: Colors.redAccent,
//         colorText: Colors.white,
//         duration: const Duration(seconds: 7),
//         maxWidth: 420,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
// // ✅ Shared helper — saves user to Firebase DB
//   Future<void> _saveUserToDatabase(User? user, [String? hdPhoto]) async {
//     if (user == null) return;
//
//     final db = FirebaseDatabase.instance.ref();
//     final snapshot = await db.child("users").child(user.uid).get();
//
//     // ૧. બેકઅપ પ્રોફેશનલ અવતાર (જો ગૂગલ ફોટો ના હોય તો જ)
//     String nameSeed = Uri.encodeComponent(user.displayName ?? "User");
//     String backupAvatar = "https://ui-avatars.com/api/?name=$nameSeed&background=random&color=fff&rounded=true&size=256";
//
//     String finalPhoto = hdPhoto ?? user.photoURL ?? backupAvatar;
//
//     if (!snapshot.exists) {
//       await db.child("users").child(user.uid).set({
//         "name": user.displayName ?? "",
//         "email": user.email ?? "",
//         "phone": user.phoneNumber ?? "",
//         "gender": "",
//         "profileImage": finalPhoto,
//         "joinDate": DateTime.now().toIso8601String(),
//         "role": "Cadet",
//         "isActive": true,
//         "stats": {"impact": 0, "minutes": 0, "streak": 1},
//       });
//     } else {
//       // જૂનો યુઝર: નામ અને પ્રોફાઈલ પિક્ચર ગૂગલ સાથે Sync કરો
//       await db.child("users").child(user.uid).update({
//         "name": user.displayName ?? (snapshot.value as Map)['name'],
//         "profileImage": finalPhoto,
//       });
//     }
//   }
//
//   void selectGender(String gender) {
//     if (selectedGender.value == gender) {
//       selectedGender.value = "";
//     } else {
//       selectedGender.value = gender;
//     }
//   }
//
//   // ============================================================
//   // EXISTING: Email/Password Auth (unchanged)
//   // ============================================================
//   Future<void> submitAuth() async {
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String name = nameController.text.trim();
//
//     if (isRegistering.value) {
//       if (name.isEmpty || email.isEmpty || password.isEmpty) {
//         Get.snackbar(
//           "Missing Information",
//           "Name, Email, and Password are required.",
//           colorText: Colors.white,
//           backgroundColor: Colors.redAccent.withOpacity(0.8),
//         );
//         return;
//       }
//     }
//     else {
//       if (email.isEmpty || password.isEmpty) {
//         Get.snackbar(
//           "Missing Information",
//           "Please enter Email and Password.",
//           colorText: Colors.white,
//           backgroundColor: Colors.redAccent.withOpacity(0.8),
//         );
//         return;
//       }
//     }
//
//     try {
//       isLoading.value = true;
//       final auth = FirebaseAuth.instance;
//       final db = FirebaseDatabase.instance.ref();
//
//       if (isRegistering.value) {
//         AuthCredential credential =
//         EmailAuthProvider.credential(email: email, password: password);
//         User? user;
//
//         if (auth.currentUser != null) {
//           try {
//             final userCredential =
//             await auth.currentUser?.linkWithCredential(credential);
//             user = userCredential?.user;
//           } on FirebaseAuthException catch (e) {
//             if (e.code == 'credential-already-in-use') {
//               rethrow;
//             }
//           }
//         }
//
//         if (user == null) {
//           final userCredential = await auth.createUserWithEmailAndPassword(
//               email: email, password: password);
//           user = userCredential.user;
//         }
//
//         await user?.updateDisplayName(name);
//
//         if (user != null) {
//           String finalGender = selectedGender.value;
//           String profileAsset = "assets/images/male.png"; // Default
//
//           if (finalGender == "Female") {
//             profileAsset = "assets/images/female.png";
//           }
//
//
//           await db.child("users").child(user.uid).set({
//             "name": name,
//             "email": email,
//             "phone": phoneController.text.trim(),
//             "gender": finalGender, // "Male" or "Female"
//             "profileImage": profileAsset,
//             "joinDate": DateTime.now().toIso8601String(),
//             "role": "Cadet",
//             "isActive": true,
//             "stats": {"impact": 0, "minutes": 0, "streak": 1}
//           });
//         }
//
//         Get.back();
//         Get.snackbar(
//           "Success",
//           "Welcome ! Profile Initialized.",
//           colorText: Colors.white,
//           backgroundColor: const Color(0xFF00A86B),
//         );
//       }
//       else {
//         await auth.signInWithEmailAndPassword(
//             email: email, password: password);
//         Get.back();
//         Get.snackbar(
//           "Welcome Back",
//           "Syncing profile data...",
//           colorText: Colors.white,
//           backgroundColor: const Color(0xFF00A86B),
//         );
//       }
//
//       if (Get.isRegistered<ProfileController>()) {
//         Get.find<ProfileController>().onInit();
//       }
//     } on FirebaseAuthException catch (e) {
//       String message = e.message ?? "Authentication failed";
//       if (e.code == 'credential-already-in-use') {
//         message = "This email is already connected to another account.";
//       } else if (e.code == 'email-already-in-use') {
//         message = "This email is already registered. Please Log In.";
//       }
//       Get.snackbar(
//         "Auth Error",
//         message,
//         colorText: Colors.white,
//         backgroundColor: Colors.redAccent.withOpacity(0.8),
//       );
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "An unexpected error occurred: $e",
//         colorText: Colors.white,
//         backgroundColor: Colors.redAccent.withOpacity(0.8),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
