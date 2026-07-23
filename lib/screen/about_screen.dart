import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/about_controller.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_footer.dart';
import '../controllers/about_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/widgets.dart';

class AboutScreen extends GetView<AboutController> {
  static const pageId = "/AboutScreen";
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background, // ✅ અપડેટેડ: ગ્લોબલ બેકગ્રાઉન્ડ
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildAboutHeaderBanner(isWeb, screenWidth),      // ૧. મુખ્ય બેનર સેક્શન
            _buildMergedContentSection(isWeb, screenWidth),    // ૨. મર્જડ કન્ટેન્ટ સેક્શન
            _buildHistorySection(isWeb, screenWidth),          // ⚡ નવીનતમ: જ્ઞાતિનો ગૌરવશાળી ઇતિહાસ સેક્શન ભાઈ!
            _buildMissionVisionValuesSection(isWeb, screenWidth), // ૪. મિશન, વિઝન, વેલ્યુ સેક્શન
            _buildDigitalConnectSection(isWeb, screenWidth),      // ૫. ડિજિટલ કનેક્ટ સેક્શન
            const CustomFooter(),                               // ૩. કોમન ફૂટર
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૧. MAIN HEADER BANNER
  // ==========================================
  Widget _buildAboutHeaderBanner(bool isWeb, double screenWidth) {
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
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          'અમારા વિષે',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isWeb ? 34 : 26,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
            height: 1.0, // ➔ ⚡ મેઈન ફિક્સ: ઊભી લાઈનમાં ટકાટક સેન્ટર!
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૨. MERGED CONTENT SECTION
  // ==========================================
  Widget _buildMergedContentSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 70.0,
    );

