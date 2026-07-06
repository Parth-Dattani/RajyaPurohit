import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rajya_purohit/screen/screen.dart';
import '../controllers/home_controller.dart';
import '../constant/app_colors.dart';
import '../widgets/widgets.dart'; // ✅ ગ્લોબલ કલર્સ ફાઈલ ઈમ્પોર્ટ કરી

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

class HomeScreen extends GetView<HomeController> {
  static const pageId = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background, // ✅ ગ્લોબલ સરફેસ બેકગ્રાઉન્ડ
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context, isWeb),               // ================== SECTION 1 ==================
            //_buildSolutionsSection(isWeb, screenWidth),     // ================== SECTION 2 ==================
            _buildMissionSection(isWeb),                    // ================== SECTION 3 ==================
            _buildStepsSection(isWeb, screenWidth),         // ================== SECTION 4 ==================
            _buildFaqSection(isWeb, screenWidth),           // ================== SECTION 5 ==================
            const CustomFooter(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 1: HERO SECTION MODULE
  // ==========================================
  Widget _buildHeroSection(BuildContext context, bool isWeb) {
    return Container(
      color: AppColors.background,
      child: isWeb ? _buildHeroWebLayout(context) : _buildHeroMobileLayout(),
    );
  }

  Widget _buildHeroWebLayout(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final dynamicHeight = screenHeight * 0.75;

    // ⚡ કમ્પાઇલરના ડખા દૂર કરવા માટે ડબલમાં કન્વર્ટ ભાઈ
    final double baseHeight = (dynamicHeight < 630 ? 630.0 : dynamicHeight).toDouble();

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ➔ ૧. મેઈન સેક્શન: શરૂઆતનો ઇતિહાસ અને જમણી બાજુ દાદાનો ફોટો (Row Layout)
          Container(
            height: baseHeight,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ડાબી બાજુ: માત્ર શરૂઆતના ૨ પેરેગ્રાફ ભાઈ
                Expanded(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 80.0, top: 40.0, bottom: 20.0, right: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'જામનગર રાજ્યપુરોહિત (રાજગોર) બ્રાહ્મણ જ્ઞાતિ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.heading,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 54,
                              fontWeight: FontWeight.w800,
                              height: 1.15,
                            ),
                            children: [
                              TextSpan(
                                text: 'જ્ઞાતિનો ગૌરવશાળી\n',
                                style: TextStyle(color: AppColors.heading),
                              ),
                              TextSpan(
                                text: 'ઐતિહાસિક વારસો.',
                                style: TextStyle(color: AppColors.accent),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'જામનગર રાજ્યપુરોહિત (રાજગોર) બ્રાહ્મણ જ્ઞાતિનો ઇતિહાસ આશરે ૪૮૬ વર્ષ જૂનો માનવામાં આવે છે. કચ્છના રાજવી જામ રાવળ, જે કચ્છની તેરા શાખાના પ્રમુખ જામ લાખોજીના પુત્ર હતા, તેમણે ઈ.સ. ૧૫૨૪થી ૧૫૪૮ સુધી કચ્છ પર શાસન કર્યું. બાદમાં આંતરિક વિખવાદો અને રાજકીય પરિસ્થિતિઓને કારણે તેઓ પોતાના ભાયાતો, વફાદાર સૈનિકો તથા કુળગોર રાજ્યપુરોહિત બ્રાહ્મણ પરિવારો સાથે કચ્છ છોડીને સૌરાષ્ટ્ર તરફ પ્રસ્થાન કર્યું. લોકવાયકા મુજબ આશાપુરા માતાની પ્રેરણાથી તેમણે નવા રાજ્યની સ્થાપનાનો સંકલ્પ કર્યો.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15.5, color: AppColors.body, fontWeight: FontWeight.w500, height: 1.6),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'સૌપ્રથમ જામ રાવળે બેડ ગામ ખાતે થાણું સ્ถาપ્યું અને ત્યારબાદ khંભાળિયા વિસ્તારમાં પોતાનું પ્રભુત્વ સ્થાપિત કર્યું. ખંભાળિયા અને સલાયા દરિયાકાંઠાના વિસ્તારો હોવાથી વેપાર અને બંદર વિકાસ માટે અનુકૂળ હતા. સમય જતાં અનેક સ્થાનિક શાસકો અને જાતિઓ સાથેના સંઘર્ષોમાં વિજય પ્રાપ્ત કરીને તેમણે જોડિયા, આમરણ, ધ્રોલ, નાગનાથ બંદર અને ખંભાળિયા જેવા વિસ્તારો પોતાના રાજ્યમાં સામેલ કર્યા. અંતે ઈ.સ. ૧૫૪૦ આસપાસ નવાનગર (આજનું જામનગર) રાજ્યની સ્થાપના કરી અને જામનગરને રાજધાની તરીકે વિકસાવ્યું.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15.5, color: AppColors.body, fontWeight: FontWeight.w500, height: 1.6),
                        ),

                        // ⚡ જો હિસ્ટ્રી બંધ હોય તો જ બટન અહીંયા ઉપર દેખાશે ભાઈ!
                        if (!controller.isHistoryExpanded.value) ...[
                          const SizedBox(height: 25),
                          _buildHeroActionButtons(),
                        ],
                      ],
                    ),
                  ),
                ),

                // જમણી બાજુ: ભગવાન પરશુરામની ઈમેજ
                Expanded(
                  flex: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.background, Color(0xFFF5A65B), Color(0xFFD46A13)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: _buildHeroRightImage(BoxFit.contain, Alignment.topCenter),
                  ),
                ),
              ],
            ),
          ),

          // ➔ ૨. બાકીનો બધો જ ઇતિહાસ હવે ફોટાની સાવ નીચે ફૂલ વિડ્થ (Full Width) માં ઓપન થશે
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: controller.isHistoryExpanded.value
                ? Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 80.0, right: 80.0, bottom: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildExtendedHistoryText(
                    'જામ રાવળ સાથે આવેલા રાજ્યપુરોહિત બ્રાહ્મણ પરિવારોને રાજગોર તરીકે ઓળખવામાં આવ્યા. તેમને વસવાટ માટે જામનગર શહેરમાં રાજગોર ફળીમાં મકાનો તથા જીવનનિર્વાહ માટે ખેતીની જમીનો આપવામાં આવી. ખંભાળિયા, સોડસલા તથા આસપાસના વિસ્તારોમાં પણ રાજગોર પરિવારોને ખેતી અને ધાર્મિક સેવાઓ માટે જમીનો ફાળવવામાં આવી. જાડેજા રાજવીઓએ પોતાના ભાયાતોને વિવિધ ગામો અને પરગણાઓના વહીવટની જવાબદારી સોંપી હતી, અને તે ભાયાતોના ગોર તરીકે રાજગોર બ્રાહ્મણ પરિવારો ગામે ગામ વસ્યા. આજે પણ જામનગર, ખંભાળિયા, ભાટિયા, ભોપલકા, લાલપુર તથા આસપાસના લગભગ ૧૦૦થી વધુ ગામોમાં રાજગોર પરિવારો વસવાટ કરે છે અને તેમની ઐતિહાસિક ઓળખ જાળવી રાખે છે.',
                    isMobile: false,
                  ),
                  const SizedBox(height: 15),
                  _buildExtendedHistoryText(
                    'લાલપુર વિસ્તારના ચેલા ચંગા, hરીપર, મેમાણા, ખીરસરા, ભણગોર સહિતના ગામોમાં પણ રાજગોર પરિવારો રાજના ગોર તરીકે ઓળખાય છે. સમય જતાં આ પરિવારો જામનગર અને ખંભાળિયા ઉપરાંત રાજકોટ, મોરબી, ગોંડલ, જુનાગઢ, મુંબઈ, આફ્રિકા, લંડન અને અન્ય સ્થળોએ સ્થાયી થયા. શિક્ષણ, વેપાર-ઉદ્યોગ, સરકારી સેવા, રાજકારણ અને વિવિધ વ્યવસાયોમાં તેમણે નોંધપાત્ર પ્રગતિ હાંસલ કરી છે.',
                    isMobile: false,
                  ),
                  const SizedBox(height: 15),
                  _buildExtendedHistoryText(
                    'રાજગોર જ્ઞાતિમાં અનેક શાખાઓ અને અટકો જોવા મળે છે. લોકવાયકા મુજબ કલો, ખેતો, ગોપો અને પુંજો નામના ચાર મુખ્ય વડવાઓના વંશજો ક્રમે કલ્યાણી, ખેતીયા, ગોપિયાણી અને પુંજાણી તરીકે ઓળખાયા. આ ઉપરાંત ભટ્ટ, બારોટ, નાકર, જોશી, લવા, પંડ્યા, આશા, રાવલ, વાસુ, કેશવાણી વગેરે અટકો ધરાવતા પરિવારો પણ જ્ઞાતિમાં મહત્વનું સ્થાન ધરાવે છે. આ સિવાય મોખા, મેતા, મોતા અને કેવલીયા પરિવાર પણ રાજગોર જ્ઞાતિનો અભિન્ન ભાગ છે અને જ્ઞાતિના સામાજિક તથા સાંસ્કૃતિક વિકાસમાં તેમનું પણ મહત્વપૂર્ણ યોગદાન રહ્યું છે.',
                    isMobile: false,
                  ),
                  const SizedBox(height: 15),
                  _buildExtendedHistoryText(
                    'રાજગોર બ્રાહ્મણોના કેટલાક પરિવારો વિવિધ રાજ્યોના શાસકો સાથે સંકળાયેલા રહ્યા હતા. રાજકોટ અને ગોંડલમાં મુખ્યત્વે ખેતીયા પરિવારો વસ્યા, જ્યારે જુનાગઢમાં ગોપિયાણી પરિવારો અને મોરબીમાં જોશી પરિવારો રાજપરિવારો સાથે જોડાયેલા હોવાનું કહેવાય છે. આ સંબંધોએ જ્ઞાતિના સામાજિક અને વહીવટી પ્રભાવને વધુ મજબૂત બનાવ્યો.',
                    isMobile: false,
                  ),
                  const SizedBox(height: 15),
                  _buildExtendedHistoryText(
                    'આ રીતે રાજગોર બ્રાહ્મણ જ્ઞાતિએ રાજ્યપુરોહિત, વહીવટી માર્ગદર્શક, ધાર્મિક સેવક અને સમાજનિર્માતા તરીકે સૌરાષ્ટ્ર અને ગુજરાતના ઇતિહાસમાં મહત્વપૂર્ણ યોગદાન આપ્યું છે. આજે પણ જ્ઞાતિના પરિવારો પોતાની પરંપરા, સંસ્કૃતિ અને ઐતિહાસિક વારસાને જાળવી રાખીને વિવિધ ક્ષેત્રોમાં પ્રગતિ કરી રહ્યા છે.',
                    isMobile: false,
                  ),

                  // ⚡ જાદુઈ બટન શિફ્ટ લોજિક
                  const SizedBox(height: 30),
                  _buildHeroActionButtons(),
                ],
              ),
            )
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }

  Widget _buildHeroRightImage(BoxFit boxFit, Alignment alignment) {
    return Image.asset(
      'assets/images/shiv_logo.png',
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
              colors: [AppColors.background, Color(0xFFF5A65B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: _buildHeroRightImage(BoxFit.contain, Alignment.center),
        ),
      ],
    );
  }

  Widget _buildHeroLeftContentMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'જામનગર રાજ્યપુરોહિત (રાજગોર) જ્ઞાતિ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.heading,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
            children: [
              TextSpan(
                text: 'જ્ઞાતિનો ગૌરવશાળી\n',
                style: TextStyle(color: AppColors.heading),
              ),
              TextSpan(
                text: 'ઐતિહાસિક વારસો.',
                style: TextStyle(color: AppColors.accent),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        const Text(
          'જામનગર રાજ્યપુરોહિત (રાજગોર) બ્રાહ્મણ જ્ઞાતિનો ઇતિહાસ આશરે ૪૮૬ વર્ષ જૂનો છે. ઈ.સ. ૧૫૪૦ આસપાસ કચ્છના રાજવી જામ રાવળ પોતાના કુળગોર રાજ્યપુરોહિત પરિવારો સાથે સૌરાષ્ટ્રમાં નવાનગર (આજનું જામનગર) રાજ્યની સ્થાપના કરી હતી. જાડેજા રાજવીઓ દ્વારા ગામેગામ વસેલા આ પરિવારો આજે પણ ગૌરવશાળી પરંપરા જાળવી વિવિધ ક્ષેત્રોમાં પ્રગતિ કરી રહ્યા છે.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.body,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),

        Obx(() => AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: controller.isHistoryExpanded.value
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildExtendedHistoryText('જામ રાવળ સાથે આવેલા રાજ્યપુરોહિત બ્રાહ્મણ પરિવારોને રાજગોર તરીકે ઓળખવામાં આવ્યા. તેમને વસવાટ માટે જામનગર શહેરમાં રાજગોર ફળીમાં મકાનો તથા જીવનનિર્વાહ માટે ખેતીની જમીનો આપવામાં આવી. ખંભાળિયા, સોડસલા તથા આસપાસના વિસ્તારોમાં પણ રાજગોર પરિવારોને ખેતી અને ધાર્મિક સેવાઓ માટે જમીનો ફાળવવામાં આવી. જાડેજા રાજવીઓએ પોતાના ભાયાતોને વિવિધ ગામો અને પરગણાઓના વહીવટની જવાબદારી સોંપી હતી, અને તે ભાયાતોના ગોર તરીકે રાજગોર બ્રાહ્મણ પરિવારો ગામે ગામ વસ્યા. આજે પણ જામનગર, ખંભાળિયા, ભાટિયા, ભોપલકા, લાલપુર તથા આસપાસના લગભગ ૧૦૦થી વધુ ગામોમાં રાજગોર પરિવારો વસવાટ કરે છે અને તેમની ઐતિહાસિક ઓળખ જાળવી રાખે છે.', isMobile: true),
              const SizedBox(height: 12),
              _buildExtendedHistoryText('લાલપુર વિસ્તારના ચેલા ચંગા, હરીપર, મેમાણા, khીરસરા, ભણગોર સહિતના ગામોમાં પણ રાજગોર પરિવારો રાજના ગોર તરીકે ઓળખાય છે. સમય જતાં આ પરિવારો જામનગર અને khંભાળિયા ઉપરાંત રાજકોટ, મોરબી, ગોંડલ, જુનાગઢ, મુંબઈ, આફ્રિકા, લંડન અને અન્ય સ્થળોએ સ્થાયી થયા. શિક્ષણ, વેપાર-ઉદ્યોગ, સરકારી સેવા, રાજકારણ અને વિવિધ વ્યવસાયોમાં તેમણે નોંધપાત્ર પ્રગતિ હાંસલ કરી છે.', isMobile: true),
              const SizedBox(height: 12),
              _buildExtendedHistoryText('રાજગોર જ્ઞાતિમાં અનેક શાખાઓ અને અટકો જોવા મળે છે. લોકવાયકા મુજબ કલો, ખેતો, ગોપો અને પુંજો નામના ચાર મુખ્ય વડવાઓના વંશજો ક્રમે કલ્યાણી, ખેતીયા, ગોપિયાણી અને પુંજાણી તરીકે ઓળખાયા. આ ઉપરાંત ભટ્ટ, બારોટ, નાકર, જોશી, લવા, પંડ્યા, આશા, રાવલ, વાસુ, કેશવાણી વગેરે અટકો ધરાવતા પરિવારો પણ જ્ઞાતિમાં મહત્વનું સ્થાન ધરાવે છે. આ સિવાય મોખા, મેતા, મોતા અને કેવલીયા પરિવાર પણ રાજગોર જ્ઞાતિનો અભિન્ન ભાગ છે અને જ્ઞાતિના સામાજિક તથા સાંસ્કૃતિક વિકાસમાં તેમનું પણ મહત્વપૂર્ણ યોગદાન રહ્યું છે.', isMobile: true),
              const SizedBox(height: 12),
              _buildExtendedHistoryText('રાજગોર બ્રાહ્મણોના કેટલાક પરિવારો વિવિધ રાજ્યોના શાસકો સાથે સંકળાયેલા રહ્યા હતા. રાજકોટ અને ગોંડલમાં મુખ્યત્વે ખેતીયા પરિવારો વસ્યા, જ્યારે જુનાગઢમાં ગોપિયાણી પરિવારો અને મોરબીમાં જોશી પરિવારો રાજપરિવારો સાથે જોડાયેલા હોવાનું કહેવાય છે. આ સંબંધોએ જ્ઞાતિના સામાજિક અને વહીવટી પ્રભાવને વધુ મજબૂત બનાવ્યો.', isMobile: true),
              const SizedBox(height: 12),
              _buildExtendedHistoryText('આ રીતે રાજગોર બ્રાહ્મણ જ્ઞાતિએ રાજ્યપુરોહિત, વહીવટી માર્ગદર્શક, ધાર્મિક સેવક અને સમાજનિર્માતા તરીકે સૌરાષ્ટ્ર અને ગુજરાતના ઇતિહાસમાં મહત્વપૂર્ણ યોગદાન આપ્યું છે. આજે પણ જ્ઞાતિના પરિવારો પોતાની પરંપરા, સંસ્કૃતિ અને ઐતિહાસિક વારસાને જાળવી રાખીને વિવિધ ક્ષેત્રોમાં પ્રગતિ કરી રહ્યા છે.', isMobile: true),
            ],
          )
              : const SizedBox.shrink(),
        )),

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
            backgroundColor: AppColors.accent,
            padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 32,
                vertical: isMobile ? 14 : 18
            ),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          onPressed: () {
            controller.isHistoryExpanded.value = !controller.isHistoryExpanded.value;
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Text(
                controller.isHistoryExpanded.value ? 'ઓછું વાંચો' : 'વધુ વાંચો',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 13 : 14,
                ),
              )),
              const SizedBox(width: 8),
              Obx(() => Icon(
                controller.isHistoryExpanded.value ? Icons.arrow_upward : Icons.arrow_forward,
                color: Colors.white,
                size: 16,
              )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExtendedHistoryText(String text, {required bool isMobile}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: isMobile ? 14 : 15.5,
        color: AppColors.body,
        fontWeight: FontWeight.w500,
        height: isMobile ? 1.5 : 1.6,
      ),
    );
  }

  // ==========================================
  // SECTION 2: MAROON SOLUTIONS MODULE currently not show
  // ==========================================
  Widget _buildSolutionsSection(bool isWeb, double screenWidth) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.06 : 24.0,
        vertical: 80.0,
      ),
      child: isWeb ? _buildSolutionsWebLayout() : _buildSolutionsMobileLayout(),
    );
  }

  Widget _buildSolutionsWebLayout() {
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
                      description: 'રાજ્યગોર સમાજમાં જીવનસાથી શોધ માટે પ્લેટફોર્મ.',
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
        Obx(() => _buildHoverableSolutionCard(index: 1, hoveredIndex: hoveredIndex.value, title: 'મેટ્રિમોની', description: 'રાજ્યગોર સમાજમાં જીવનસાથી શોધ માટે પ્લેટફોર્મ.', iconData: Icons.people, onHover: (v) => hoveredIndex.value = v ? 1 : -1)),
        const SizedBox(height: 16),
        Obx(() => _buildHoverableSolutionCard(index: 2, hoveredIndex: hoveredIndex.value, title: 'ઈવેન્ટ્સ', description: 'આવતા કાર્યોમો અને વિગતો અહીં અપડેટ રહેશે.', iconData: Icons.calendar_month, onHover: (v) => hoveredIndex.value = v ? 2 : -1)),
        const SizedBox(height: 16),
        Obx(() => _buildHoverableSolutionCard(index: 3, hoveredIndex: hoveredIndex.value, title: 'શિક્ષણ અને હેલ્થ સહાય', description: 'જરૂરિયાતમંદોને શિક્ષણ/હેલ્થ દાનમાં સહાય.', iconData: Icons.school, onHover: (v) => hoveredIndex.value = v ? 3 : -1)),
      ],
    );
  }

  Widget _buildHoverableSolutionCard({
    required int index,
    required int hoveredIndex,
    required String title,
    required String description,
    required IconData iconData,
    required Function(bool) onHover,
  }) {
    final isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 35.0),
        decoration: BoxDecoration(
          color: isHovered ? Colors.white.withOpacity(0.09) : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(4),
          border: Border(
            bottom: BorderSide(
              color: isHovered ? AppColors.accent : Colors.transparent,
              width: 3.0,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 28,
              color: isHovered ? AppColors.accent : Colors.white60,
            ),
            const SizedBox(height: 25),

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),

            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isHovered ? 1.0 : 0.0,
              child: isHovered
                  ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'વધુ જાણો ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
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

  Widget _buildSolutionsHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'અમે કેવી રીતે મદદ કરીએ છીએ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.accent,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'જ્ઞાત માટેના ઉકેલો',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ],
    );
  }

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
      color: AppColors.background,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: isWeb ? _buildMissionWebLayout() : _buildMissionMobileLayout(),
    );
  }

  Widget _buildMissionWebLayout() {
    final RxBool isBtnHovered = false.obs;

    final RxBool isP1Hovered = false.obs;
    final RxBool isP2Hovered = false.obs;
    final RxBool isP3Hovered = false.obs;
    final RxBool isP4Hovered = false.obs;

    return SizedBox(
      height: 600,
      child: Stack(
        alignment: Alignment.center,
        children: [
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

          Container(
            constraints: const BoxConstraints(maxWidth: 850),
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'અમારું મિશન',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'ગુજરાત રાજયગોર જ્ઞાતની ઈ-મેમ્બરશીપમાં જોડાઓ\nઅને જ્ઞાતના સકારાત્મક બદલાવમાં ભાગ બનો.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.heading,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'પરિવારોનું લક્ષ્ય (ઈ-મેમ્બરશીપ)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.subtitle,
                  ),
                ),
                const SizedBox(height: 40),

                MouseRegion(
                  onEnter: (_) => isBtnHovered.value = true,
                  onExit: (_) => isBtnHovered.value = false,
                  cursor: SystemMouseCursors.click,
                  child: Obx(() => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 280,
                    height: 54,
                    decoration: BoxDecoration(
                      color: isBtnHovered.value ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isBtnHovered.value ? AppColors.primary : AppColors.cardBorder,
                        width: 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(MembershipScreen.pageId);
                      },
                      borderRadius: BorderRadius.circular(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'વધુ જાણો',
                            style: TextStyle(
                              fontSize: 15,
                              color: isBtnHovered.value ? Colors.white : AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            size: 16,
                            color: isBtnHovered.value ? Colors.white : AppColors.primary,
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

  Widget _buildMissionMobileLayout() {
    return Column(
      children: [
        const Text(
          'અમારું મિશન',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.accent),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'ગુજરાત રાજયગોર સમાજની ઈ-મેમ્બરશીપમાં જોડાઓ અને સમાજના સકારાત્મક બદલાવમાં ભાગ બનો.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.heading, height: 1.3),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          '1,00,000+',
          style: TextStyle(fontSize: 70, fontWeight: FontWeight.w800, color: AppColors.accent),
        ),
        const Text(
          'પરિવારોનું લક્ષ્ય (ઈ-મેમ્બરશીપ)',
          style: TextStyle(fontSize: 13, color: AppColors.subtitle, fontWeight: FontWeight.w500),
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
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: InkWell(
            onTap: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('વધુ જાણો', style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
                  color: AppColors.primary.withOpacity(0.2),
                  child: const Icon(Icons.person, color: AppColors.primary),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

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
            return Container(
              color: AppColors.primary.withOpacity(0.2),
              child: const Icon(Icons.person, color: AppColors.primary),
            );
          },
        ),
      ),
    );
  }

  // ==========================================
  // SECTION 4: PROCESS STEPS MODULE
  // ==========================================
  Widget _buildStepsSection(bool isWeb, double screenWidth) {
    return Container(
      color: AppColors.primary,
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

  Widget _buildStepsHeader() {
    return const Column(
      children: [
        Text(
          'અમે જે કરીએ છીએ તે અમને ગમે છે',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.accent,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '4 સરળ પગલાંમાં ઈ-મેમ્બરશીપ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildStepsWebLayout() {
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
            description: ' Commercial મુખ્ય માહિતી, સરનામું, જન્મતારીખ વગેરે ચોક્સાઈથી ભરો.',
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

  Widget _buildStepsMobileLayout() {
    final RxInt hoveredStep = (-1).obs;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Obx(() => _buildHoverableStepItem(
              index: 0,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 0 : -1,
              stepNumber: '01',
              title: 'મોબાઈલ OTP વેરીફિકેશન',
              description: 'તમારા મોબાઈલ નંબર પર OTP મેળવો અને સફળતાપૂર્વક ચકાસણી કરો.'
          )),
          const SizedBox(height: 40),

          Obx(() => _buildHoverableStepItem(
              index: 1,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 1 : -1,
              stepNumber: '02',
              title: 'વ્યક્તિગત વિગતો દાખલ કરો',
              description: 'મુખ્ય માહિતી, સરનામું, જન્મતારીખ વગેરે ચોક્સાઈથી ભરો.'
          )),
          const SizedBox(height: 40),

          Obx(() => _buildHoverableStepItem(
              index: 2,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 2 : -1,
              stepNumber: '03',
              title: 'પરિવારની વિગતો ઉમેરો',
              description: 'જીવનસાથી/બાળકો/વડીલોની માહિતી તમારી પ્રોફાઈલમાં દાખલ કરો.'
          )),
          const SizedBox(height: 40),

          Obx(() => _buildHoverableStepItem(
              index: 3,
              hoveredStep: hoveredStep.value,
              onHover: (v) => hoveredStep.value = v ? 3 : -1,
              stepNumber: '04',
              title: 'મેમ્બરશીપ કૉર્ડ ડાઉનલોડ કરો',
              description: 'અરજી મંજૂર થયા પછી તમારું e-Card ડાઉનલોડ કરો અને શેર કરો.'
          )),
        ],
      ),
    );
  }

  Widget _buildHoverableStepItem({
    required String stepNumber,
    required String title,
    required String description,
    required int index,
    required int hoveredStep,
    required Function(bool) onHover,
  }) {
    final isCircleHovered = hoveredStep == index;

    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isCircleHovered ? Colors.white : AppColors.accent,
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
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 25),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepArrow() {
    return const Padding(
      padding: EdgeInsets.only(top: 24.0, left: 8.0, right: 8.0),
      child: Text(
        '>>',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.accent,
          letterSpacing: -2,
        ),
      ),
    );
  }

  Widget _buildStepsFooterText() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child:  RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          children: [
            TextSpan(
              text: 'હવે જોડાઓ અને સમાજની ડિજિટલ ઓળખ બનાવો. ',
              style: TextStyle(color: AppColors.accent),
            ),
            TextSpan(
              text: 'અરજી કરો',
              style: TextStyle(
                color: AppColors.accent,
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
  // SECTION 5: FAQ ACCORDION MODULE
  // ==========================================
  Widget _buildFaqSection(bool isWeb, double screenWidth) {
    final RxInt expandedIndex = 0.obs;

    return Container(
      color: AppColors.background,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? screenWidth * 0.08 : 24.0,
        vertical: 90.0,
      ),
      child: isWeb
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: _buildFaqLeftHeader(),
          ),
          const SizedBox(width: 60),
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

  Widget _buildFaqLeftHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FAQ's વિભાગ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accent,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'વારંવાર\nપૂછાતા પ્રશ્નો',
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.w900,
            color: AppColors.heading,
            height: 1.15,
          ),
        ),
      ],
    );
  }

  Widget _buildFaqList(RxInt expandedIndex) {
    return Column(
      children: [
        Obx(() => _buildFaqAccordionItem(
          index: 0,
          expandedIndex: expandedIndex.value,
          stepNumber: '01',
          question: 'ઈ-મેમ્બરશીપ મેળવવાની પ્રક્રિયા શું છે?',
          answer: 'સરળ 4 પગલાં:\n 1) મોબાઈલ નંબરથી OTP વેરીફિકેશન,\n 2) તમારી વ્યક્તિગત વિગતો ભરો,\n 3) પરિવારના સભ્યોની વિગતો ઉમેરો,\n 4) મંજૂરી પછી તમારું મેમ્બરશીપ e-Card ડાઉનલોડ કરો.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
        Obx(() => _buildFaqAccordionItem(
          index: 1,
          expandedIndex: expandedIndex.value,
          stepNumber: '02',
          question: 'નૉંધણી માટે કોઈ ફી અથવા ચાર્જ છે?',
          answer: 'નોંધણી સંપૂર્ણપણે મુક્ત છે - કોઈ ફી/ચાર્જ લેવામાં આવતો નથી. વધુ માહિતી માટે નોંધણી પેજ જુઓ અથવા જરૂરી હોય તો અમારો સંપર્ક કરો.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
        Obx(() => _buildFaqAccordionItem(
          index: 2,
          expandedIndex: expandedIndex.value,
          stepNumber: '03',
          question: 'મારી માહિતી સુરક્ષિત કેવી રીતે રહેશે?',
          answer: 'તમારી માહિતી જ્ઞાતની સેવાઓ માટે જ ઉપયોગમાં લેવામાં આવશે. અમે ગોપનીયતા નીતિ મુજબ ડેટા સુરક્ષિત રીતે સંગ્રહિત કરીએ છીએ અને ત્રીજા પક્ષ સાથે શેર કરતા નથી.',
          onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        )),
        // Obx(() => _buildFaqAccordionItem(
        //   index: 3,
        //   expandedIndex: expandedIndex.value,
        //   stepNumber: '04',
        //   question: 'મંજૂરી અને e-Card મળવામાં કેટલો સમય લાગે?',
        //   answer: 'OTP વેરીફિકેશન અને વિગતો સબમિટ કર્યા પછી અરજી સમીક્ષા થાય છે. મંજૂરી થયા બાદ e-Card ડાઉનલોડ માટે ઉપલબ્ધ થાય છે અને SMS દ્વારા સૂચના મળે છે.',
        //   onTap: (idx) => expandedIndex.value = expandedIndex.value == idx ? -1 : idx,
        // )),
      ],
    );
  }

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
                  SizedBox(
                    width: 40,
                    child: Text(
                      stepNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      question,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isOpen ? AppColors.accent : AppColors.heading,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isOpen ? AppColors.accent : Colors.transparent,
                      border: isOpen ? null : Border.all(color: Colors.black12, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      isOpen ? Icons.remove : Icons.add,
                      size: 18,
                      color: isOpen ? Colors.white : AppColors.accent,
                    ),
                  ),
                ],
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(left: 55.0, top: 16.0, right: 40.0),
                  child: Text(
                    answer,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.body.withOpacity(0.85),
                      fontWeight: FontWeight.w500,
                      height: 1.5,
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
