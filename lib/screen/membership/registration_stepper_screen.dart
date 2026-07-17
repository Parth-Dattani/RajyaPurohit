import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant/const.dart';
import '../../controllers/controller.dart';


class RegistrationStepperScreen extends GetView<RegistrationController> {
  const RegistrationStepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 1,
        shadowColor: AppColors.divider,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.heading),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person_add_alt_1, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 12),
            const Text(
              "સભ્ય નોંધણી ફોર્મ",
              style: TextStyle(color: AppColors.heading, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isWeb ? 850 : screenWidth,
            margin: EdgeInsets.symmetric(
              horizontal: isWeb ? 0 : 16,
              vertical: isWeb ? 15 : 20,
            ),
            child: Column(
              children: [
                _buildStepperHeader(isWeb),
                const SizedBox(height: 30),
                Card(
                  color: AppColors.card,
                  elevation: 4,
                  shadowColor: Colors.black.withOpacity(0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.cardBorder, width: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isWeb ? 30.0 : 20.0),
                    child: Obx(() => _buildStepContent(controller.currentStep.value, context)),
                  ),
                ),
                const SizedBox(height: 15),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResponsiveRow(List<Widget> children, BuildContext context) {
    // 600 પિક્સલથી નાની સ્ક્રીન (મોબાઈલ) માટે Column
    if (MediaQuery.of(context).size.width < 600) {
      return Column(
        children: children.map((child) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: child,
        )).toList(),
      );
    }
    // મોટી સ્ક્રીન માટે Row
    return Row(
      children: children.asMap().entries.map((entry) {
        int idx = entry.key;
        Widget child = entry.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: idx == 0 ? 0 : 8, right: idx == children.length - 1 ? 0 : 8),
            child: child,
          ),
        );
      }).toList(),
    );
  }

  // ==========================================
  // 🔹 Custom Stepper Header Indicator Line
  // ==========================================
  Widget _buildStepperHeader(bool isWeb) {
    final steps = [
      {'icon': Icons.security_rounded, 'label': 'વેરિફિકેશન પેનલ'},
      {'icon': Icons.person_outline, 'label': 'પ્રાથમિક માહિતી'},
      {'icon': Icons.info_outline, 'label': 'અંગત વિગતો'},
      {'icon': Icons.family_restroom, 'label': 'પરિવારની વિગતો'},
      {'icon': Icons.check_circle_outline, 'label': 'ચકાસણી'},
    ];

    return Obx(() => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(steps.length, (index) {
          final isCompleted = index < controller.currentStep.value;
          final isActive = index == controller.currentStep.value;

          final Color circleColor = isActive ? AppColors.surface : (isCompleted ? AppColors.primary : AppColors.surface);
          final Color borderColor = (isActive || isCompleted) ? AppColors.accent : AppColors.cardBorder;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: borderColor, width: isActive ? 3 : 1.5),
                      boxShadow: isActive ? [BoxShadow(color: AppColors.accent.withOpacity(0.25), blurRadius: 10)] : null,
                    ),
                    child: Icon(
                      steps[index]['icon'] as IconData,
                      color: isActive ? AppColors.primary : (isCompleted ? AppColors.whiteText : AppColors.subtitle),
                      size: 22,
                    ),
                  ),
                  if (isWeb) const SizedBox(height: 8),
                  if (isWeb)
                    Text(
                      steps[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: (isActive || isCompleted) ? FontWeight.bold : FontWeight.normal,
                        color: (isActive || isCompleted) ? AppColors.heading : AppColors.subtitle,
                      ),
                    ),
                ],
              ),
              if (index < steps.length - 1)
                Container(
                  width: isWeb ? 60 : 30,
                  height: 2,
                  color: index < controller.currentStep.value ? AppColors.accent : AppColors.cardBorder,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                ),
            ],
          );
        }),
      ),
    ));
  }

  Widget _buildStepContent(int step, BuildContext context) {
    switch (step) {
      case 0: return _buildMobileStep(context);
      case 1: return _buildPrimaryInfoStep(context);
      case 2: return _buildPersonalDetailsStep(context);
      case 3: return _buildFamilyStep(context);
      case 4: return _buildVerificationStep();
      default: return const SizedBox();
    }
  }

  // ==========================================
  // 📱 Step 1: Mobile & Email Verification
  // ==========================================
  Widget _buildMobileStep(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.security_rounded, size: 70, color: AppColors.iconAccent),
        const SizedBox(height: 16),
        const Text("મોબાઈલ અને ઈમેલ ચકાસણી", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text("લૉગિન અથવા નવી નોંધણી માટે વિગતો ભરો", style: TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 30),

        _buildTextField(label: "મોબાઈલ નંબર *", controller: controller.phoneController, prefix: "+91 "),
        const SizedBox(height: 16),

        _buildTextField(label: "ઈમેલ આઈડી *", controller: controller.emailController, icon: Icons.email_outlined),

        // ➔ ⚡ ⚡ જૂના સભ્ય માટેનું લોગિન પાસવર્ડ બોક્સ (શો/હાઇડ સાથે)
        Obx(() {
          if (controller.isOldUser.value) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  labelText: "તમારો લોગિન પાસવર્ડ દાખલ કરો *",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(controller.isPasswordHidden.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => controller.togglePasswordVisibility(),
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        // ➔ ⚡ ⚡ નવા સભ્ય માટે પાસવર્ડ સેટિંગ બોક્સ (શો/હાઇડ સાથે)
        Obx(() {
          if (!controller.isOldUser.value && controller.currentStep.value == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.lock_open_rounded, color: Colors.orange, size: 18),
                      const SizedBox(width: 6),
                      Text("નવો લોગિન પાસવર્ડ સેટ કરો *", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.heading)),
                    ],
                  ),
                  const Divider(height: 16),
              _buildResponsiveRow([
                TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: "પાસવર્ડ બનાવો *",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isPasswordHidden.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => controller.togglePasswordVisibility(),
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
                TextField(
                  controller: controller.confirmPasswordController,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: "કન્ફર્મ પાસવર્ડ *",
                    prefixIcon: const Icon(Icons.lock_clock_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(controller.isConfirmPasswordHidden.value ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => controller.toggleConfirmPasswordVisibility(),
                    ),
                    filled: true,
                    fillColor: AppColors.background,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
              ], context),
                ],

              ),
            );
          }
          return const SizedBox.shrink();
        }),

        const SizedBox(height: 30),

        // બટનની ઉપર આ કોડ ઉમેરો
        Obx(() => controller.isOtpSent.value
            ? Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: _buildTextField(label: "OTP દાખલ કરો", controller: controller.otpController),
        )
            : const SizedBox.shrink()),

        Obx(() => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: controller.isLoading.value
              ? null
              : () async {
    if (!controller.isOtpSent.value) {
            // ➔ મોબાઈલ નંબર વેલિડેટ કરો
            if (controller.phoneController.text.trim().length < 10) {
              Get.snackbar("ભૂલ ❌", "સાચો મોબાઈલ નંબર દાખલ કરો!");
              return;
            }

            // ➔ OTP વિજેટ ઓપન કરવા માટે JS કોલ કરો
            await controller.openOtpWidget(controller.phoneController.text.trim());
            controller.isOtpSent.value = true; // ફિલ્ડ બતાવવા માટે
    } else {
      // ➔ ૨. OTP વેરીફાય કરવા માટે
      await controller.handleVerifyOtp(controller.currentReqId.value, controller.otpController.text.trim());
    }
            // if (controller.isOldUser.value) {
            //   controller.directLoginFromStepper();
            // } else {
            //   if (controller.passwordController.text.trim().isEmpty) {
            //     controller.checkUserStatus();
            //   } else {
            //     if (controller.passwordController.text.trim() != controller.confirmPasswordController.text.trim()) {
            //       Get.snackbar("પાસવર્ડ ભૂલ ❌", "બંને પાસવર્ડ એકબીજા સાથે મેચ થતા નથી!",
            //           backgroundColor: Colors.red.shade800, colorText: Colors.white);
            //       return;
            //     }
            //     controller.nextStep();
            //   }
            // }
          },
          child: controller.isLoading.value
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
              : Text(
              controller.isOldUser.value ? "લોગિન કરો" : (controller.passwordController.text.trim().isEmpty ? "ચકાસણી કરો" : "આગળ વધો ➔"),
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
          ),
        )),
      ],
    );
  }

  // ==========================================
  // 🔹 Step 2: Primary Info
  // ==========================================
  Widget _buildPrimaryInfoStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("પ્રાથમિક માહિતી", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
        const SizedBox(height: 4),
        const Text("તમારું નામ અને સરનામું દાખલ કરો", style: TextStyle(fontSize: 13, color: AppColors.subtitle)),
        const Divider(height: 30, color: AppColors.divider),

        // ફોટો અપલોડ સેક્શન
        Center(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  // નીચેની મેથડથી ડાયલોગ ખુલશે
                  Get.defaultDialog(
                    title: "ફોટો પસંદ કરો",
                    content: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text("કેમેરા"),
                          onTap: () {
                            controller.pickImage(ImageSource.camera);
                            Get.back();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text("ગેલેરી"),
                          onTap: () {
                            controller.pickImage(ImageSource.gallery);
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Obx(() => Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary),
                    image: controller.selectedImagePath.isNotEmpty
                        ? DecorationImage(image: FileImage(File(controller.selectedImagePath.value)), fit: BoxFit.cover)
                        : null,
                  ),
                  child: controller.selectedImagePath.isEmpty
                      ? const Icon(Icons.camera_alt, size: 40, color: AppColors.primary)
                      : null,
                )),
              ),
              const SizedBox(height: 8),
              const Text("સભ્યનો ફોટો અપલોડ કરો", style: TextStyle(fontSize: 12, color: AppColors.subtitle)),
            ],
          ),
        ),
        const SizedBox(height: 20),

        _buildResponsiveRow([
          _buildTextField(label: "તમારું નામ *", controller: controller.firstNameController),
          _buildTextField(label: "પિતા/પતિનું નામ *", controller: controller.fatherHusbandController),
          _buildTextField(label: "માતાનું નામ *", controller: controller.motherNameController),
        ], context),
        const SizedBox(height: 16),

        // Row 2: ૩ સેટ
        Row(
          children: [
            Expanded(child: _buildTextField(label: "અટક *", controller: controller.surnameController)),
            const SizedBox(width: 16),
            Expanded(child: _buildGenderDropdown()), // મેથડ બનાવી લેવી
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "ગોત્ર *", controller: controller.gotraController)),
          ],
        ),



        // સરનામું: અહીં Expanded વાપરવું ફરજિયાત છે
        Row(
          children: [
            Expanded(
              flex: 2, // સરનામું થોડું મોટું રાખવા માટે
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _buildTextField(label: "હાલનું પૂરું સરનામું *", controller: controller.currentAddressController, maxLines: 2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: _buildTextField(label: "જિલ્લો *", controller: controller.currentDistrictController),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row 3: ૩ સેટ
        Row(
          children: [
            Expanded(child: _buildTextField(label: "તાલુકો *", controller: controller.currentTalukaController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "ગામ/શહેર *", controller: controller.currentCityVillageController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "પીનકોડ *", controller: controller.pincodeController)),
          ],
        ),

        Obx(() {
          if (controller.selectedGender.value == 'Female') {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 40, color: AppColors.divider, thickness: 1.5),
                const Row(
                  children: [
                    Icon(Icons.home_mini, color: AppColors.primary, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "પિયર પક્ષની વિગત (ફક્ત સ્ત્રીઓ માટે)",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.heading),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(label: "પિયરના પિતાનું પૂરું નામ *", controller: controller.maternalFatherController),
                const SizedBox(height: 16),
                _buildTextField(label: "પિયરના માતાનું નામ *", controller: controller.maternalMotherController),
                const SizedBox(height: 16),
                _buildTextField(label: "મોસાળ ગામ / સરનામું *", controller: controller.maternalAddressController, maxLines: 2),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildPhotoUploadSection() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.defaultDialog(
              title: "ફોટો પસંદ કરો",
              content: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera_alt),
                    title: const Text("કેમેરા"),
                    onTap: () {
                      controller.pickImage(ImageSource.camera);
                      Get.back();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("ગેલેરી"),
                    onTap: () {
                      controller.pickImage(ImageSource.gallery);
                      Get.back();
                    },
                  ),
                ],
              ),
            );
          },
          child: Obx(() => Container(
            width: 100, height: 100,
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary),
              image: controller.selectedImagePath.isNotEmpty
                  ? DecorationImage(image: FileImage(File(controller.selectedImagePath.value)), fit: BoxFit.cover)
                  : null,
            ),
            child: controller.selectedImagePath.isEmpty
                ? const Icon(Icons.camera_alt, size: 40, color: AppColors.primary)
                : null,
          )),
        ),
        const SizedBox(height: 8),
        const Text("સભ્યનો ફોટો અપલોડ કરો", style: TextStyle(fontSize: 12, color: AppColors.subtitle)),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text("લિંગ *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
        // const SizedBox(height: 6),
        Obx(() => _buildCustomDropdown(
          value: controller.selectedGender.value,
          items: const ['Male', 'Female', 'Other'],
          onChanged: (newValue) => controller.selectedGender.value = newValue!,
        )),
      ],
    );
  }

  // ==========================================
  // 🔹 Step 3: Personal Details
  // ==========================================
  Widget _buildPersonalDetailsStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("અંગત વિગતો", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
        const Divider(height: 30, color: AppColors.divider),


        // જન્મ તારીખ
        const Text("જન્મ તારીખ (DD-MM-YYYY) *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: _buildTextField(label: "દિવસ", controller: controller.birthDayController)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(label: "મહિનો", controller: controller.birthMonthController)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(label: "વર્ષ", controller: controller.birthYearController)),
          ],
        ),
        const SizedBox(height: 16),

        // WhatsApp અને બ્લડ ગ્રુપ
        Row(
          children: [
            Expanded(child: _buildTextField(label: "WhatsApp નંબર", controller: controller.whatsappController)), // અહીં મેઈન કંટ્રોલર વાપર્યું છે
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "બ્લડ ગ્રુપ", controller: controller.bloodGroupController)), // બ્લડ ગ્રુપ માટે તમે Controller સેટ કરી લેજો
          ],
        ),
        const SizedBox(height: 16),

        // મૂળ વતન અને વૈવાહિક સ્થિતિ
        Row(
          children: [
            Expanded(child: _buildTextField(label: "મૂળ વતન *", controller: controller.nativeVillageController)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("વૈવાહિક સ્થિતિ *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                  const SizedBox(height: 6),
                  Obx(() => _buildCustomDropdown(
                    value: controller.selectedMaritalStatus.value,
                    items: const ['Single', 'Married', 'Divorced', 'Widowed'],
                    onChanged: (v) => controller.selectedMaritalStatus.value = v!,
                  )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // શિક્ષણ અને વ્યવસાય
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("શિક્ષણ *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                  const SizedBox(height: 6),
                  Obx(() => _buildCustomDropdown(
                    value: controller.selectedEducation.value,
                    items: const ['Select Option', 'Under Graduate', 'Graduate', 'Post Graduate', 'Doctorate', 'Other'],
                    onChanged: (v) => controller.selectedEducation.value = v!,
                  )),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("વ્યવસાય સ્થિતિ *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                  const SizedBox(height: 6),
                  Obx(() => _buildCustomDropdown(
                    value: controller.selectedOccupation.value,
                    items: const ['Select Option', 'Business', 'Job', 'Homemaker', 'Student', 'Retired'],
                    onChanged: (v) => controller.selectedOccupation.value = v!,
                  )),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // ➔ અહીં આટલો ફેરફાર કરો
        Obx(() {
          if (controller.selectedOccupation.value == 'Business' || controller.selectedOccupation.value == 'Job') {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _buildTextField(
                label: controller.selectedOccupation.value == 'Business' ? "પેઢીનું નામ *" : "કંપનીનું નામ *",
                controller: controller.organizationNameController,
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        // નાનાનું નામ અને મોસાળ ગામ
        Row(
          children: [
            Expanded(child: _buildTextField(label: "નાનાનું પૂરું નામ", controller: controller.maternalSurnameController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "મોસાળનું ગામ", controller: controller.maternalVillageController)),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomDropdown({required String value, required List<String> items, required ValueChanged<String?> onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          dropdownColor: AppColors.card,
          style: const TextStyle(color: AppColors.body, fontSize: 14),
          items: items.map((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }


  // ==========================================
  // 👥 Step 4: Family Details (Fixed Version)
  // ==========================================
  void addFamilyMember() {
    controller.familyMembers.add({
      'nameController': TextEditingController(),
      'relation': 'પસંદ કરો',
      'dayController': TextEditingController(),
      'monthController': TextEditingController(),
      'yearController': TextEditingController(),
      'phoneController': TextEditingController(),
      'education': 'Select Option',
      'maritalStatus': 'Single',
      'occupation': 'Select Option',
      'organizationNameController': TextEditingController(),
      'maternalFatherController': TextEditingController(),
      'maternalMotherController': TextEditingController(),
      'maternalVillageController': TextEditingController(),
    });
  }

  void removeFamilyMember(int index) {
    final member = controller.familyMembers[index];

    member['nameController']?.dispose();
    member['dayController']?.dispose();
    member['monthController']?.dispose();
    member['yearController']?.dispose();
    member['phoneController']?.dispose();
    member['organizationNameController']?.dispose();
    member['maternalFatherController']?.dispose();
    member['maternalMotherController']?.dispose();
    member['maternalVillageController']?.dispose();

    controller.familyMembers.removeAt(index);
  }

  Widget _buildFamilyStep(BuildContext context) {
    bool isMarriedRelation(String relation) {
      return ['પતિ', 'પત્ની', 'પુત્રવધૂ', 'માતા', 'પિતા', 'દાદા', 'દાદી'].contains(relation);
    }
    return Obx(() {
      final int memberCount = controller.familyMembers.length;
      if (memberCount == 0) {
        return Column(
          children: [
            const SizedBox(height: 40),

            const Icon(
              Icons.family_restroom,
              size: 70,
              color: Colors.grey,
            ),

            const SizedBox(height: 20),

            const Text(
              "હજુ સુધી કોઈ સભ્ય ઉમેરેલ નથી",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton.icon(
              onPressed: controller.addFamilyMember,
              icon: const Icon(Icons.add),
              label: const Text("નવો સભ્ય ઉમેરો"),
            ),
          ],
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "પરિવારની વિગતો",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading),
              ),

              ElevatedButton.icon(
                onPressed: controller.addFamilyMember,
                icon: const Icon(Icons.add),
                label: const Text("નવો સભ્ય"),
              ),

            ],
          ),
          const SizedBox(height: 4),
          Text("$memberCount સભ્યોની માહિતી ભરો", style: const TextStyle(fontSize: 13, color: AppColors.subtitle)),
          const Divider(height: 30, color: AppColors.divider),

          ...List.generate(memberCount, (index) {
            final reversedIndex = memberCount - 1 - index;
            final sNo = memberCount - index;
            var member = controller.familyMembers[reversedIndex];

            return Container(
              key: ValueKey('member_$reversedIndex'), // ➔ ⚡ આ Key ઉમેરવાથી 'removeChild' વાળી એરર બંધ થઈ જશે!
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.background.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder.withOpacity(0.6), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // ➔ ટેક્સ્ટ ડાબી બાજુ અને બટન જમણી બાજુ
                    children: [
                      Text("સભ્ય $sNo", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.heading)),

                      // ➔ આ રહ્યો તમારો ડિલીટ બટન
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () {
                          // યુઝરને પૂછવા માટે કન્ફર્મેશન ડાયલોગ (વધારે સારું રહેશે)
                          Get.defaultDialog(
                            title: "ડીલીટ?",
                            middleText: "શું તમે આ સભ્યને કાઢી નાખવા માંગો છો?",
                            textConfirm: "હા",
                            textCancel: "ના",
                            onConfirm: () {
                              controller.removeFamilyMember(reversedIndex);
                              Get.back(); // ડાયલોગ બંધ કરો
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ROW 1: નામ, WhatsApp, બ્લડ ગ્રુપ
                  _buildResponsiveRow([
                    _buildTextField(label: "પૂરું નામ *", controller: member['nameController']),
                    _buildTextField(label: "WhatsApp નંબર", controller: member['phoneController']),
                    _buildTextField(label: "બ્લડ ગ્રુપ", controller: member['bloodGroupController']),
                  ], context),
                  const SizedBox(height: 18),

                  // ROW 2: સંબંધ, જન્મ તારીખ
                  _buildResponsiveRow([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("સંબંધ *", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                        const SizedBox(height: 6),
                        _buildCustomDropdown(
                          value: member['relation'],
                          items: ['પસંદ કરો', 'પતિ', 'પત્ની', 'પુત્ર', 'પુત્રી', 'પુત્રવધૂ', 'પૌત્ર', 'પૌત્રી', 'દાદા', 'દાદી', 'પિતા', 'માતા', 'ભાઈ', 'બહેન'],
                          onChanged: (v) {
                            member['relation'] = v!;
                            controller.familyMembers[reversedIndex] = Map<String, dynamic>.from(member);
                            if (isMarriedRelation(v)) member['maritalStatus'] = 'Married';
                            controller.familyMembers.refresh();
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("જન્મ તારીખ (DD-MM-YYYY)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(child: _buildTextField(label: "દિવસ", controller: member['dayController'])),
                            const SizedBox(width: 6),
                            Expanded(child: _buildTextField(label: "મહિનો", controller: member['monthController'])),
                            const SizedBox(width: 6),
                            Expanded(child: _buildTextField(label: "વર્ષ", controller: member['yearController'])),
                          ],
                        ),
                      ],
                    ),
                  ], context),

                  const SizedBox(height: 18),


                  // ➔ ROW 3: શિક્ષણ, વૈવાહિક સ્થિતિ, વ્યવસાય (Responsive ફિક્સ)
                  _buildResponsiveRow([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("શિક્ષણ *", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                        const SizedBox(height: 6),
                        _buildCustomDropdown(
                            value: member['education'],
                            items: ['Select Option', 'Under Graduate', 'Graduate', 'Post Graduate', 'Doctorate', 'Other'],
                            onChanged: (v) { member['education'] = v!; controller.familyMembers.refresh(); }
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("વૈવાહિક સ્થિતિ *", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                        const SizedBox(height: 6),
                        isMarriedRelation(member['relation'])
                            ? Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                            child: const Text("Status: Married")
                        )
                            : _buildCustomDropdown(
                            value: member['maritalStatus'],
                            items: ['Single', 'Married', 'Divorced', 'Widowed'],
                            onChanged: (v) { member['maritalStatus'] = v!; controller.familyMembers.refresh(); }
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("વ્યવસાય સ્થિતિ *", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                        const SizedBox(height: 6),
                        _buildCustomDropdown(
                            value: member['occupation'] ?? 'Select Option',
                            items: ['Select Option', 'Business', 'Job', 'Homemaker', 'Student', 'Retired'],
                            onChanged: (v) { member['occupation'] = v!; controller.familyMembers.refresh(); }
                        ),
                      ],
                    ),
                  ], context), // ➔ અહીં context પાસ કરવાનું ભૂલશો નહીં!

                  // વ્યવસાયનું નામ (જો હોય તો)
                  if (member['occupation'] == 'Business' || member['occupation'] == 'Job')
                    Padding(padding: const EdgeInsets.only(top: 16.0),
                        child: _buildTextField(label: member['occupation'] == 'Business'
                            ? "પેઢીનું નામ *" : "કંપનીનું નામ *", controller
                            : member['organizationNameController'])),


                  const SizedBox(height: 15),

                  // ➔ પિયર પક્ષ (માતા, પત્ની, પુત્રવધૂ માટે)
                  if (member['relation'] == 'માતા' ||
                      member['relation'] == 'પત્ની' ||
                      member['relation'] == 'દાદી' ||
                      member['relation'] == 'પુત્રવધૂ')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        Text(
                          "${member['relation']} ના પિયર પક્ષની વિગતો",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentDark,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildTextField(
                          label: "પિયરના પિતાનું પૂરું નામ *",
                          controller: member['maternalFatherController'],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                label: "પિયરના માતાનું નામ *", // ➔ આ તમારી ઈમેજ મુજબનું નામ છે
                                controller: member['maternalMotherController'], // controller name check કરી લેવું
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: _buildTextField(
                                label: "પિયરનું ગામ/શહેર *", // ➔ આ તમારી ઈમેજ મુજબનું નામ છે
                                controller: member['maternalVillageController'],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                ],
              ),
            );
          }),
        ],
      );
    });
  }

  // ==========================================
  // 🔹 Step 5: Verification (Data Summary Panel)
  // ==========================================
  Widget _buildVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Column(
            children: [
              Icon(Icons.fact_check_outlined, size: 60, color: AppColors.primary),
              SizedBox(height: 12),
              Text(
                "માહિતીની આખરી ચકાસણી",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.heading),
              ),
              SizedBox(height: 6),
              Text(
                "ફોર્મ સબમિટ કરતાં પહેલાં તમારી વિગતો એકવાર ધ્યાનથી ચકાસી લો ભાઈ.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.subtitle, fontSize: 13.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "➔ પ્રાથમિક અને અંગત વિગતો",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const Divider(height: 20, color: AppColors.divider),

              _buildReviewRow("સભ્યનું નામ:", "${controller.surnameController.text.trim()} ${controller.firstNameController.text.trim()} ${controller.fatherHusbandController.text.trim()}"),
              _buildReviewRow("માતાનું નામ:", controller.motherNameController.text.trim()),
              _buildReviewRow("મોબાઈલ નંબર:", "+91 ${controller.phoneController.text.trim()}"),
              _buildReviewRow("ઈમેલ આઈડી:", controller.emailController.text.trim().isEmpty ? "-" : controller.emailController.text.trim()),
              _buildReviewRow("ગોત્ર / કુળદેવી:", controller.gotraController.text.trim()),
              Obx(() => _buildReviewRow("લિંગ / સ્થિતિ:", "${controller.selectedGender.value} / ${controller.selectedMaritalStatus.value}")),
              _buildReviewRow("જન્મ તારીખ:", "${controller.birthDayController.text.trim()}-${controller.birthMonthController.text.trim()}-${controller.birthYearController.text.trim()}"),
              if(controller.selectedOccupation.value == 'Business' || controller.selectedOccupation.value == 'Job')
                _buildReviewRow(controller.selectedOccupation.value == 'Business' ? "પેઢીનું નામ:" : "કંપનીનું નામ:", controller.organizationNameController.text.trim()),
              _buildReviewRow("મૂળ વતન / શહેર:", "${controller.nativeVillageController.text.trim()} / ${controller.currentCityVillageController.text.trim()}"),
              _buildReviewRow("હાલનું સરનામું:", controller.currentAddressController.text.trim()),
              Obx(() => _buildReviewRow(
                "પરિવારના સભ્યો:",
                "${controller.familyMembers.length} સભ્યો ઉમેરેલ છે",
              ),),

              // ➔ અપડેટેડ લૂપ: ExpansionTile સાથે જેથી બધી ડિટેલ ખૂલી શકે
              Obx(() {
                if (controller.familyMembers.isEmpty) return const SizedBox.shrink();
                return Column(
                  children: controller.familyMembers.asMap().entries.map((entry) {
                    var member = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ExpansionTile(
                        collapsedBackgroundColor: AppColors.background,
                        backgroundColor: AppColors.background,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        leading: const Icon(Icons.person, color: AppColors.primary),
                        title: Text(
                          "${member['nameController'].text} (${member['relation']})",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildReviewRow("જન્મ તારીખ:", "${member['dayController'].text}-${member['monthController'].text}-${member['yearController'].text}"),
                                _buildReviewRow("મોબાઈલ:", member['phoneController'].text),
                                _buildReviewRow("શિક્ષણ:", member['education']),
                                _buildReviewRow("વ્યવસાય:", member['occupation']),
                                _buildReviewRow("વૈવાહિક સ્થિતિ:", member['maritalStatus']),
                                // ➔ પિયર પક્ષની વિગતો પણ અહીંયા જ આવી જશે!
                                if (member['maternalFatherController'].text.isNotEmpty) ...[
                                  const Divider(),
                                  _buildReviewRow("પિયર પિતા:", member['maternalFatherController'].text),
                                  _buildReviewRow("પિયર માતા:", member['maternalMotherController'].text),
                                  _buildReviewRow("પિયર ગામ:", member['maternalVillageController'].text),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              }),

              Obx(() {
                if (controller.selectedGender.value == 'Female' && controller.maternalFatherController.text.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      const Text(
                        "➔ પિયર પક્ષની વિગતો",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.accent),
                      ),
                      const Divider(height: 20, color: AppColors.divider),
                      _buildReviewRow("પિયરના પિતાનું પૂરું નામ:", controller.maternalFatherController.text.trim()),
                      _buildReviewRow("પિયરના માતાનું નામ:", controller.maternalMotherController.text.trim()),
                      _buildReviewRow("મોસાળનું સરનામું:", controller.maternalAddressController.text.trim()),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        ),
        const SizedBox(height: 25),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.success.withOpacity(0.2)),
          ),
          child: const Row(
            children: [
              Icon(Icons.lock_outline, color: AppColors.success, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "આ સામાજિક સેક્યોર ડેટાબેઝ છે, તમારી માહિતી ડિજિટલ એડમિન સિવાય કોઈ જગ્યાએ શેર કરવામાં નહીં આવે.",
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: AppColors.body),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.subtitle, fontSize: 13.5),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? "-" : value,
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.heading, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Obx(() {
      if (controller.isOldUser.value) {
        return const SizedBox.shrink();
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (controller.currentStep.value > 0)
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () => controller.previousStep(),
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text("પાછા જાઓ", style: TextStyle(fontWeight: FontWeight.bold)),
            )
          else
            const SizedBox(),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {
              if (controller.currentStep.value == 4) {
                controller.submitMemberToLiveSQL();
              } else {
                controller.nextStep();
              }
            },
            child: controller.isLoading.value
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.currentStep.value == 4 ? "ફોર્મ સબમિટ કરો" : "આગળ વધો",
                  style: const TextStyle(color: AppColors.whiteText, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16, color: AppColors.whiteText),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildTextField({required String label, required TextEditingController controller, String? prefix, IconData? icon, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: AppColors.body),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.subtitle),
        prefixText: prefix,
        suffixIcon: icon != null ? Icon(icon, color: AppColors.icon) : null,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.cardBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.cardBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
      ),
    );
  }
}