    final imageStackContent = SizedBox(
      height: 480,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 40,
            bottom: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/images/about_group.jpg',
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(color: AppColors.cardBorder, child: const Icon(Icons.people, size: 50, color: AppColors.subtitle)), // ✅ અપડેટેડ
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 60,
            width: 220,
            height: 220,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.background, width: 8), // ✅ અપડેટેડ
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  'assets/images/about_hands.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: AppColors.cardBorder, child: const Icon(Icons.handshake, size: 40, color: AppColors.subtitle)), // ✅ અપડેટેડ
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final mergedTextContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'અમારા વિષે',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.accent, // ✅ અપડેટેડ
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              color: AppColors.heading, // ✅ અપડેટેડ
              height: 1.2,
            ),
            children: [
              TextSpan(text: 'જ્ઞાતને જોડે છે '),
              TextSpan(text: 'RajyaGor', style: TextStyle(color: AppColors.accent)), // ✅ અપડેટેડ
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'ગુજરાત રાજયગોર જ્ઞાતનું આ એક અધિકૃત ડિજિટલ પ્લેટફોર્મ છે, જેનો મુખ્ય ઉદ્દેશ્ય સમગ્ર દેશ અને વિદેશમાં વસતા જ્ઞાતના પરિવારોને એક તાંતણે બાંધવાનો છે. આ માધ્યમ દ્વારા શૈક્ષણિક, સામાજિક, અને વ્યાપારી પ્રગતિ વેગવંતી બનશે.',
          style: TextStyle(
            fontSize: 15,
            color: AppColors.body.withOpacity(0.85), // ✅ અપડેટેડ
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        _buildCheckPointRow('ઈ-મેમ્બર_શીપ અને સમુદાય સેવાઓ'),
        const SizedBox(height: 12),
        _buildCheckPointRow('આપત્તિ વેળાએ સેવા-સમર્પણ'),
        const SizedBox(height: 30),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.02),
            border: const Border(left: BorderSide(color: AppColors.accent, width: 4)), // ✅ અપડેટેડ
            borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'જ્ઞાત સેવા સપોર્ટ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.heading), // ✅ અપડેટેડ
              ),
              const SizedBox(height: 6),
              Text(
                'રાજયગોર જ્ઞાતના સર્વાંગી વિકાસ માટે સતત સેવા અને સહકાર.',
                style: TextStyle(fontSize: 14, color: AppColors.body.withOpacity(0.7), fontWeight: FontWeight.w500), // ✅ અપડેટેડ
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 25.0,
          runSpacing: 20.0,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent, // ✅ અપડેટેડ
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              onPressed: () {},
              child: const Text(
                'અમારી સાથે જોડાઓ  ➔',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle), // ✅ અપડેટેડ
                  child: const Icon(Icons.phone, color: Colors.white, size: 18), // ✅ અપડેટેડ
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Call Us Anytime',
                      style:  const TextStyle(fontSize: 12,
                              color: AppColors.subtitle, fontWeight: FontWeight.w500), // ✅ અપડેટેડ
                    ),
                    Text(
                      '+91 95743-09096',
                      style:  const TextStyle(fontSize: 15, color: AppColors.heading, fontWeight: FontWeight.bold), // ✅ અપડેટેડ
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    );

    return Container(
      padding: padding,
      child: isWeb
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 10, child: imageStackContent),
          const SizedBox(width: 65),
          Expanded(flex: 12, child: mergedTextContent),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageStackContent,
          const SizedBox(height: 50),
          mergedTextContent,
        ],
      ),
    );
  }

  Widget _buildCheckPointRow(String pointText) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.primary, // ✅ અપડેટેડ
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 15),
        Text(
          pointText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.heading, // ✅ અપડેટેડ
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 🔹 ૩. NEW HISTORY SECTION (જ્ઞાતિનો ગૌરવશાળી ઇતિહાસ સેક્શન - પિક્સલ-પરફેક્ટ ભાઈ)
  // ==========================================
  Widget _buildHistorySection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 50.0,
    );

    return Container(
      width: double.infinity,
      color: Colors.white, // ઇતિહાસ વાંચવા માટે મસ્ત ક્લીન વ્હાઇટ બેકગ્રાઉન્ડ ભાઈ
      padding: padding,
      child: Center(
        child: Container(
          // ⚡ બોક્સ કોન્સ્ટ્રેઇન્ટ ફિક્સ: વેબ વ્યુમાં કન્ટેન્ટને ૧૦૦૦ પિક્સલથી મોટું થવા નહીં દે ભાઈ!
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'જ્ઞાતિનો ગૌરવશાળી ઇતિહાસ',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: 70,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 25),

              _buildHistoryParagraph(
                'જામનગર રાજગોર (રાજ્યપુરોહિત) બ્રાહ્મણ જ્ઞાતિનો ઇતિહાસ આશરે ૪૮६ વર્ષ જૂનો માનવામાં આવે છે. કચ્છના રાજવી જામ રાવળ, જે કચ્છની તેરા શાખાના પ્રમુખ જામ લાખોજીના પુત્ર હતા, તેમણે ઈ.સ. ૧૫૨૪થી ૧૫૪૮ સુધી કચ્છ પર શાસન કર્યું. બાદમાં આંતરિક વિખવાદો અને રાજકીય પરિસ્થિતિઓને કારણે તેઓ પોતાના ભાયાતો, वફાદાર સૈનિકો તથા કુળગોર રાજ્યપુરોહિત બ્રાહ્મણ પરિવારો સાથે કચ્છ છોડીને સૌરાષ્ટ્ર તરફ પ્રસ્થાન કર્યું. લોકવાયકા મુજબ આશાપુરા માતાની પ્રેરણાથી તેમણે નવા રાજ્યની સ્થાપનાનો સંકલ્પ કર્યો.',
              ),
              _buildHistoryParagraph(
                'સૌપ્રથમ જામ રાવળે બેડ ગામ ખાતે થાણું સ્થાપ્યું અને ત્યારબાદ khંભાળિયા વિસ્તારમાં પોતાનું પ્રભુત્વ સ્થાપિત કર્યું. ખંભાળિયા અને સલાયા દરિયાકાંઠાના વિસ્તારો હોવાથી વેપાર અને બંદર વિકાસ માટે અનુકૂળ હતા. સમય જતાં અનેક સ્થાનિક શાસકો અને જાતિઓ સાથેના સંઘર્ષોમાં વિજય પ્રાપ્ત કરીને તેમણે જોડિયા, આમરણ, ધ્રોલ, નાગનાથ બંદર અને ખંભાળિયા જેવા વિસ્તારો પોતાના રાજ્યમાં સામેલ કર્યા. અંતે ઈ.સ. ૧૫૪૦ આસપાસ નવાનગર (આજનું જામનગર) રાજ્યની સ્થાપના કરી અને જામનગરને રાજધાની તરીકે વિકસાવ્યું.',
              ),
              _buildHistoryParagraph(
                'જામ રાવળ સાથે આવેલા રાજ્યપુરોહિત બ્રાહ્મણ પરિવારોને રાજગોર તરીકે ઓળખવામાં આવ્યા. તેમને વસવાટ માટે જામનગર શહેરમાં રાજગોર ફળીમાં મકાનો તથા જીવનનિર્વાહ માટે ખેતીની જમીનો આપવામાં આવી. ખંભાળિયા, સોડસલા તથા આસપાસના વિસ્તારોમાં પણ રાજગોર પરિવારોને ખેતી અને ધાર્મિક સેવાઓ માટે જમીનો ફાળવવામાં આવી. જાડેજા રાજવીઓએ પોતાના ભાયાતોને વિવિધ ગામો અને પરગણાઓના વહીવટની જવાબદારી સોંપી હતી, અને તે ભાયાતોના ગોર તરીકે રાજગોર બ્રાહ્મણ પરિવારો ગામે ગામ વસ્યા. આજે પણ જામનગર, ખંભાળિયા, ભાટિયા, ભોપલકા, લાલપુર તથા આસપાસના લગભગ ૧૦0થી વધુ ગામોમાં રાજગોર પરિવારો વસવાટ કરે છે અને તેમની ઐતિહાસિક ઓળખ જાળવી રાખે છે.',
              ),
              _buildHistoryParagraph(
                'લાલપુર વિસ્તારના ચેલા ચંગા, હરીપર, મેમાણા, ખીરસરા, ભણગોર સહિતના ગામોમાં પણ રાજગોર પરિવારો રાજના ગોર તરીકે ઓળખાય છે. સમય જતાં આ પરિવારો જામનગર અને ખંભાળિયા ઉપરાંત રાજકોટ, મોરબી, ગોંડલ, જુનાગઢ, મુંબઈ, આફ્રિકા, લંડન અને અન્ય સ્થળોએ સ્થાયી થયા. શિક્ષણ, વેપાર-ઉદ્યોગ, સરકારી સેવા, રાજકારણ અને વિવિધ વ્યવસાયોમાં તેમણે નોંધપાત્ર પ્રગતિ હાંસલ કરી છે.',
              ),
              _buildHistoryParagraph(
                'રાજગોર જ્ઞાતિમાં અનેક શાખાઓ અને અટકો જોવા મળે છે. લોકવાયકા મુજબ કલો, ખેતો, ગોપો અને પુંજો નામના ચાર મુખ્ય વડવાઓના વંશજો ક્રમે કલ્યાણી, ખેતીયા, ગોપિયાણી અને પુંજાણી તરીકે ઓળખાયા. આ ઉપરાંત ભટ્ટ, બારોટ, નાકર, જોશી, લવા, પંડ્યા, આશા, રાવલ, વાસુ, કેશવાણી વગેરે અટકો ધરાવતા પરિવારો પણ જ્ઞાતિમાં મહત્વનું સ્થાન ધરાવે છે. આ સિવાય મોખા, મેતા, મોતા અને કેવલીયા પરિવાર પણ રાજગોર જ્ઞાતિનો અભિન્ન ભાગ છે અને જ્ઞાતિના સામાજિક તથા સાંસ્કૃતિક વિકાસમાં તેમનું પણ મહત્વપૂર્ણ યોગદાન રહ્યું છે.',
              ),
              _buildHistoryParagraph(
                'રાજગોર બ્રાહ્મણોના કેટલાક પરિવારો વિવિધ રાજ્યોના શાસકો સાથે સંકળાયેલા રહ્યા હતા. રાજકોટ અને ગોંડલમાં મુખ્યત્વે ખેતીયા પરિવારો વસ્યા, જ્યારે જુનાગઢમાં ગોપિયાણી પરિવારો અને મોરબીમાં જોશી પરિવારો રાજપરિવારો સાથે જોડાયેલા હોવાનું કહેવાય છે. આ સંબંધોએ જ્ઞાતિના સામાજિક અને વહીવટી પ્રભાવને વધુ મજબૂત બનાવ્યો.',
              ),
              _buildHistoryParagraph(
                'આ રીતે રાજગોર બ્રાહ્મણ જ્ઞાતિએ રાજ્યપુરોહિત, વહીવટી માર્ગદર્શક, ધાર્મિક સેવક અને સમાજનિર્માતા તરીકે સૌરાષ્ટ્ર અને ગુજરાતના ઇતિહાસમાં મહત્વપૂર્ણ યોગદાન આપ્યું છે. આજે પણ જ્ઞાતિના પરિવારો પોતાની પરંપરા, સંસ્કૃતિ અને ઐતિહાસિક વારસાને જાળવી રાખીને વિવિધ ક્ષેત્રોમાં પ્રગતિ કરી રહ્યા છે.',
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryParagraph(String text, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0.0 : 18.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.5,
          color: AppColors.body.withOpacity(0.9), // ✅ અપડેટેડ
          height: 1.7, // સુંદર પઠન માટે ક્લીન લાઇન સ્પેસિંગ
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ==========================================
  // 🔹 ૪. MISSION, VISION, VALUES SECTION
  // ==========================================
  Widget _buildMissionVisionValuesSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.symmetric(
      horizontal: isWeb ? screenWidth * 0.08 : 24.0,
      vertical: 60.0,
    );

    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.015),
      padding: padding,
      child: Column(
        children: [
          isWeb
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildValueColumn(
                  title: 'અમારું મિશન',
                  description: 'ગુજરાતમાં રાજયગોર પરિવારોને ઓનલાઇન જોડવા અને સશક્ત બનાવવું.',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildValueColumn(
                  title: 'અમારી વિઝન',
                  description: 'એકતા, પારદર્શિતા અને ટેક્નોલોજીથી જ્ઞાત વિકાસ માટે મજબૂત પ્લેટફોર્મ.',
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildValueColumn(
                  title: 'અમારી મૂલ્યો',
                  description: 'સેવા, વિશ્વાસ, સહકાર અને સંસ્કારોનું સંવર્ધન.',
                ),
              ),
            ],
          )
              : Column(
            children: [
              _buildValueColumn(
                title: 'અમારું મિશન',
                description: 'ગુજરાતમાં  રાજયગોર પરિવારોને ઓનલાઇન જોડવા અને સશક્ત બનાવવું.',
              ),
              _buildHorizontalDivider(),
              _buildValueColumn(
                title: 'અમારી વિઝન',
                description: 'એકતા, પારદર્શિતા અને ટેક્નોલોજીથી જ્ઞાત વિકાસ માટે મજબૂત પ્લેટફોર્મ.',
              ),
              _buildHorizontalDivider(),
              _buildValueColumn(
                title: 'અમારી મૂલ્યો',
                description: 'સેવા, વિશ્વાસ, સહકાર અને સંસ્કારોનું સંવર્ધન.',
              ),
            ],
          ),
          const SizedBox(height: 50),
          Text(
            "You're always welcome here.",
            style:  const TextStyle(
                fontSize: 32,
                color: AppColors.accent, // ✅ અપડેટેડ
                letterSpacing: 1,
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueColumn({required String title, required String description}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: AppColors.heading, // ✅ અપડેટેડ
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          constraints: const BoxConstraints(maxWidth: 290),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.5,
              color: AppColors.body.withOpacity(0.9), // ✅ અપડેટેડ
              height: 1.6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 100,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.divider, // ✅ અપડેટેડ
    );
  }

  Widget _buildHorizontalDivider() {
    return Container(
      width: 120,
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 35),
      color: AppColors.divider, // ✅ અપડેટેડ
    );
  }

  // ==========================================
  // 🔹 ૫. DIGITAL CONNECT SECTION
  // ==========================================
  Widget _buildDigitalConnectSection(bool isWeb, double screenWidth) {
    final padding = EdgeInsets.only(
      left: isWeb ? screenWidth * 0.08 : 24.0,
      right: isWeb ? screenWidth * 0.08 : 24.0,
      top: 80.0,
      bottom: isWeb ? 0.0 : 60.0,
    );

    final leftColumnContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          '>ગુજરાત રાજયગોર જ્ઞાત',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.accent), // ✅ અપડેટેડ
        ),
        const SizedBox(height: 12),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.15,
            ),
            children: [
              TextSpan(text: 'જ્ઞાતને\n'),
              TextSpan(text: 'ડિજિટલ રીતે જોડીએ', style: TextStyle(color: AppColors.accent)), // ✅ અપડેટેડ
            ],
          ),
        ),
        const SizedBox(height: 40),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          child: Image.asset(
            'assets/images/earth_blue.png',
            height: isWeb ? 340 : 300,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(
              height: 300,
              color: Colors.white10,
              child: const Icon(Icons.remove_red_eye, size: 60, color: Colors.white24),
            ),
          ),
        ),
      ],
    );

    final rightColumnContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'ઈ-મેમ્બરશીપ, બિઝનેસ કોમ્યુનિટી સર્ચ, મેટ્રિમોની અને સહાય જેવી સેવાઓને એક પ્લેટફોર્મ પર સુરક્ષિત રીતે ઉપલબ્ધ કરાવવાનું અમારું ધ્યેય છે.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.whiteText.withOpacity(0.85),
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 45),
        isWeb
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 140,
              child: Text(
                'Our Mission',
                style:  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                'OTP વેરીફિકેશનથી ઝડપી નોંધણી, પરિવારની વિગતો સાથે સચોટ ડેટાબેઝ અને પારદર્શિતાથી જ્ઞાત વિકાસ.',
                style: TextStyle(color: AppColors.whiteText.withOpacity(0.65), fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Mission',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'OTP વેરીફિકેશનથી ઝડપી નોંધણી, પરિવારની વિગતો સાથે સચોટ ડેટાબેઝ અને પારદર્શિતાથી સમાજ વિકાસ.',
              style: TextStyle(color: AppColors.whiteText.withOpacity(0.65), fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 40),
        InkWell(
          onTap: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'અમારી સેવાઓ ',
                  style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold, fontSize: 14), // ✅ અપડેટેડ
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, color: AppColors.accent, size: 14), // ✅ અપડેટેડ
              ],
            ),
          ),
        ),
        if (isWeb) const SizedBox(height: 50),
      ],
    );

    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: padding,
      child: isWeb
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(flex: 9, child: leftColumnContent),
          const SizedBox(width: 80),
          Expanded(flex: 11, child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: rightColumnContent,
          )),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leftColumnContent,
          const SizedBox(height: 40),
          rightColumnContent,
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
