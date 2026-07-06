import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/const.dart';
import '../../controllers/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/const.dart';
import '../../controllers/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/const.dart';
import '../../controllers/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/const.dart';
import '../../controllers/controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              vertical: isWeb ? 40 : 20,
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
                    padding: EdgeInsets.all(isWeb ? 40.0 : 20.0),
                    child: Obx(() => _buildStepContent(controller.currentStep.value)),
                  ),
                ),
                const SizedBox(height: 25),
                _buildNavigationButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 Custom Stepper Header Indicator Line
  // ==========================================
  Widget _buildStepperHeader(bool isWeb) {
    final steps = [
      {'icon': Icons.phone_android, 'label': 'મોબાઈલ વેરિફિકેશન'},
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

  // ==========================================
  // 🔹 Dynamic Step Content Switcher (FIXED INDEX)
  // ==========================================
  Widget _buildStepContent(int step) {
    switch (step) {
      case 0: return _buildMobileStep();
      case 1: return _buildPrimaryInfoStep();
      case 2: return _buildPersonalDetailsStep();
      case 3: return _buildFamilyStep();
      case 4: return _buildVerificationStep(); // ⚡ FIX: Changed from case 5 to case 4 to match total steps
      default: return const SizedBox();
    }
  }

  Widget _buildMobileStep() {
    return Column(
      children: [
        const Icon(Icons.phone_iphone, size: 70, color: AppColors.iconAccent),
        const SizedBox(height: 16),
        const Text("મોબાઈલ ચકાસણી", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.heading)),
        const SizedBox(height: 8),
        const Text("નોંધણી શરૂ કરવા માટે તમારો ૧૦ અંકનો મોબાઈલ નંબર દાખલ કરો.", textAlign: TextAlign.center, style: TextStyle(color: AppColors.body)),
        const SizedBox(height: 30),
        _buildTextField(label: "મોબાઈલ નંબર", controller: controller.phoneController, prefix: "+91 "),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonPrimary,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => controller.nextStep(),
          child: const Text("OTP મોકલો", style: TextStyle(color: AppColors.whiteText, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }

  // ==========================================
  // 🔹 Step 2: Primary Info
  // ==========================================
  Widget _buildPrimaryInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("પ્રાથમિક માહિતી", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
        const SizedBox(height: 4),
        const Text("તમારું નામ અને સરનામું દાખલ કરો", style: TextStyle(fontSize: 13, color: AppColors.subtitle)),
        const Divider(height: 30, color: AppColors.divider),

        Row(
          children: [
            Expanded(child: _buildTextField(label: "પૂરું નામ (તમારું નામ) *", controller: controller.firstNameController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "પિતા/પતિનું નામ *", controller: controller.fatherHusbandController)),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: _buildTextField(label: "માતાનું નામ *", controller: controller.motherNameController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "અટક *", controller: controller.surnameController)),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("લિંગ *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                  const SizedBox(height: 6),
                  Obx(() => _buildCustomDropdown(
                    value: controller.selectedGender.value,
                    items: const ['Male', 'Female', 'Other'],
                    onChanged: (newValue) => controller.selectedGender.value = newValue!,
                  )),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("ગોત્ર *", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                  const SizedBox(height: 6),
                  Obx(() {
                    if (controller.isGotrasLoading.value) {
                      return const SizedBox(height: 45, child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: controller.selectedGotraId.value,
                          isExpanded: true,
                          dropdownColor: AppColors.card,
                          style: const TextStyle(color: AppColors.body, fontSize: 14),
                          items: controller.gotrasList.map((gotra) {
                            return DropdownMenuItem<String>(
                              value: gotra['id'].toString(),
                              child: Text(gotra['gotra_name'].toString()),
                            );
                          }).toList(),
                          onChanged: (value) { if (value != null) controller.selectedGotraId.value = value; },
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),

        const Divider(height: 40, color: AppColors.divider),
        _buildTextField(label: "હાલનું પૂરું સરનામું *", controller: controller.currentAddressController, maxLines: 2),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: _buildTextField(label: "જિલ્લો *", controller: controller.currentDistrictController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "તાલુકો *", controller: controller.currentTalukaController)),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: _buildTextField(label: "ગામ/શહેર *", controller: controller.currentCityVillageController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "પીનકોડ *", controller: controller.pincodeController)),
          ],
        ),

        // ⚡ Live Maternal/Piyar Fields directly embedded inside Step 2 for Females
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
                _buildTextField(label: "પિયરના પિતાનું નામ *", controller: controller.maternalFatherController),
                const SizedBox(height: 16),
                _buildTextField(label: "માતાનું નામ *", controller: controller.maternalMotherController),
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

  // ==========================================
  // 🔹 Step 3: Personal Details
  // ==========================================
  Widget _buildPersonalDetailsStep() {
    final isWeb = MediaQuery.of(Get.context!).size.width > 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("અંગત વિગતો", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
        const Divider(height: 30, color: AppColors.divider),

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
        const SizedBox(height: 20),

        Obx(() => Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary.withOpacity(0.15)),
          ),
          child: SwitchListTile(
            activeColor: AppColors.primary,
            title: const Text("તમે પરિવારના પરણિત દીકરા છો? (Separate Card)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.heading)),
            subtitle: const Text("આ ઓપ્શન ઓન કરવાથી બેકએન્ડમાં તમારું નવું કૌટુંબિક કાર્ડ જનરેટ થશે જે પિતાના કાર્ડ સાથે જોડાયેલું રહેશે.", style: TextStyle(fontSize: 12, color: AppColors.subtitle)),
            value: controller.isMarriedSon.value,
            onChanged: (bool value) => controller.isMarriedSon.value = value,
          ),
        )),

        const SizedBox(height: 20),
        _buildTextField(label: "મોસાળ પક્ષની વિગત / એડ્રેસ", controller: controller.maternalAddressController, maxLines: 2),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: _buildTextField(label: "મામાની અટક", controller: controller.maternalSurnameController)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(label: "મોસાળનું ગામ", controller: controller.maternalVillageController)),
          ],
        ),

        const SizedBox(height: 35),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDE7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("પરિવારના સભ્યો", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.heading)),
              const SizedBox(height: 6),
              const Text("તમારા સિવાય ઘરમાં રહેતા અન્ય સભ્યોની સંખ્યા દાખલ કરો.", style: TextStyle(fontSize: 13.5, color: Colors.black54)),
              const SizedBox(height: 20),
              Text("સભ્યોની સંખ્યા", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.imageIconGrey)),
              const SizedBox(height: 8),

              SizedBox(
                width: isWeb ? 350 : double.infinity,
                child: Obx(() => TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.body, fontWeight: FontWeight.w600),
                  controller: TextEditingController(
                      text: controller.familyCount.value == 0 ? '' : controller.familyCount.value.toString()
                  )..selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.familyCount.value == 0 ? 0 : controller.familyCount.value.toString().length)
                  ),
                  decoration: InputDecoration(
                    hintText: "0",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.cardBorder)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.cardBorder)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
                  ),
                  onChanged: (value) {
                    int count = int.tryParse(value) ?? 0;
                    controller.updateFamilyCount(count);
                  },
                )),
              ),
            ],
          ),
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

  Widget _buildFamilyStep() {
    return Obx(() {
      final int memberCount = controller.familyCount.value;

      if (memberCount == 0) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Icon(Icons.family_restroom_rounded, size: 50, color: AppColors.subtitle),
                SizedBox(height: 12),
                Text(
                  "કોઈ સભ્ય સંખ્યા દાખલ કરેલ નથી.\nકૃપા કરીને પાછલા સ્ટેપમાં પરિવારના સભ્યોની સંખ્યા ઉમેરો ભાઈ.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.subtitle, height: 1.4, fontSize: 14),
                ),
              ],
            ),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("પરિવારની વિગતો", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
          const SizedBox(height: 4),
          Text("$memberCount સભ્યોની માહિતી ભરો", style: const TextStyle(fontSize: 13, color: AppColors.subtitle)),
          const Divider(height: 30, color: AppColors.divider),

          ...List.generate(memberCount, (index) {
            final sNo = index + 1;
            var member = controller.familyMembers[index];

            return Container(
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
                  Text("સભ્ય $sNo", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: AppColors.heading)),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("પૂરું નામ *", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                            const SizedBox(height: 6),
                            _buildTextField(label: "પૂરું નામ દાખલ કરો", controller: member['nameController']),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("સંબંધ *", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.subtitle)),
                            const SizedBox(height: 6),
                            _buildCustomDropdown(
                              value: member['relation'],
                              items: const ['પસંદ કરો', 'પતિ', 'પત્ની', 'પુત્ર', 'પુત્રી', 'પિતા', 'માતા', 'ભાઈ', 'બહેન', 'દાદા', 'દાદી'],
                              onChanged: (v) {
                                member['relation'] = v!;
                                controller.familyMembers.refresh();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 4,
                        child: _buildTextField(label: "મોબાઈલ નંબર", controller: member['phoneController']),
                      ),
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

        // ⚡ LIVE DATA REVIEW SUMMARY CARD PANEL
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

              Obx(() {
                final gotraMatch = controller.gotrasList.firstWhere(
                      (g) => g['id'].toString() == controller.selectedGotraId.value,
                  orElse: () => {'gotra_name': 'Kashyap'},
                );
                return _buildReviewRow("ગોત્ર / કુળદેવી:", "${gotraMatch['gotra_name']} (${gotraMatch['kuldevi_name'] ?? 'Mataji'})");
              }),

              Obx(() => _buildReviewRow("લિંગ / સ્થિતિ:", "${controller.selectedGender.value} / ${controller.selectedMaritalStatus.value}")),
              _buildReviewRow("જન્મ તારીખ:", "${controller.birthDayController.text.trim()}-${controller.birthMonthController.text.trim()}-${controller.birthYearController.text.trim()}"),
              _buildReviewRow("મૂળ વતન / શહેર:", "${controller.nativeVillageController.text.trim()} / ${controller.currentCityVillageController.text.trim()}"),
              _buildReviewRow("હાલનુંં સરનામું:", controller.currentAddressController.text.trim()),
              Obx(() => _buildReviewRow("પરિવારના સભ્યો:", "${controller.familyCount.value} સભ્યો ઉમેરેલ છે")),

              // Dynamic Maternal review layout automatically populated if Gender == Female
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
                      _buildReviewRow("પિયરના પિતાનું નામ:", controller.maternalFatherController.text.trim()),
                      _buildReviewRow("માતાનું નામ:", controller.maternalMotherController.text.trim()),
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
                  "આ સામાજિક સેક્યોર ડેટાબેઝ છે, તમારી માહિતી ડિજિટલ એડમિન સિવાય કોઈ જગ્યાએ શેર કરવામાં નહીં આવે ભાઈ.",
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

  // ==========================================
  // 🔹 Navigation Control Action Buttons (FIXED VALUES)
  // ==========================================
  Widget _buildNavigationButtons() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (controller.currentStep.value > 0)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () => controller.previousStep(),
            child: const Text("➔ પાછા જાઓ", style: TextStyle(fontWeight: FontWeight.bold)),
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
            if (controller.currentStep.value == 4) { // ⚡ FIX: Adjusted execution trigger checkpoint from 5 to 4
              controller.submitMemberToLiveSQL();
            } else {
              controller.nextStep();
            }
          },
          child: Obx(() => controller.isLoading.value
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
          )
              : Text(
            controller.currentStep.value == 4 ? "ફોર્મ સબમિટ કરો ➔" : "આગળ વધો ➔", // ⚡ FIX: Changed condition from 5 to 4
            style: const TextStyle(color: AppColors.whiteText, fontWeight: FontWeight.bold),
          ),
          ),
        ),
      ],
    ));
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
