import 'package:get/get.dart';

import '../model/model.dart';

import 'package:get/get.dart';
import '../model/model.dart';

class TeamController extends GetxController {
  // ➔ ૧. હોદ્દાઓનું નવું લિસ્ટ (જૂનું સમિતિ ચેરમેન બદલીને વિવિધ સમિતિના ચેરમેન કર્યું ભાઈ)
  final List<String> categories = [
    'બધા', 'પ્રમુખ', 'ઉપ પ્રમુખ', 'મંત્રી', 'સહમંત્રી',
    'ખજાનચી', 'સહ ખજાનચી', 'આંતરિક ઓડિટર', 'જનસંપર્ક અધિકારી',
    'વિવિધ સમિતિના ચેરમેન', 'કારોબારી સભ્ય'
  ];

  var selectedCategory = 'બધા'.obs;
  var activeTeamTab = 'હાલની કમિટી'.obs;

  void changeCategory(String category) {
    selectedCategory.value = category;
  }

  // ➔ ૨. તમારો ઓરિજિનલ ડેટાબેઝ (જેમ છે તેમ જ રાખ્યો છે પાર્થભાઈ)
  final List<TeamMember> teamMembers = [
    TeamMember(name: 'શ્રી સુનિલભાઈ એચ. ખેતીયા', role: 'પ્રમુખ', phone: '99252 20323', imageUrl: 'https://rajyapurohitjamnagar.in/committee/1.jpg'),
    TeamMember(name: 'શ્રી ભરતભાઈ એ. આશા', role: 'ઉપ પ્રમુખ', phone: '94262 23279', imageUrl: 'https://rajyapurohitjamnagar.in/committee/2.jpg'),
    TeamMember(name: 'શ્રી ભાવિન એ. કલ્યાણી', role: 'મંત્રી', phone: '85111 97645', imageUrl: 'https://rajyapurohitjamnagar.in/committee/3.jpg'),
    TeamMember(name: 'શ્રી હિરેન કે. ગોપિયાણી', role: 'સહમંત્રી', phone: '92750 27904', imageUrl: 'https://rajyapurohitjamnagar.in/committee/4.jpg'),
    TeamMember(name: 'શ્રી રસિકભાઈ એ. મહેતા', role: 'ખજાનચી', phone: '94262 26567', imageUrl: 'https://rajyapurohitjamnagar.in/committee/5.jpg'),
    TeamMember(name: 'શ્રી સંજયભાઈ કે. કલ્યાણી', role: 'સહ ખજાનચી', phone: '99241 37124', imageUrl: 'https://rajyapurohitjamnagar.in/committee/6.jpg'),
    TeamMember(name: 'શ્રી કીર્તિભાઈ જી. કેવલીયા', role: 'આંતરિક ઓડિટર', phone: '98241 12123', imageUrl: 'https://rajyapurohitjamnagar.in/committee/7.jpg'),
    TeamMember(name: 'શ્રી હરીશભાઈ જે. કલ્યાણી', role: 'જનસંપર્ક અધિકારી', phone: '92281 25136', imageUrl: 'https://rajyapurohitjamnagar.in/committee/8.jpg'),

    // આ બધા ચેરમેન લોગ ભાઈ (ડેટાબેઝ સેટિંગ્સ)
    TeamMember(name: 'શ્રી પિયુષભાઈ એમ. પુંજાણી', role: 'શિક્ષણ', phone: '97126 24927', imageUrl: 'https://rajyapurohitjamnagar.in/committee/9.jpg'),
    TeamMember(name: 'શ્રી મુકેશ એચ. કલ્યાણી', role: 'વ્યવસ્થાપક', phone: '88668 91020', imageUrl: 'https://rajyapurohitjamnagar.in/committee/10.jpg'),
    TeamMember(name: 'શ્રીમતી રેણુકાબેન પી. ભટ્ટ', role: 'સાંસ્કૃતિક', phone: '97149 64830', imageUrl: 'https://rajyapurohitjamnagar.in/committee/11.jpg'),
    TeamMember(name: 'શ્રી રાહુલ પી. ભટ્ટ', role: 'મેડિકલ', phone: '93685 11111', imageUrl: 'https://rajyapurohitjamnagar.in/committee/12.jpg'),
    TeamMember(name: 'શ્રી જીતેન્દ્રભાઈ બારોટ', role: 'ફંડ એકત્રિત', phone: '94090 78499', imageUrl: 'https://rajyapurohitjamnagar.in/committee/13.jpg'),
    TeamMember(name: 'શ્રી ભરતભાઈ એમ. કલ્યાણી', role: 'મંદિર', phone: '87585 90533', imageUrl: 'https://rajyapurohitjamnagar.in/committee/14.jpg'),

    TeamMember(name: 'શ્રી પ્રફુલભાઈ એમ. વાસુ', role: 'કારોબારી સભ્ય', phone: '90999 26020', imageUrl: 'https://rajyapurohitjamnagar.in/committee/15.jpg'),
    TeamMember(name: 'શ્રી જયંતભાઈ જી. પુંજાણી', role: 'કારોબારી સભ્ય', phone: '98240 42199', imageUrl: ''),
    TeamMember(name: 'શ્રી જીતેશભાઈ કે. ખેતીયા', role: 'કારોબારી સભ્ય', phone: '98795 30009', imageUrl: 'https://rajyapurohitjamnagar.in/committee/17.jpg'),
    TeamMember(name: 'શ્રી રમેશભાઈ પી. ભટ્ટ', role: 'કારોબારી સભ્ય', phone: '94279 77768', imageUrl: 'https://rajyapurohitjamnagar.in/committee/18.jpg'),
    TeamMember(name: 'શ્રી જયમેશ વી. ગોપિયાણી', role: 'કારોબારી સભ્ય', phone: '98245 07495', imageUrl: 'https://rajyapurohitjamnagar.in/committee/19.jpg'),
    TeamMember(name: 'શ્રી લલિત એ. ગોપિયાણી', role: 'કારોબારી સભ્ય', phone: '70161 94631', imageUrl: 'https://rajyapurohitjamnagar.in/committee/20.jpg'),
    TeamMember(name: 'શ્રી જયેશ એમ. ગોપિયાણી', role: 'કારોબારી સભ્ય', phone: '98248 67547', imageUrl: 'https://rajyapurohitjamnagar.in/committee/21.jpg'),
    TeamMember(name: 'શ્રીમતી નિશાબેન બી. પુંજાણી', role: 'કારોબારી સભ્ય', phone: '97371 56215', imageUrl: 'https://rajyapurohitjamnagar.in/committee/22.jpg'),
    TeamMember(name: 'શ્રીમતી નયનાબેન પી. પુંજાણી', role: 'કારોબારી સભ્ય', phone: '75671 42452', imageUrl: 'https://rajyapurohitjamnagar.in/committee/23.jpg'),
  ];

