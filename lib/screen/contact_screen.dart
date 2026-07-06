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
      // ⚡ સેન્ટર લોજિક: ગુજરાતી ફોન્ટના કારણે જે નીચે નમતું હતું, એને લાઈન હાઈટથી પ્રોપર વચોવચ ખેંચી લીધું ભાઈ
      child: Padding(
        padding: const EdgeInsets.only(top: 4), // જો હજુ સહેજ નીચે લાગતું હોય તો આ બોટમ પેડિંગ ૨ થી ૪ પિક્સલ કરી લેવી ભાઈ
        child: Text(
          'સંપર્ક',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isWeb ? 34 : 26, // હાઈટ નાની હોવાથી ફોન્ટ સાઈઝ સહેજ બેલેન્સ કરી ભાઈ જેથી વધુ ભીંસ ન લાગે
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
            height: 1.0, // ➔ ⚡ મેઈન ફિક્સ: લાઈન હાઈટ ફિક્સ કરવાથી ઊભી લાઈનમાં ટકાટક સેન્ટર થઈ જશે!
          ),
        ),
      ),
    );
  }

// ==========================================
// 🔹 ૩. CONTACT DETAILS SECTION (કોમ્પેક્ટ સાઈઝ વર્ઝન - પ્રોફેસનલ ફિક્સ ભાઈ)
// ==========================================
  Widget _buildContactDetailsSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.05 : 16.0,
      vertical: 30.0,
    );

    final detailCards = [
      // ➔ ⚡ ૧. પહેલું કાર્ડ: પાછું ઓરિજિનલ સોફ્ટ ગ્રે લુકમાં સેટ કર્યું ભાઈ!
      _buildDetailCard(
        bgColor: Colors.black.withOpacity(0.03),
        icon: Icons.phone_in_talk_outlined,
        iconColor: AppColors.accent,
        title: 'ફોન કરો',
        subtitle: 'સોમ-શનિ: સવારે ૧૦ થી ૧\nઅને સાંજે ૪ થી ૭',
        content: '(૦૨૮૮) ૨૬૬૬૮૨૬',
        textColor: AppColors.heading,
        subTextColor: AppColors.body.withOpacity(0.7),
        contentColor: AppColors.accent,
      ),
      // ૨. બીજું કાર્ડ: ક્લીન મોર્ડન બ્લુ લુક ભાઈ
      _buildDetailCard(
        bgColor: AppColors.primary,
        icon: Icons.location_on_outlined,
        iconColor: AppColors.accent,
        title: 'મુલાકાત લો',
        subtitle: '',
        content: 'જામનગર રાજ્યગોર જ્ઞાતિ બ્રહ્મપુરી,\nરાજ્યગોર ફળી શેરી નં. ૧,\nજામનગર - ૩૬૧૦૦૧. ગુજરાત.',
        textColor: Colors.white,
        subTextColor: AppColors.footerText.withOpacity(0.8),
        contentColor: AppColors.footerText.withOpacity(0.8),
        isAddress: true,
      ),
      // ➔ ⚡ ૩. ત્રીજું કાર્ડ: પાછું ઓરિજિનલ પ્યોર કલર્ડ ગોલ્ડન (Accent) થીમ વાળું એક્ટિવ ભાઈ!
      _buildActionCard(),
    ];

    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.015),
      padding: padding,
      child: isWeb
          ? Center(
        child: SizedBox(
          width: 1100,
          height: 260,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: detailCards.map((card) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: card,
              ),
            )).toList(),
          ),
        ),
      )
          : Column(
        children: detailCards
            .map((card) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
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
    required Color contentColor,
    bool isAddress = false,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: (bgColor == AppColors.primary || bgColor == AppColors.accent)
            ? null
            : Border.all(color: AppColors.cardBorder.withOpacity(0.4), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: iconColor),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: textColor),
          ),
          if (subtitle.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500, color: subTextColor, height: 1.3)
            ),
          ],
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isAddress ? 12 : 15,
                fontWeight: isAddress ? FontWeight.w500 : FontWeight.bold,
                color: contentColor,
                height: 1.4,
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: AppColors.accent, // ➔ ⚡ પાછું આખું કાર્ડ ગોલ્ડન (Accent) કલર્ડ કરી દીધું ભાઈ!
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              'ગુજરાત રાજયગોર સમાજની\nઈ-મેમ્બરશીપ જોડાઓ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white, height: 1.3)
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 180,
            height: 42,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonPrimary, // ➔ ⚡ બટન પાછું ડાર્ક કલરનું લોક કર્યું ભાઈ
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                Get.toNamed('/MembershipScreen');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'સભ્યતા જોડાઓ ',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.5)
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 13),
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

    // ➔ ⚡ ગૂગલ મેપ આઈફ્રેમ રજીસ્ટ્રેશન આઈડીયા ભાઈ (યુનિક કી સાથે)
    const String mapTag = "google-maps-jamnagar";

    // ફ્લટર વેબના એન્જિનમાં આઈફ્રેમને એકવાર રજીસ્ટર કરી દઈએ ભાઈ
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(mapTag, (int viewId) {
      return html.IFrameElement()
        ..src = 'https://www.google.com/maps/embed?pb=!1m13!1m8!1m3!1d3686.993510531557!2d70.0737843!3d22.4668749!3m2!1i1024!2i768!4f13.1!3m2!1m1!2zMjLCsDI4JzAwLjciTiA3MMKwMDQnMjUuNiJF!5e0!3m2!1sgu!2sin!4v1719945000000!5m2!1sgu!2sin' // ⚡ ગૂગલ મેપ્સની અસલી લોકેશન આઈફ્રેમ લિંક ભાઈ
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
          // ➔ ૧. લાઈવ ગૂગલ મેપ વ્યુ ભાઈ
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const HtmlElementView(viewType: mapTag),
            ),
          ),

          // ➔ ૨. 📍 એડ્રેસ કાર્ડ બોક્સ (⚡ હવે જમણી બાજુ શિફ્ટ કર્યું ભાઈ)
          Positioned(
            top: 20,
            right: 20, // ⚡ ડાબી બાજુથી હટાવીને જમણી બાજુ ટકાટક ગોઠવ્યું ભાઈ
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
                        offset: const Offset(0, 4)
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Rajyapurohit Jamnagar',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.heading)
                    ),
                    const SizedBox(height: 6),
                    Text(
                        'જામનગર રાજ્યગોર જ્ઞાતિ બ્રહ્મપુરી,\nરાજ્યગોર ફળી શેરી નં. ૧, \nજામનગર - ૩૬૧૦૦૧. ગુજરાત.',
                        style: TextStyle(fontSize: 12, color: AppColors.body, height: 1.45)
                    ),

                    const SizedBox(height: 14),
                    const Divider(height: 1, color: AppColors.cardBorder),
                    const SizedBox(height: 10),

                    // લુક માટેની લિંક ભાઈ
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.open_in_new_rounded, size: 14, color: AppColors.accent),
                        const SizedBox(width: 6),
                        Text(
                          'Open in Maps',
                          style: TextStyle(
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

          // ➔ ૩. ⚡ જાદુઈ ફિક્સ: "Open in Maps" ની બરાબર ઉપર અદ્રશ્ય વેબ ઓવરલે (જમણી બાજુના માપ પ્રમાણે ભાઈ)
          Positioned(
            top: 142,
            right: 36, // ⚡ આને પણ જમણી બાજુના એડ્રેસ કાર્ડની લિંક ઉપર બરાબર લોક કર્યું ભાઈ!
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
                  color: Colors.transparent, // અદ્રશ્ય ક્લિક લેયર ભાઈ
                ),
              ),
            ),
          ),
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
                style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading)),
              ),
              const Icon(Icons.thumb_up_alt_outlined, size: 20, color: AppColors.accent),
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
                backgroundColor: AppColors.accent,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // ફોર્મ સબમિટ લોજિક ભાઈ
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
