import 'package:get/get.dart';
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

];
