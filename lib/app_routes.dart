import 'package:get/get.dart';
import 'package:rajya_purohit/screen/membership/registration_stepper_screen.dart';
import 'package:rajya_purohit/screen/screen.dart';

import 'bindings/bindings.dart';

List<GetPage> appPages = [

  GetPage(
      name: SplashScreen.pageId,
      page: ()=> SplashScreen(),
      binding: SplashBinding()
  ),

  GetPage(
    name: HomeScreen.pageId,
    page: () => const HomeScreen(),
    binding: HomeBinding(), // ✅ બાઈન્ડિંગ લિંક થઈ ગયું
  ),

  GetPage(
    name: AboutScreen.pageId,
    page: () => const AboutScreen(),
    binding: AboutBinding(),
  ),

  GetPage(
    name: MembershipScreen.pageId,
    page: () => const MembershipScreen(),
    binding: MembershipBinding(),
  ),

  GetPage(
    name: MissionScreen.pageId,
    page: () => const MissionScreen(),
    binding: MissionBinding(),
  ),

  GetPage(
    name: ContactScreen.pageId,
    page: () => const ContactScreen(),
    binding: ContactBinding(),
  ),

  GetPage(
    name: TeamScreen.pageId,
    page: () => const TeamScreen(),
    binding: TeamBinding(), // ➔ ✅ પ્રોપર બાઈન્ડિંગ ઇન્જેક્શન
  ),

  GetPage(
    name: '/RegistrationStepperScreen', // અથવા તમારો જે પેજ આઈડી હોય તે
    page: () => const RegistrationStepperScreen(),
    binding: RegistrationBinding(), // ✅ ખાતરી કરી લો કે આ લાઈન લખેલી છે ભાઈ
  ),

  GetPage(
    name: '/SansthaScreen',
    page: () => const SansthaScreen(),
    binding: SansthaBinding(),
  ),

  GetPage(
    name: EventScreen.pageId,
    page: () => const EventScreen(),
    binding:  EventBinding(), // 👈 તમારો નવો બાઈન્ડિંગ ક્લાસ અહીંયા લોક થઈ ગયો ભાઈ!
  ),

  GetPage(
    name: '/LoginScreen',
    page: () => const LoginScreen(),
    binding: LoginBinding(), // 👈 આપણું નવું બાઈન્ડિંગ અહીંયા લિંક કરી દીધું!
  ),

// ➔ ⚡ ⚡ અસલી જાદુ: ડેશબોર્ડ ઓપન થતાં જ બાઈન્ડિંગ ઓટોમેટિક કંટ્રોલર ઇન્જેક્ટ કરી દેશે ભાઈ!
  GetPage(
    name: '/DashboardScreen',
    page: () =>  DashboardScreen(),
    binding: DashboardBinding(), // 👈 આપણું નવું બાઈન્ડિંગ લિંક થઈ ગયું ભાઈ!
  ),
];
