import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rajya_purohit/bindings/splash_binding.dart';
import 'package:rajya_purohit/screen/screen.dart';

import 'app_routes.dart';
import 'utils/shared_preferences_helper.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferencesHelper.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RajyaPurohit Jamnagar',
      theme: ThemeData(
        //textTheme: GoogleFonts.notoSansGujaratiTextTheme(Theme.of(context).textTheme),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'NotoSansGujarati',
        ),
        typography: Typography.material2021(platform: TargetPlatform.iOS),
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      initialRoute: kIsWeb ? Get.routing.current : SplashScreen.pageId,
      initialBinding: SplashBinding(),
      getPages: appPages,
      debugShowCheckedModeBanner: false,
      checkerboardRasterCacheImages: false,
      unknownRoute: appPages.first,
      // // ✅ SEO: Listen to route changes and update canonical tags
      // navigatorObservers: kIsWeb ? [_SEONavigatorObserver()] : [],
    );
  }
}