  final List<PastPresident> pastPresidents = [
    PastPresident(srNo: 1, name: 'પટેલ મૂળશંકર નથુભાઈ પુંજાણી', duration: '૧૯૫૫ થી ૧૯૬૦', years: '૫ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op1.jpg'),
    PastPresident(srNo: 2, name: 'પ્રાગજીભાઈ કરસનજી ગોપિયાણી', duration: '૧૯૬૧ થી ૧૯૬૨', years: '૧ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op2.jpg'),
    PastPresident(srNo: 3, name: 'ગૌરીશંકર છગનલાલ પુંજાણી', duration: '૧૯૬૨ થી ૧૯૮૦', years: '૧૮ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op3.jpg'),
    PastPresident(srNo: 4, name: 'દયાશંકર માવજીભાઈ બારોટ (ભટ્ટ)', duration: '૧૯૮૦ થી ૧૯૮૨', years: '૨ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op4.jpg'),
    PastPresident(srNo: 5, name: 'વિપિનભાઈ હેમંતલાલ પુંજાણી', duration: '૧૯૮૨ થી ૧૯૯૦', years: '૮ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op5.jpg'),
    PastPresident(srNo: 6, name: 'રતીલાલ પરસોતમ ભટ્ટ', duration: '૧૯૯૦ થી ૧૯૯૨', years: '૨ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op6.jpg'),
    PastPresident(srNo: 7, name: 'શશીકાંતભાઈ ગીરધરલાલ પુંજાણી', duration: '૧૯૯૨ થી ૨૦૧૮', years: '૨૬ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op7.jpg'),
    PastPresident(srNo: 8, name: 'જયંતભાઈ ગૌરીશંકર પુંજાણી', duration: '૨૦૧૮ થી ૨૦૨૨', years: '૪ વર્ષ', imageUrl: 'https://rajyapurohitjamnagar.in/past_presidents/op8.jpg'),
  ];

  // ➔ ⚡ ૩. સ્માર્ટ ફિલ્ટર ગેટર મેથડ (આનાથી બધો ડેટા ટકાટક લોડ થઈ જશે પાર્થભાઈ!)
  List<TeamMember> get filteredMembers {
    final String currentCategory = selectedCategory.value;

    if (currentCategory == 'બધા') {
      return teamMembers;
    }

    // જો યુઝર ચિપ્સમાંથી 'વિવિધ સમિતિના ચેરમેન' સિલેક્ટ કરે ભાઈ
    if (currentCategory == 'વિવિધ સમિતિના ચેરમેન') {
      final List<String> samitiRoles = ['શિક્ષણ', 'વ્યવસ્થાપક', 'સાંસ્કૃતિક', 'મેડિકલ', 'ફંડ એકત્રિત', 'મંદિર'];
      return teamMembers.where((m) => samitiRoles.contains(m.role)).toList();
    }

    return teamMembers.where((m) => m.role == currentCategory).toList();
  }
}
