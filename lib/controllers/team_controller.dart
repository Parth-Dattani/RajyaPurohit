import 'package:get/get.dart';

import '../model/model.dart';

class TeamController extends GetxController {
  // ➔ હોદ્દાઓનું લિસ્ટ
  final List<String> categories = [
    'બધા', 'પ્રમુખ', 'ઉપ પ્રમુખ', 'મંત્રી', 'સહમંત્રી',
    'ખજાનચી', 'સહ ખજાનચી', 'આંતરિક ઓડિટર', 'જનસંપર્ક અધિકારી',
    'સમિતિ ચેરમેન', 'કારોબારી સભ્ય'
  ];

  // ➔ કરન્ટ સિલેક્ટેડ કેટેગરી (બાય ડિફોલ્ટ 'બધા')
  var selectedCategory = 'બધા'.obs;

  // ➔ કેટેગરી ચેન્જ કરવાની મેથડ
  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // તમારા કંટ્રોલર ક્લાસની અંદર આ લિસ્ટ ઉમેરો ભાઈ:
  final List<TeamMember> teamMembers = [
    TeamMember(name: 'શ્રી સુનિલભાઈ એચ. ખેતીયા', role: 'પ્રમુખ', phone: '99252 20323'),
    TeamMember(name: 'શ્રી ભરતભાઈ એ. આશા', role: 'ઉપ પ્રમુખ', phone: '94262 23279'),
    TeamMember(name: 'શ્રી ભાવિન એ. કલ્યાણી', role: 'મંત્રી', phone: '85111 97645'),
    TeamMember(name: 'શ્રી હિરેન કે. ગોપિયાણી', role: 'સહમંત્રી', phone: '92750 27904'),
    TeamMember(name: 'શ્રી રસિકભાઈ એ. મહેતા', role: 'ખજાનચી', phone: '94262 26567'),
    TeamMember(name: 'શ્રી સંજયભાઈ કે. કલ્યાણી', role: 'સહ ખજાનચી', phone: '99241 37124'),
    TeamMember(name: 'શ્રી કીર્તિભાઈ જી. કેવલીયા', role: 'આંતરિક ઓડિટર', phone: '98241 12123'),
    TeamMember(name: 'શ્રી હરીશભાઈ જે. કલ્યાણી', role: 'જનસંપર્ક અધિકારી', phone: '92281 25136'),
    TeamMember(name: 'શ્રી પિયુષભાઈ એમ. પુંજાણી', role: 'સમિતિ ચેરમેન', phone: '97126 24927'), // શિક્ષણ સમિતિ
    TeamMember(name: 'શ્રી મુકેશ એચ. કલ્યાણી', role: 'સમિતિ ચેરમેન', phone: '88668 91020'), // વ્યવસ્થાપક સમિતિ
    TeamMember(name: 'શ્રીમતી રેણુકાબેન પી. ભટ્ટ', role: 'समિતિ ચેરમેન', phone: '97149 64830'), // સાંસ્કૃતિક સમિતિ
    TeamMember(name: 'શ્રી રાહુલ પી. ભટ્ટ', role: 'સમિતિ ચેરમેન', phone: '93685 11111'), // મેડિકલ સમિતિ
    TeamMember(name: 'શ્રી જીતેન્દ્રભાઈ બારોટ', role: 'સમિતિ ચેરમેન', phone: '94090 78499'), // ફંડ એકત્રિત સમિતિ
    TeamMember(name: 'શ્રી ભરતભાઈ એમ. કલ્યાણી', role: 'સમિતિ ચેરમેન', phone: '87585 90533'), // મંદિર સમિતિ
    TeamMember(name: 'શ્રી પ્રફુલભાઈ એમ. વાસુ', role: 'કારોબારી સભ્ય', phone: '90999 26020'),
    TeamMember(name: 'શ્રી જયંતભાઈ જી. પુંજાણી', role: 'કારોબારી સભ્ય', phone: '98240 42199'),
    TeamMember(name: 'શ્રી જીતેશભાઈ કે. ખેતીયા', role: 'કારોબારી સભ્ય', phone: '98795 30009'),
    TeamMember(name: 'શ્રી રમેશભાઈ પી. ભટ્ટ', role: 'કારોબારી સભ્ય', phone: '94279 77768'),
    TeamMember(name: 'શ્રી જયમેશ વી. ગોપિયાણી', role: 'કારોબારી સભ્ય', phone: '98245 07495'),
    TeamMember(name: 'શ્રી લલિત એ. ગોપિયાણી', role: 'કારોબારી સભ્ય', phone: '70161 94631'),
    TeamMember(name: 'શ્રી જયેશ એમ. ગોપિયાણી', role: 'કારોબારી સભ્ય', phone: '98248 67547'),
    TeamMember(name: 'શ્રીમતી નિશાબેન બી. પુંજાણી', role: 'કારોબારી સભ્ય', phone: '97371 56215'),
    TeamMember(name: 'શ્રીમતી નયનાબેન પી. પુંજાણી', role: 'કારોબારી સભ્ય', phone: '75671 42452'),
  ];

// ફિલ્ટર કરેલું લિસ્ટ મેળવવાની ગેટર મેથડ
  List<TeamMember> get filteredMembers {
    if (selectedCategory.value == 'બધા') {
      return teamMembers;
    }
    return teamMembers.where((m) => m.role == selectedCategory.value).toList();
  }
}

