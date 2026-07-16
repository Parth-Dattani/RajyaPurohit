import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/contact_controller.dart';
import '../widgets/widgets.dart';
import '../widgets/custom_app_bar.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import '../controllers/contact_controller.dart'; // તમારો સાચો કંટ્રોલર પાથ ભાઈ
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import '../controllers/contact_controller.dart'; // તમારો કંટ્રોલર પાથ ભાઈ
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

class ContactScreen extends GetView<ContactController> {
  static const pageId = "/ContactScreen";
  const ContactScreen({super.key});

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _cityController = TextEditingController();
  static final TextEditingController _phoneController = TextEditingController();
  static final TextEditingController _subjectController = TextEditingController();
  static final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildContactHeaderBanner(isWeb),
           // _buildContactDetailsSection(isWeb, screenWidth),
            _buildMapAndFormSection(isWeb, screenWidth),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૧. CONTACT HEADER BANNER
  // ==========================================
  Widget _buildContactHeaderBanner(bool isWeb) {
    return Container(
      width: double.infinity,
      height: isWeb ? 75 : 60,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        image: DecorationImage(
          image: AssetImage('assets/images/team_bg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          'સંપર્ક',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'NotoSansGujarati', // ➔ ⚡ લોકલ ફોન્ટ એક્ટિવ ભાઈ
            fontSize: isWeb ? 34 : 26,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 0.5,
            height: 1.0,
          ),
        ),
      ),
    );
  }


  // ==========================================
  // 🔹 ૩. MAP AND FORM SECTION
  // ==========================================
  Widget _buildMapAndFormSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 20.0,
      vertical: 60.0,
    );

    const String mapTag = "google-maps-jamnagar";

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(mapTag, (int viewId) {
      return html.IFrameElement()
        ..src = 'https://www.google.com/maps/embed?pb=!1m13!1m8!1m3!1d3686.993510531557!2d70.0737843!3d22.4668749!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMjLCsDI4JzAwLjciTiA3MMKwMDQnMjUuNiJF!5e0!3m2!1sgu!2sin!4v1719945000000!5m2!1sgu!2sin'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%';
    });

    final mapWidget = Container(
      height: isWeb ? 680 : 350,
      decoration: BoxDecoration(
        color: AppColors.cardBorder,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const HtmlElementView(viewType: mapTag),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: Container(
                width: 260,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Rajyapurohit Jamnagar',
                      style: const TextStyle(fontFamily: 'NotoSansGujarati', fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.heading),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'જામનગર રાજ્યગોર જ્ઞાતિ બ્રહ્મપુરી,\nરાજ્યગોર ફળી શેરી નં. ૧, \nજામનગર - ૩૬૧૦૦૧. ગુજરાત.',
                      style: TextStyle(fontFamily: 'NotoSansGujarati', fontSize: 12, color: AppColors.body, height: 1.45),
                    ),
                    const SizedBox(height: 14),
                    const Divider(height: 1, color: AppColors.cardBorder),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.open_in_new_rounded, size: 14, color: AppColors.accent),
                        const SizedBox(width: 6),
                        Text(
                          'Open in Maps',
                          style: TextStyle(
                            fontFamily: 'NotoSansGujarati',
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 142,
            right: 36,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: () {
                  html.window.open(
                    'https://www.google.com/maps/place/22%C2%B028\'00.8%22N+70%C2%B004\'34.9%22E/@22.4668749,70.0737843,17z/',
                    '_blank',
                  );
                },
                child: Container(
                  width: 130,
                  height: 32,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final formWidget = Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Send a Message ',
                style: TextStyle(fontFamily: 'NotoSansGujarati', fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading),
              ),
              const Icon(Icons.thumb_up_alt_outlined, size: 20, color: AppColors.accent),
            ],
          ),
          const SizedBox(height: 30),
          if (isWeb)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildFormTextField('Your Name', _nameController, fieldType: 'name')),
                const SizedBox(width: 20),
                Expanded(child: _buildFormTextField('Your Email', _emailController, fieldType: 'email')),
              ],
            )
          else ...[
            _buildFormTextField('Your Name', _nameController, fieldType: 'name'),
            const SizedBox(height: 16),
            _buildFormTextField('Your Email', _emailController, fieldType: 'email'),
          ],
          const SizedBox(height: 16),
          if (isWeb)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildFormTextField('City', _cityController, fieldType: 'city')),
                const SizedBox(width: 20),
                Expanded(child: _buildFormTextField('Mobile Number', _phoneController, isNumber: true, fieldType: 'mobile')),
              ],
            )
          else ...[
            _buildFormTextField('City', _cityController, fieldType: 'city'),
            const SizedBox(height: 16),
            _buildFormTextField('Mobile Number', _phoneController, isNumber: true, fieldType: 'mobile'),
          ],
          const SizedBox(height: 16),
          _buildFormTextField('Subject', _subjectController, fieldType: 'subject'),
          const SizedBox(height: 16),
          _buildFormTextField('Your Message', _messageController, maxLines: 5, fieldType: 'message'),
          const SizedBox(height: 35),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: Obx(() => ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                if (_formKey.currentState!.validate()) {
                  controller.submitContactForm(
                    name: _nameController.text.trim(),
                    email: _emailController.text.trim(),
                    city: _cityController.text.trim(),
                    mobile: _phoneController.text.trim(),
                    subject: _subjectController.text.trim(),
                    message: _messageController.text.trim(),
                    onSuccess: () {
                      _formKey.currentState!.reset();
                      _nameController.clear();
                      _emailController.clear();
                      _cityController.clear();
                      _phoneController.clear();
                      _subjectController.clear();
                      _messageController.clear();
                    },
                  );
                }
              },
              child: controller.isLoading.value
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SEND MESSAGE ',
                    style: TextStyle(fontFamily: 'NotoSansGujarati', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                ],
              ),
            )),
          ),
        ],
      ),
    );

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: padding,
      child: isWeb
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 10, child: mapWidget),
          const SizedBox(width: 50),
          Expanded(flex: 10, child: formWidget),
        ],
      )
          : Column(
        children: [
          formWidget,
          const SizedBox(height: 50),
          mapWidget,
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ટેક્સ્ટ ફીલ્ડ બોક્સ મોડ્યુલ (લોકલ Noto Sans ફોન્ટ સાથે ભાઈ)
  // ==========================================
  Widget _buildFormTextField(String label, TextEditingController controller, {int maxLines = 1, bool isNumber = false, required String fieldType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'NotoSansGujarati', fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.heading),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          style: TextStyle(fontFamily: 'NotoSansGujarati', fontSize: 14, color: AppColors.heading, fontWeight: FontWeight.w500),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your $fieldType';
            }
            if (fieldType == 'email') {
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value.trim())) {
                return 'Please enter a valid email address';
              }
            }
            if (fieldType == 'mobile') {
              if (value.trim().length < 10) {
                return 'Mobile number must be at least 10 digits';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: label,
            filled: true,
            fillColor: AppColors.background.withOpacity(0.5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            errorStyle: const TextStyle(fontFamily: 'NotoSansGujarati', fontSize: 11, fontWeight: FontWeight.w500, color: Colors.redAccent),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 30),
              borderSide: BorderSide(color: AppColors.cardBorder.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 30),
              borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 30),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(maxLines > 1 ? 16 : 30),
              borderSide: const BorderSide(color: Colors.red, width: 1.8),
            ),
          ),
        ),
      ],
    );
  }
}