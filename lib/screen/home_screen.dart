import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../constant/app_colors.dart';
import '../widgets/widgets.dart'; // ✅ ગ્લોબલ કલર્સ ફાઈલ ઈમ્પોર્ટ કરી

class HomeScreen extends GetView<HomeController> {
  static const pageId = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgCream, // ✅ ગ્લોબલ કલર યુઝ કર્યો
      appBar: _buildAppBar(isWeb),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(isWeb),       // ================== SECTION 1 ==================
            _buildSolutionsSection(isWeb, screenWidth), // ================== SECTION 2 ==================
            _buildMissionSection(isWeb),
            _buildStepsSection(isWeb, screenWidth),
            _buildFaqSection(isWeb, screenWidth),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // APP BAR MODULE
  // ==========================================
  PreferredSizeWidget _buildAppBar(bool isWeb) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      title: Text(
        'RAJYAPUROHITONLINE.IN',
        style: GoogleFonts.cinzel(
          textStyle: const TextStyle(
            color: AppColors.textOrange, // ✅ ગ્લોબલ કલર
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      actions: isWeb
          ? [
        _buildHeaderMenu('હોમ'),
        _buildHeaderMenu('અમારા વિષે'),
        _buildHeaderMenu('મેમ્બરશીપ'),
        _buildHeaderMenu('અમારી ટીમ'),
        _buildHeaderMenu('સંપર્ક'),
        const SizedBox(width: 20),
      ]
          : null,
    );
  }

  Widget _buildHeaderMenu(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: GestureDetector(
          onTap: () => controller.changeMenu(title),
          child: Obx(() => Text(
            title,
            style: TextStyle(
              color: controller.selectedMenu.value == title
                  ? AppColors.textOrange  // ✅ ગ્લોબલ કલર
                  : AppColors.textMaroon, // ✅ ગ્લોબલ કલર
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          )),
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 1: HERO SECTION MODULE
  // ==========================================
  Widget _buildHeroSection(bool isWeb) {
    return Container(
      color: AppColors.bgCream,
      child: isWeb ? _buildHeroWebLayout() : _buildHeroMobileLayout(),
    );
  }

  Widget _buildHeroWebLayout() {
    return Container(
      // ✅ મોટી સ્ક્રીન પર લાઈનિંગ ખરાબ ન થાય એટલે લિમિટેડ મિનિમમ હાઇટ સેટ કરી (No Text Drop)
      constraints: const BoxConstraints(
        minHeight: 650,
        maxHeight: 750,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Side Text Block - (૧૧ flex નો બેસ્ટ વિડ્થ રેશિયો)
          Expanded(
            flex: 11,
            child: Container(
              alignment: Alignment.center, // ✅ આ આખા ડાબી બાજુના બ્લોકને હંમેશા મિડલમાં રાખશે
              padding: const EdgeInsets.only(left: 80.0, top: 40.0, bottom: 40.0, right: 40.0),
              child: _buildHeroLeftContentWeb(),
            ),
          ),

          // Right Side Image Container - (૯ flex નો રેશિયો અને ઇમેજ પ્રોપર ફિટ)
          Expanded(
            flex: 9,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.bgCream,
                    Color(0xFFF5A65B),
                    Color(0xFFD46A13),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: _buildHeroRightImage(BoxFit.cover, Alignment.topCenter), // ફોટો આખો કવર કરશે
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroRightImage(BoxFit boxFit, Alignment alignment) {
    return Image.asset(
      'assets/images/parsuram.png',
      fit: boxFit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'images/parsuram.png',
          fit: boxFit,
          alignment: alignment,
        );
      },
    );
  }

  Widget _buildHeroMobileLayout() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildHeroLeftContentMobile(),
        ),
        Container(
          width: double.infinity,
          height: 480,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.bgCream, Color(0xFFF5A65B)], // ગ્રેડિએન્ટ સ્ટાર્ટ ક્રીમ થી
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _buildHeroRightImage(BoxFit.contain, Alignment.center),
        ),
      ],
    );
  }

  Widget _buildHeroLeftContentWeb() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center, // બધું લખાણ એક સાથે પ્રોપર સેન્ટરમાં લોક થશે
      mainAxisSize: MainAxisSize.min, // વધારાની સ્પેસ રોકશે નહીં
      children: [
        Text(
          'ગુજરાત રાજ્યપુરોહિત સમાજમાં',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textMaroon, // ✅ ગ્લોબલ કલર
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 10),

        RichText(
          text: TextSpan(
            style: GoogleFonts.baloo2(
              textStyle: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            children: const [
              TextSpan(
                text: 'તમારી\n',
                style: TextStyle(color: AppColors.textMaroon), // ✅ ગ્લોબલ કલર
              ),
              TextSpan(
                text: 'ઈ-મેમ્બરશીપ\n',
                style: TextStyle(color: AppColors.textOrange), // ✅ ગ્લોબલ કલર
              ),
              TextSpan(
                text: 'એક્ટીવેટ કરો.',
                style: TextStyle(color: AppColors.textMaroon), // ✅ ગ્લોબલ કલર
              ),
            ],
          ),
        ),

        const SizedBox(height: 60), // જલારામ બાપાવાળી ઓરિજિનલ સાઇટ જેવો પ્રોપર ગેપ

        Text(
          'ગુજરાત રાજ્યપુરોહિત સમાજનું એકીકરણ અને વિકાસ માટે જોડાઓ. તમારી માહિતી નોંધાવી સમાજની ડિજિટલ ઓળખ બનાવી શકશો.',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 16,
              color: AppColors.textMaroon, // ✅ ગ્લોબલ કલર
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 35),
        _buildHeroActionButtons(),
      ],
    );
  }

