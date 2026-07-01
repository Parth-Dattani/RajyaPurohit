import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/contact_controller.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: AppColors.background, // ✅ અપડેટેડ: ગ્લોબલ સરફેસ
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildContactHeaderBanner(isWeb),
            _buildContactTitleSection(isWeb, screenWidth),
            _buildContactDetailsSection(isWeb, screenWidth),
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
      height: isWeb ? 300 : 200,
      decoration: const BoxDecoration(
        color: AppColors.primary, // ✅ અપડેટેડ: ડાર્ક બ્રાન્ડ કલર
        image: DecorationImage(
          image: AssetImage('assets/images/contact_bg.jpg'),
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'સંપર્ક',
            style:  TextStyle(fontSize: isWeb ? 54 : 36, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'હોમ',
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14, fontWeight: FontWeight.w500),
                ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('/', style: TextStyle(color: AppColors.accent, fontSize: 14)), // ✅ અપડેટેડ
              ),
              Text(
                'સંપર્ક',
                style:  const TextStyle(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.bold), // ✅ અપડેટે
              ),
            ],
          )
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૨. CONTACT TITLE SECTION
  // ==========================================
  Widget _buildContactTitleSection(bool isWeb, double screenWidth) {
    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.015), // સોફ્ટ લાઈટ ટોન માટે
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 24.0,
        vertical: 60.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'સંપર્ક કરો',
            style:  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.accent, letterSpacing: 0.5), // ✅ અપડેટેડ
            ),

          const SizedBox(height: 16),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: isWeb ? 44 : 28, fontWeight: FontWeight.w900, height: 1.3
                ),
                children: const [
                  TextSpan(text: 'અમારા નિષ્ણાતો સાથે સંપર્ક કરો\n', style: TextStyle(color: AppColors.accent)), // ✅ અપડેટેડ
                  TextSpan(text: 'સાથે મળીને કામ શરૂ કરવા માટે', style: TextStyle(color: AppColors.heading)), // ✅ અપડેટેડ
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૩. CONTACT DETAILS SECTION (કોમ્પેક્ટ સાઈઝ વર્ઝન)
  // ==========================================
  Widget _buildContactDetailsSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 20.0,
      vertical: 30.0,
    );

    final detailCards = [
      _buildDetailCard(
        bgColor: AppColors.buttonSecondary, // ✅ અપડેટેડ: ગોલ્ડન / પીળો શેડ
        icon: Icons.star_border_rounded,
        iconColor: AppColors.primary, // ✅ અપડેટેડ
        title: 'પ્રતિસાદ',
        subtitle: 'અમારી મિત્રતાપૂર્ણ ટીમ સાથે વાત કરો.',
        content: 'info@rajyapurohitonline.in',
        textColor: AppColors.heading, // ✅ અપડેટેડ
        subTextColor: AppColors.heading.withOpacity(0.7), // ✅ અપડેટેડ
      ),
      _buildDetailCard(
        bgColor: Colors.black.withOpacity(0.03), // સોફ્ટ લાઈટ ગ્રે/ક્રીમ ટોન
        icon: Icons.phone_in_talk_outlined,
        iconColor: AppColors.accent, // ✅ અપડેટેડ
        title: 'ફોન કરો',
        subtitle: 'સોમ-શનિ: સવારે ૧૦ થી સાંજે ૬',
        content: '(૦૨૮૮) ૨૬૬૬૮૨૬',
        textColor: AppColors.heading, // ✅ અપડેટેડ
        subTextColor: AppColors.body.withOpacity(0.7), // ✅ અપડેટેડ
      ),
      _buildDetailCard(
        bgColor: AppColors.primary, // ✅ અપડેટેડ: ડાર્ક સેક્શન બ્લુ
        icon: Icons.location_on_outlined,
        iconColor: AppColors.accent, // ✅ અપડેટેડ
        title: 'મુલાકાત લો',
        subtitle: 'અમારા કાર્યાલયે આવો.',
        content: 'ગુજરાત રાજયગોર સમાજ\nમહાજન વાડી, પંચેશ્વર ટાવર,\nજામનગર - ૩૬૧૦૦૧. ગુજરાત. ભારત.',
        textColor: Colors.white,
        subTextColor: AppColors.footerText.withOpacity(0.8), // ✅ અપડેટેડ
        isAddress: true,
      ),
      _buildActionCard(),
    ];

    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.015),
      padding: padding,
      child: isWeb
          ? SizedBox(
        height: 320,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: detailCards.map((card) => Expanded(child: card)).toList(),
        ),
      )
          : Column(
        children: detailCards
            .map((card) => Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: SizedBox(width: double.infinity, child: card),
        ))
            .toList(),
      ),
    );
  }

  Widget _buildDetailCard({
    required Color bgColor,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String content,
    required Color textColor,
    required Color subTextColor,
    bool isAddress = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: iconColor),
          const SizedBox(height: 15),
          Text(
            title,
            style:  TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: textColor),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style:  TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: subTextColor)
          ),
          const SizedBox(height: 15),
          Expanded(
            child: Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: isAddress ? 12 : 14.5,
                    fontWeight: isAddress ? FontWeight.w500 : FontWeight.bold,
                    color: isAddress ? subTextColor : AppColors.accent, // ✅ અપડેટેડ
                    height: 1.4,
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }

  Widget _buildActionCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      decoration: const BoxDecoration(
        color: AppColors.accent, // ✅ અપડેટેડ: એક્સેન્ટ બેકગ્રાઉન્ડ
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ગુજરાત રાજયગોર\nસમાજની ઈ-મેમ્બરશીપ\nજોડાઓ',
            textAlign: TextAlign.center,
            style:  const TextStyle(fontSize: 16.5, fontWeight: FontWeight.w900, color: Colors.white, height: 1.3)
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonPrimary, // ✅ અપડેટેડ: ડાર્ક પ્રાઈમરી બટન
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () {
                Get.toNamed('/MembershipScreen');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'સભ્યતા જોડાઓ ',
                    style:const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 13), // ✅ અપડેટેડ
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 🔹 ૪. MAP AND FORM SECTION
  // ==========================================
  Widget _buildMapAndFormSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 20.0,
      vertical: 60.0,
    );

    final mapWidget = Container(
      height: isWeb ? 680 : 350,
      decoration: BoxDecoration(
        color: AppColors.cardBorder, // ✅ અપડેટેડ
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: AppColors.cardBorder.withOpacity(0.4), // ✅ અપડેટેડ
              alignment: Alignment.center,
              child: const Icon(Icons.map_outlined, size: 80, color: Colors.black26),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 250,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rajyapurohit Jamnagar',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.heading) // ✅ અપડેટેડ
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'રાજયગોર સમાજ વાડી,\nરાજ્યગોર કુંજી શેરી નં. ૨, જામનગર - ૩૬૧૦૦૧, ગુજરાત રાજ્ય.',
                    style: TextStyle(fontSize: 12, color: AppColors.body, height: 1.4)
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    final formWidget = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Send a Message ',
                style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading)), // ✅ અપડેટેડ
              ),
              const Icon(Icons.thumb_up_alt_outlined, size: 20, color: AppColors.accent), // ✅ અપડેટેડ
            ],
          ),
          const SizedBox(height: 30),
          if (isWeb)
            Row(
              children: [
                Expanded(child: _buildFormTextField('Your Name', _nameController)),
                const SizedBox(width: 20),
                Expanded(child: _buildFormTextField('Your Email', _emailController)),
              ],
            )
          else ...[
            _buildFormTextField('Your Name', _nameController),
            const SizedBox(height: 16),
            _buildFormTextField('Your Email', _emailController),
          ],
          const SizedBox(height: 16),
          if (isWeb)
            Row(
              children: [
                Expanded(child: _buildFormTextField('City', _cityController)),
                const SizedBox(width: 20),
                Expanded(child: _buildFormTextField('Mobile Number', _phoneController, isNumber: true)),
              ],
            )
          else ...[
            _buildFormTextField('City', _cityController),
            const SizedBox(height: 16),
            _buildFormTextField('Mobile Number', _phoneController, isNumber: true),
          ],
          const SizedBox(height: 16),
          _buildFormTextField('Subject', _subjectController),
          const SizedBox(height: 16),
          _buildFormTextField('Your Message', _messageController, maxLines: 5),
          const SizedBox(height: 35),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent, // ✅ અપડેટેડ
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ફોર્મ સબમિટ લોજિક
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SEND MESSAGE ',
                    style: GoogleFonts.poppins(textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                ],
              ),
            ),
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

  Widget _buildFormTextField(String label, TextEditingController controller, {int maxLines = 1, bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.heading)), // ✅ અપડેટેડ
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 14, color: AppColors.heading, fontWeight: FontWeight.w500)), // ✅ અપડેટેડ
          decoration: InputDecoration(
            hintText: label,
            filled: true,
            fillColor: AppColors.background.withOpacity(0.5), // ✅ અપડેટેડ
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: AppColors.cardBorder.withOpacity(0.3)), // ✅ અપડેટેડ
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.accent, width: 1), // ✅ અપડેટેડ
            ),
          ),
        ),
      ],
    );
  }
}