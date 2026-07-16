import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../constant/app_colors.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0), // સાઇટ જેવો પ્રીમિયમ બેકગ્રાઉન્ડ
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: isWeb ? 450 : double.infinity,
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15)],
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.account_balance_rounded, size: 60, color: Colors.amber),
                const SizedBox(height: 16),
                const Text(
                    "જ્ઞાતિ ડિજિટલ પોર્ટલ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)
                ),
                const Text(
                    "ઈમેલ અને પાસવર્ડ દ્વારા લોગિન કરો ભાઈ",
                    style: TextStyle(fontSize: 13, color: Colors.grey)
                ),
                const SizedBox(height: 35),

                // 📧 ઈમેલ આઈડી બોક્સ
                TextField(
                  controller: controller.emailController,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "ઈમેલ આઈડી *",
                    prefixIcon: const Icon(Icons.email_outlined),
                    filled: true,
                    fillColor: const Color(0xFFF9F6F0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),

                // 🔑 પાસવર્ડ બોક્સ
                TextField(
                  controller: controller.passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    labelText: "લોગિન પાસવર્ડ *",
                    prefixIcon: const Icon(Icons.lock_outline),
                    filled: true,
                    fillColor: const Color(0xFFF9F6F0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 30),

                // 🚀 લોગિન બટન
                Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4500), // સાઇટ જેવો કેસરી ઓરેન્જ કલર
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: controller.isLoading.value ? null : () => controller.loginWithEmailPassword(),
                  child: controller.isLoading.value
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                      : const Text("લોગિન કરો", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                )),

                const SizedBox(height: 25),
                const Divider(),
                const SizedBox(height: 10),

                // ➔ ⚡ નવી નોંધણી માટે લિંક ભાઈ
                TextButton(
                  onPressed: () => Get.toNamed('/RegistrationStepperScreen'),
                  child: const Text(
                      "નવા સભ્ય છો? અહીંયાથી નોંધણી ફોર્મ ભરો ભાઈ ➔",
                      style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 13)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}