  Widget _buildHeroLeftContentMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ગુજરાત રાજ્યપુરોહિત સમાજમાં',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textMaroon, // ✅ ગ્લોબલ કલર
            ),
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: GoogleFonts.baloo2(
              textStyle: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
            ),
            children: const [
              TextSpan(
                text: 'તમારી\n',
                style: TextStyle(color: AppColors.textMaroon), // ✅ ગ્રાન્ડ મરૂન
              ),
              TextSpan(
                text: 'ઈ-મેમ્બરશીપ\n',
                style: TextStyle(color: AppColors.textOrange), // ✅ ઓરેન્જ
              ),
              TextSpan(
                text: 'એક્ટીવેટ કરો.',
                style: TextStyle(color: AppColors.textMaroon), // ✅ મરૂન
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Text(
          'ગુજરાત રાજ્યપુરોહિત સમાજનું એકીકરણ અને વિકાસ માટે જોડાઓ. તમારી માહિતી નોંધાવી સમાજની ડિજિટલ ઓળખ બનાવી શકશો.',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.textMaroon, // ✅ ગ્લોબલ કલર
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 25),
        _buildHeroActionButtons(isMobile: true),
      ],
    );
  }

  Widget _buildHeroActionButtons({bool isMobile = false}) {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.textOrange, // ✅ ગ્લોબલ કલર
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 28,
                vertical: isMobile ? 14 : 16
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          onPressed: () {},
          child: Text(
              'મેમ્બરશીપ  ➔',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isMobile ? 13 : 14)
          ),
        ),
        SizedBox(width: isMobile ? 15 : 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.btnYellow, // ✅ ગ્લોબલ કલર
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 28,
                vertical: isMobile ? 14 : 16
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          onPressed: () {},
          child: Text(
              'સંપર્ક  ➔',
              style: TextStyle(color: AppColors.textMaroon, fontWeight: FontWeight.bold, fontSize: isMobile ? 13 : 14) // ✅ ગ્લોબલ ટેક્સ્ટ કલર
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SECTION 2: MAROON SOLUTIONS MODULE
  // ==========================================
  Widget _buildSolutionsSection(bool isWeb, double screenWidth) {
    return Container(
      color: AppColors.sectionMaroon,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.06 : 24.0,
        vertical: 80.0,
      ),
      child: isWeb ? _buildSolutionsWebLayout() : _buildSolutionsMobileLayout(),
    );
  }

  // --- વેબ વ્યુ લેઆઉટ ---
  Widget _buildSolutionsWebLayout() {
    // હોવર સ્ટેટ ટ્રેક કરવા માટે ઓન-ધ-ફ્લાય રીએક્ટિવ વેલ્યુ
    final RxInt hoveredIndex = (-1).obs;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 280,
          height: 380,
          child: _buildMaroonSectionImage(),
        ),
        const SizedBox(width: 50),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSolutionsHeader(),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(() => _buildHoverableSolutionCard(
                      index: 0,
                      hoveredIndex: hoveredIndex.value,
                      title: 'વ્યવસાય કોમ્યુનિટી',
                      description: 'સમાજમાં ધંધા અને સેવાઓ સરળતાથી શોધો.',
                      iconData: Icons.business_center,
                      onHover: (isHovered) => hoveredIndex.value = isHovered ? 0 : -1,
                    )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() => _buildHoverableSolutionCard(
                      index: 1,
                      hoveredIndex: hoveredIndex.value,
                      title: 'મેટ્રિમોની',
                      description: 'રાજ્યપુરોહિત સમાજમાં જીવનસાથી શોધ માટે પ્લેટફોર્મ.',
                      iconData: Icons.people,
                      onHover: (isHovered) => hoveredIndex.value = isHovered ? 1 : -1,
                    )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() => _buildHoverableSolutionCard(
                      index: 2,
                      hoveredIndex: hoveredIndex.value,
                      title: 'ઈવેન્ટ્સ',
                      description: 'આવતા કાર્યોમો અને વિગતો અહીં અપડેટ રહેશે.',
                      iconData: Icons.calendar_month,
                      onHover: (isHovered) => hoveredIndex.value = isHovered ? 2 : -1,
                    )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Obx(() => _buildHoverableSolutionCard(
                      index: 3,
                      hoveredIndex: hoveredIndex.value,
                      title: 'શિક્ષણ અને હેલ્થ સહાય',
                      description: 'જરૂરિયાતમંદોને શિક્ષણ/હેલ્થ દાનમાં સહાય.',
                      iconData: Icons.school,
                      onHover: (isHovered) => hoveredIndex.value = isHovered ? 3 : -1,
                    )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- મોબાઇલ વ્યુ લેઆઉટ ---
  Widget _buildSolutionsMobileLayout() {
    final RxInt hoveredIndex = (-1).obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: double.infinity,
            height: 320,
            child: _buildMaroonSectionImage(),
          ),
        ),
        const SizedBox(height: 40),
        _buildSolutionsHeader(),
        const SizedBox(height: 30),
        Obx(() => _buildHoverableSolutionCard(index: 0, hoveredIndex: hoveredIndex.value, title: 'વ્યવસાય કોમ્યુનિટી', description: 'સમાજમાં ધંધા અને સેવાઓ સરળતાથી શોધો.', iconData: Icons.business_center, onHover: (v) => hoveredIndex.value = v ? 0 : -1)),
        const SizedBox(height: 16),
        Obx(() => _buildHoverableSolutionCard(index: 1, hoveredIndex: hoveredIndex.value, title: 'મેટ્રિમોની', description: 'રાજ્યપુરોહિત સમાજમાં જીવનસાથી શોધ માટે પ્લેટફોર્મ.', iconData: Icons.people, onHover: (v) => hoveredIndex.value = v ? 1 : -1)),
        const SizedBox(height: 16),
        Obx(() => _buildHoverableSolutionCard(index: 2, hoveredIndex: hoveredIndex.value, title: 'ઈવેન્ટ્સ', description: 'આવતા કાર્યોમો અને વિગતો અહીં અપડેટ રહેશે.', iconData: Icons.calendar_month, onHover: (v) => hoveredIndex.value = v ? 2 : -1)),
        const SizedBox(height: 16),
        Obx(() => _buildHoverableSolutionCard(index: 3, hoveredIndex: hoveredIndex.value, title: 'શિક્ષણ અને હેલ્થ સહાય', description: 'જરૂરિયાતમંદોને શિક્ષણ/હેલ્થ દાનમાં સહાય.', iconData: Icons.school, onHover: (v) => hoveredIndex.value = v ? 3 : -1)),
      ],
    );
  }

  // --- ડાયનેમિક હોવર કંટ્રોલ કરતું રીયુઝેબલ કાર્ડ વિજેટ ---
  Widget _buildHoverableSolutionCard({
    required int index,
    required int hoveredIndex,
    required String title,
    required String description,
    required IconData iconData,
    required Function(bool) onHover,
  }) {
    // શું માઉસ આ કાર્ડ પર છે?
    final isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // ✅ કાર્ડની અંદર પૂરતી જગ્યા આપવા માટે પરફેક્ટ પેડિંગ સેટ કર્યું
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 35.0),
        decoration: BoxDecoration(
          color: isHovered ? Colors.white.withOpacity(0.09) : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(4),
          // ✅ જ્યારે હોવર થાય ત્યારે જ નીચે ગોલ્ડન બોર્ડર લાઈન હાઈલાઈટ થશે
          border: Border(
            bottom: BorderSide(
              color: isHovered ? AppColors.btnYellow : Colors.transparent,
              width: 3.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // આઈકોન
            Icon(
              iconData,
              size: 28,
              color: isHovered ? AppColors.btnYellow : Colors.white60,
            ),
            const SizedBox(height: 25),

            // મુખ્ય ટાઇટલ
            Text(
              title,
              style: GoogleFonts.baloo2(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ સબ કન્ટેન્ટ (ડિસ્ક્રિપ્શન લખાણ) - જે ઓરિજિનલ સાઇટમાં દેખાય છે એ જ બેઠું સેટ કર્યું
            Text(
              description,
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),

            // ✅ જો હોવર થાય ત્યારે જ "વધુ જાણો ➔" વાળી લિંક સ્મૂથલી એનિમેટ થઈને નીચે દેખાશે
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isHovered ? 1.0 : 0.0,
              child: isHovered
                  ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'વધુ જાણો ',
                      style: GoogleFonts.baloo2(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: Colors.white
                    ),
                  ],
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  // --- હેડિંગ મોડ્યુલ ---
  Widget _buildSolutionsHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'અમે કેવી રીતે મદદ કરીએ છીએ',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.btnYellow,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'સમાજ માટેના ઉકેલો',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  // --- ડાબી બાજુની ઈમેજ મેથડ ---
  Widget _buildMaroonSectionImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.asset(
        'assets/images/earth.png',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.white10,
          child: const Icon(Icons.person, size: 100, color: Colors.white24),
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 3: MISSION / COUNT SECTION MODULE
  // ==========================================
  Widget _buildMissionSection(bool isWeb) {
    return Container(
      color: AppColors.bgCream, // ગ્લોબલ ક્રીમ બેકગ્રાઉન્ડ
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: isWeb ? _buildMissionWebLayout() : _buildMissionMobileLayout(),
    );
  }

  // --- વેબ વ્યુ લેઆઉટ (બટન હોવર અને લાઈવ એનિમેટેડ પ્રોફાઈલ્સ સાથે) ---
  Widget _buildMissionWebLayout() {
    final RxBool isBtnHovered = false.obs;

    final RxBool isP1Hovered = false.obs;
    final RxBool isP2Hovered = false.obs;
    final RxBool isP3Hovered = false.obs;
    final RxBool isP4Hovered = false.obs;

    return SizedBox(
      height: 600, // ➔ ✅ ફિક્સ હાઇટ આપી દીધી, હવે ચારેય માણસોના ફોટા ૧૦૦% કટોકટ દેખાશે!
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 🔹 ૧. આજુબાજુ ગોઠવાયેલી ૪ હોવર એનિમેટેડ પ્રોફાઈલ ઈમેજીસ
          Positioned(
            left: 40,
            top: 40,
            child: Obx(() => _buildAnimatedProfile(
              imagePath: 'assets/images/user1.png',
              size: 110,
              isHovered: isP1Hovered.value,
              onHover: (v) => isP1Hovered.value = v,
            )),
          ),
          Positioned(
            left: 140,
            bottom: 20,
            child: Obx(() => _buildAnimatedProfile(
              imagePath: 'assets/images/user2.png',
              size: 120,
              isHovered: isP2Hovered.value,
              onHover: (v) => isP2Hovered.value = v,
            )),
          ),
          Positioned(
            right: 60,
            top: 80,
            child: Obx(() => _buildAnimatedProfile(
              imagePath: 'assets/images/user3.png',
              size: 115,
              isHovered: isP3Hovered.value,
              onHover: (v) => isP3Hovered.value = v,
            )),
          ),
          Positioned(
            right: 110,
            bottom: 40,
            child: Obx(() => _buildAnimatedProfile(
              imagePath: 'assets/images/user4.png',
              size: 125,
              isHovered: isP4Hovered.value,
              onHover: (v) => isP4Hovered.value = v,
            )),
          ),

          // 🔹 ૨. સેન્ટરનું મુખ્ય લખાણ અને કાઉન્ટર
          Container(
            constraints: const BoxConstraints(maxWidth: 850),
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'અમારું મિશન',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textOrange,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'ગુજરાત રાજ્યપુરોહિત સમાજની ઈ-મેમ્બરશીપમાં જોડાઓ\nઅને સમાજના સકારાત્મક બદલાવમાં ભાગ બનો.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textMaroon,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                Text(
                  '1,00,000+',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    textStyle: const TextStyle(
                      fontSize: 110,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textOrange,
                      height: 1.0,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'પરિવારોનું લક્ષ્ય (ઈ-મેમ્બરશીપ)',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // ✅ "વધુ જાણો" બટન ઓરિજિનલ સ્ટાઇલમાં (હોવર થાય ત્યારે જ મરૂન થશે)
                MouseRegion(
                  onEnter: (_) => isBtnHovered.value = true,
                  onExit: (_) => isBtnHovered.value = false,
                  cursor: SystemMouseCursors.click,
                  child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 280,
                    height: 54,
                    decoration: BoxDecoration(
                      // ➔ ✅ નોર્મલ વખતે કલર ટ્રાન્સપરન્ટ, હોવર થાય ત્યારે જ સોલિડ મરૂન થશે!
                      color: isBtnHovered.value ? AppColors.textMaroon : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      // નોર્મલ વખતે પાતળી બોર્ડર, હોવર વખતે બોર્ડર પણ મરૂન થઈ જશે
                      border: Border.all(
                        color: isBtnHovered.value ? AppColors.textMaroon : Colors.black12,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'વધુ જાણો',
                            style: GoogleFonts.baloo2(
                              textStyle: TextStyle(
                                fontSize: 15,
                                // ➔ ✅ નોર્મલ વખતે મરૂન ટેક્સ્ટ, હોવર થાય ત્યારે વ્હાઇટ (સફેદ) ટેક્સ્ટ થશે!
                                color: isBtnHovered.value ? Colors.white : AppColors.textMaroon,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            // ➔ ✅ આઇકોન પણ હોવર પ્રમાણે કલર બદલશે
                            color: isBtnHovered.value ? Colors.white : AppColors.textMaroon,
                          ),
                        ],
                      ),
                    ),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- મોબાઇલ વ્યુ લેઆઉટ ---
  Widget _buildMissionMobileLayout() {
    return Column(
      children: [
        Text(
          'અમારું મિશન',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textOrange),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'ગુજરાત રાજ્યપુરોહિત સમાજની ઈ-મેમ્બરશીપમાં જોડાઓ અને સમાજના સકારાત્મક બદલાવમાં ભાગ બનો.',
            textAlign: TextAlign.center,
            style: GoogleFonts.baloo2(
              textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textMaroon, height: 1.3),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '1,00,000+',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(fontSize: 70, fontWeight: FontWeight.w800, color: AppColors.textOrange),
          ),
        ),
        Text(
          'પરિવારોનું લક્ષ્ય (ઈ-મેમ્બરશીપ)',
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 35),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCircularProfile('assets/images/user1.png', 60),
            const SizedBox(width: 10),
            _buildCircularProfile('assets/images/user2.png', 60),
            const SizedBox(width: 10),
            _buildCircularProfile('assets/images/user3.png', 60),
            const SizedBox(width: 10),
            _buildCircularProfile('assets/images/user4.png', 60),
          ],
        ),
        const SizedBox(height: 35),

        Container(
          width: 240,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black12),
          ),
          child: InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('વધુ જાણો', style: GoogleFonts.baloo2(textStyle: const TextStyle(fontSize: 14, color: AppColors.textMaroon, fontWeight: FontWeight.bold))),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 14, color: AppColors.textMaroon),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- નવું એનિમેટેડ પ્રોફાઇલ વિજેટ મોડ્યુલ (માઉસ કર્સર હોવર માટે) ---
  Widget _buildAnimatedProfile({
    required String imagePath,
    required double size,
    required bool isHovered,
    required Function(bool) onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        // ✅ માઉસ આવે ત્યારે ફોટો સહેજ ઉપરની તરફ ખેંચાશે અને સ્કેલ મોટો થશે
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -8.0 : 0.0)
          ..scale(isHovered ? 1.06 : 1.0),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isHovered ? Colors.black.withOpacity(0.15) : Colors.black.withOpacity(0.05),
                blurRadius: isHovered ? 15 : 10,
                offset: isHovered ? const Offset(0, 8) : const Offset(0, 4),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.textMaroon.withOpacity(0.2),
                  child: const Icon(Icons.person, color: AppColors.textMaroon),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // --- ગોળાકાર પ્રોફાઇલ વિજેટ મોડ્યુલ ---
  Widget _buildCircularProfile(String imagePath, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // જો ઈમેજ ન મળે તો ગ્રે સર્કલ પ્લેસહોલ્ડર
            return Container(
              color: AppColors.textMaroon.withOpacity(0.2),
              child: const Icon(Icons.person, color: AppColors.textMaroon),
            );
          },
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 4: PROCESS STEPS MODULE (૧૦૦% રેસ્પોન્સિવ)
  // ==========================================

  Widget _buildStepsSection(bool isWeb, double screenWidth) {
    return Container(
      color: AppColors.sectionMaroon,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.06 : 24.0,
        vertical: 80.0,
      ),
      child: Column(
        children: [
          _buildStepsHeader(),
          const SizedBox(height: 60),
          isWeb ? _buildStepsWebLayout() : _buildStepsMobileLayout(),
          const SizedBox(height: 50),
          _buildStepsFooterText(),
        ],
      ),
    );
  }

  // --- હેડર મોડ્યુલ ---
  Widget _buildStepsHeader() {
    return Column(
      children: [
        Text(
          'અમે જે કરીએ છીએ તે અમને ગમે છે',
          textAlign: TextAlign.center,
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.btnYellow,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '4 સરળ પગલાંમાં ઈ-મેમ્બરશીપ',
          textAlign: TextAlign.center,
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  // --- વેબ વ્યુ લેઆઉટ (રીએક્ટિવ હોવર સ્ટેટ સાથે) ---
  Widget _buildStepsWebLayout() {
    // કયું વર્તુળ હોવર થાય છે તેને ટ્રેક કરવા માટે ઓન-ધ-ફ્લાય સ્ટેટ
    final RxInt hoveredStep = (-1).obs;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Obx(() => _buildHoverableStepItem(
            stepNumber: '01',
            title: 'મોબાઈલ OTP વેરીફિકેશન',
            description: 'તમારા મોબાઈલ નંબર પર OTP મેળવો અને સફળતાપૂર્વક ચકાસણી કરો.',
            index: 0,
            hoveredStep: hoveredStep.value,
            onHover: (isHovered) => hoveredStep.value = isHovered ? 0 : -1,
          )),
        ),
        _buildStepArrow(),
        Expanded(
          child: Obx(() => _buildHoverableStepItem(
            stepNumber: '02',
            title: 'વ્યક્તિગત વિગતો દાખલ કરો',
            description: 'Commercial મુખ્ય માહિતી, સરનામું, જન્મતારીખ વગેરે ચોક્સાઈથી ભરો.',
            index: 1,
            hoveredStep: hoveredStep.value,
            onHover: (isHovered) => hoveredStep.value = isHovered ? 1 : -1,
          )),
        ),
        _buildStepArrow(),
        Expanded(
          child: Obx(() => _buildHoverableStepItem(
            stepNumber: '03',
            title: 'પરિવારની વિગતો ઉમેરો',
            description: 'જીવનસાથી/બાળકો/વડીલોની માહિતી તમારી પ્રોફાઈલમાં દાખલ કરો.',
            index: 2,
            hoveredStep: hoveredStep.value,
            onHover: (isHovered) => hoveredStep.value = isHovered ? 2 : -1,
          )),
        ),
        _buildStepArrow(),
        Expanded(
          child: Obx(() => _buildHoverableStepItem(
            stepNumber: '04',
            title: 'મેમ્બરશીપ CARD ડાઉનલોડ કરો',
            description: 'અરજી મંજૂર થયા પછી તમારું e-Card ડાઉનલોડ કરો અને શેર કરો.',
            index: 3,
            hoveredStep: hoveredStep.value,
            onHover: (isHovered) => hoveredStep.value = isHovered ? 3 : -1,
          )),
        ),
      ],
    );
  }

  // --- મોબાઇલ વ્યુ લેઆઉટ ---
  Widget _buildStepsMobileLayout() {
    final RxInt hoveredStep = (-1).obs;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // ✅ સ્ટેપ ૦૧: સાચો વિજેટ કૉલ
          Obx(() => _buildHoverableStepItem(
              index: 0,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 0 : -1,
              stepNumber: '01',
              title: 'મોબાઈલ OTP વેરીફિકેશન',
              description: 'તમારા મોબાઈલ નંબર પર OTP મેળવો અને સફળતાપૂર્વક ચકાસણી કરો.'
          )),
          const SizedBox(height: 40), // બે સ્ટેપ વચ્ચે પ્રોપર ગેપ

          // ✅ સ્ટેપ ૦૨: સાચો વિજેટ કૉલ
          Obx(() => _buildHoverableStepItem(
              index: 1,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 1 : -1,
              stepNumber: '02',
              title: 'વ્યક્તિગત વિગતો દાખલ કરો',
              description: 'મુખ્ય માહિતી, સરનામું, જન્મતારીખ વગેરે ચોક્સાઈથી ભરો.'
          )),
          const SizedBox(height: 40),

          // ✅ સ્ટેપ ૦૩: (અહીંયા પહેલા ભૂલથી મોટું કાર્ડ કૉલ થતું હતું, જે હવે ૧૦૦% ફિક્સ કરી દીધું છે)
          Obx(() => _buildHoverableStepItem(
              index: 2,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 2 : -1,
              stepNumber: '03',
              title: 'પરિવારની વિગતો ઉમેરો',
              description: 'જીવનસાથી/બાળકો/વડીલોની માહિતી તમારી પ્રોફાઈલમાં દાખલ કરો.'
          )),
          const SizedBox(height: 40),

          // ✅ સ્ટેપ ૦૪: સાચો વિજેટ કૉલ
          Obx(() => _buildHoverableStepItem(
              index: 3,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 3 : -1,
              stepNumber: '04',
              title: 'મેમ્બરશીપ કાર્ડ ડાઉનલોડ કરો',
              description: 'અરજી મંજૂર થયા પછી તમારું e-Card ડાઉનલોડ કરો અને શેર કરો.'
          )),
        ],
      ),
    );
  }

  // --- ડાયનેમિક હોવર કંટ્રોલ કરતું સ્ટેપ આઇટમ વિજેટ (સર્કલ વ્હાઇટ ઇફેક્ટ સાથે) ---
  Widget _buildHoverableStepItem({
    required String stepNumber,
    required String title,
    required String description,
    required int index,
    required int hoveredStep,
    required Function(bool) onHover,
  }) {
    // ચેક કરો કે કર્સર આ સ્ટેપ પર છે કે નહિ
    final isCircleHovered = hoveredStep == index;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: Column(
        children: [
          // ગોળ નંબર બોક્સ (હોવર એનિમેશન સાથે)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              // ➔ ✅ માઉસ ઉપર હોય ત્યારે કલર એકદમ શુદ્ધ વ્હાઇટ (સફેદ) થશે, બાકી નોર્મલ વખતે ગોલ્ડન-પીળો
              color: isCircleHovered ? Colors.white : AppColors.btnYellow,
              shape: BoxShape.circle,
              boxShadow: isCircleHovered ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ] : [],
            ),
            alignment: Alignment.center,
            child: Text(
              stepNumber,
              style: GoogleFonts.baloo2(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMaroon, // નંબર હંમેશા મરૂન રહેશે
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),

          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.baloo2(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.baloo2(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- કનેક્ટિંગ એરો વિજેટ (`>>`) ---
  Widget _buildStepArrow() {
    return const Padding(
      padding: EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
      child: Text(
        '>>',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.btnYellow,
          letterSpacing: -2,
        ),
      ),
    );
  }

  // --- બોટમ કન્ફોર્મેશન ટેક્સ્ટ મોડ્યુલ ---
  Widget _buildStepsFooterText() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: GoogleFonts.baloo2(
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: const [
            TextSpan(
              text: 'હવે જોડાઓ અને સમાજની ડિજિટલ ઓળખ બનાવો. ',
              style: TextStyle(color: AppColors.btnYellow),
            ),
            TextSpan(
              text: 'અરજી કરો',
              style: TextStyle(
                color: AppColors.btnYellow,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 5: FAQ ACCORDION MODULE (૧૦૦% એનિમેટેડ)
  // ==========================================
  Widget _buildFaqSection(bool isWeb, double screenWidth) {
    // કયો પ્રશ્ન અત્યારે ખુલ્લો છે તેને ટ્રેક કરવા માટે ઓન-ધ-ફ્લાય રીએક્ટિવ વેલ્યુ
    final RxInt expandedIndex = 0.obs; // બાય-ડિફોલ્ટ પહેલો પ્રશ્ન ખુલ્લો રાખ્યો છે (સ્ક્રીનશોટ ૧ મુજબ)

    return Container(
      color: AppColors.bgCream, // ગ્લોબલ ક્રીમ બેકગ્રાઉન્ડ
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 24.0,
        vertical: 90.0,
      ),
      child: isWeb
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ડાબી બાજુનું હેડિંગ બોક્સ
          Expanded(
            flex: 7,
            child: _buildFaqLeftHeader(),
          ),
          const SizedBox(width: 60),
          // જમણી બાજુનું એકોર્ડિયન લિસ્ટ
          Expanded(
            flex: 13,
            child: _buildFaqList(expandedIndex),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFaqLeftHeader(),
          const SizedBox(height: 50),
          _buildFaqList(expandedIndex),
        ],
      ),
    );
  }

  // --- ડાબી બાજુનું હેડિંગ મોડ્યુલ ---
  Widget _buildFaqLeftHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FAQ's વિભાગ",
          style: GoogleFonts.notoSansGujarati( // ➔ ✅ ક્લીન ગુજરાતી ફોન્ટ
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textOrange,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'વારંવાર\nપૂછાતા પ્રશ્નો',
          style: GoogleFonts.notoSansGujarati( // ➔ ✅ ઓરિજિનલ જેવો જ ઘાટો લુક લાવવા માટે
            textStyle: const TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900, // ➔ ✅ અલ્ટ્રા બોલ્ડ (ઘાટો) લુક
              color: AppColors.textMaroon,
              height: 1.15,
            ),
          ),
        ),
      ],
    );
  }

  // --- જમણી બાજુનું આખું લિસ્ટ મોડ્યુલ ---
  Widget _buildFaqList(RxInt expandedIndex) {
    return Column(
      children: [
        Obx(() => _buildFaqAccordionItem(
          index: 0,
          expandedIndex: expandedIndex.value,
          stepNumber: '01',
          question: 'ઈ-મેમ્બરશીપ મેળવવાની પ્રક્રિયા શું છે?',
          answer: 'સરળ 4 પગલાં: 1) મોબાઈલ નંબરથી OTP વેરીફિકેશન, 2) તમારી વ્યક્તિગત વિગતો ભરો, 3) પરિવારના સભ્યોની વિગતો ઉમેરો, 4) મંજૂરી પછી તમારું મેમ્બરશીપ e-Card ડાઉનલોડ કરો.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
        Obx(() => _buildFaqAccordionItem(
          index: 1,
          expandedIndex: expandedIndex.value,
          stepNumber: '02',
          question: 'નોંધણી માટે કોઈ ફી અથવા ચાર્જ છે?',
          answer: 'નોંધણી સંપૂર્ણપણે મુક્ત છે - કોઈ ફી/ચાર્જ લેવામાં આવતો નથી. વધુ માહિતી માટે નોંધણી પેજ જુઓ અથવા જરૂરી હોય તો અમારો સંપર્ક કરો.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
        Obx(() => _buildFaqAccordionItem(
          index: 2,
          expandedIndex: expandedIndex.value,
          stepNumber: '03',
          question: 'મારી માહિતી સુરક્ષિત કેવી રીતે રહેશે?',
          answer: 'તમારી માહિતી સમાજની સેવાઓ માટે જ ઉપયોગમાં લેવામાં આવશે. અમે ગોપનીયતા નીતિ મુજબ ડેટા સુરક્ષિત રીતે સંગ્રહિત કરીએ છીએ અને ત્રીજા પક્ષ સાથે શેર કરતા નથી.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
        Obx(() => _buildFaqAccordionItem(
          index: 3,
          expandedIndex: expandedIndex.value,
          stepNumber: '04',
          question: 'મંજૂરી અને e-Card મળવામાં કેટલો સમય લાગે?',
          answer: 'OTP વેરીફિકેશન અને વિગતો સબમિટ કર્યા પછી અરજી સમીક્ષા થાય છે. મંજૂરી થયા બાદ e-Card ડાઉનલોડ માટે ઉપલબ્ધ થાય છે અને SMS દ્વારા સૂચના મળે છે.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
        Obx(() => _buildFaqAccordionItem(
          index: 4,
          expandedIndex: expandedIndex.value,
          stepNumber: '05',
          question: 'મોબાઇલ એપ (Android/iOS) ક્યારે મળશે?',
          answer: 'રાજ્યપુરોહિત ઓનલાઇનની Android અને iOS એપ ટૂંક સમયમાં ઉપલબ્ધ થશે. લોન્ચ બાદ તમે એપમાં પણ OTP વેરીફિકેશન, રજીસ્ટ્રેશન અને e-Card એક્સેસ કરી શકશો.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
      ],
    );
  }

  // --- એનિમેટેડ એકોર્ડિયન સિંગલ આઇટમ વિજેટ (૧૦૦% કટોકટ મેચ) ---
  // --- એનિમેટેડ એકોર્ડિયન સિંગલ આઇટમ વિજેટ (ફોન્ટ મિસમેચ ફિક્સ) ---
  Widget _buildFaqAccordionItem({
    required int index,
    required int expandedIndex,
    required String stepNumber,
    required String question,
    required String answer,
    required Function(int) onTap,
  }) {
    final isOpen = index == expandedIndex;

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: InkWell(
        onTap: () => onTap(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ૧. આંકડો
                  SizedBox(
                    width: 40,
                    child: Text(
                      stepNumber,
                      style: GoogleFonts.notoSansGujarati( // ➔ ✅ ફોન્ટ યુનિફોર્મિટી
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textMaroon,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),

                  // ૨. પ્રશ્ન ટેક્સ્ટ (Baloo ૨ કાઢીને Noto Sans Gujarati કર્યું જેથી સેમ લુક આવે)
                  Expanded(
                    child: Text(
                      question,
                      style: GoogleFonts.notoSansGujarati( // ➔ ✅ પ્રશ્નોનો શેપ હવે બેઠો મેચ થશે
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isOpen ? AppColors.textOrange : AppColors.textMaroon,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // ૩. પ્લસ/માઇનસ બટન
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOpen ? AppColors.textOrange : Colors.transparent,
                      border: isOpen ? null : Border.all(color: Colors.black12, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      isOpen ? Icons.remove : Icons.add,
                      size: 18,
                      color: isOpen ? Colors.white : AppColors.textOrange,
                    ),
                  ),
                ],
              ),

              // ૪. ઉત્તર એનિમેશન
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(left: 55.0, top: 16.0, right: 40.0),
                  child: Text(
                    answer,
                    style: GoogleFonts.notoSansGujarati( // ➔ ✅ કન્ટેન્ટ ફોન્ટ ફિક્સ
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.65),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                crossFadeState: isOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 250),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
