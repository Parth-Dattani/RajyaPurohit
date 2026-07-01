// ---------------------------------------------------------------------------
// 4. THEME & COLORS
// ---------------------------------------------------------------------------
import 'dart:ui';

import '../model/disaser_event.dart';

class AppColors {

  // ✅ રાજપુરોહિત ઓનલાઇન થીમના ગ્લોબલ કલર્સ
  // 🌐 Surface
  static const Color background = Color(0xFFFDFBF7);
  static const Color surface = Color(0xFFFFFFFF);

  // 🎨 Brand
  static const Color primary = Color(0xFF1E3A8A);
  static const Color primaryDark = Color(0xFF0F2C4F);
  static const Color secondary = Color(0xFF1E5AA8);

  // ✨ Accent
  static const Color accent = Color(0xFFD4AF37);
  static const Color accentDark = Color(0xFFB88A16);

  // 📝 Text
  static const Color heading = Color(0xFF12355B);
  static const Color body = Color(0xFF374151);
  static const Color subtitle = Color(0xFF6B7280);
  static const Color whiteText = Color(0xFFFFFFFF);

  // 🔘 Button
  static const Color buttonPrimary = primary;
  static const Color buttonPrimaryHover = primaryDark;

  static const Color buttonSecondary = accent;
  static const Color buttonSecondaryHover = accentDark;

  // 📦 Card
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE5E7EB);

  // 🧱 Divider
  static const Color divider = Color(0xFFE2E8F0);

  // 🧭 Navigation
  static const Color navigationBackground = Color(0xFFFFFFFF);
  static const Color navigationText = heading;
  static const Color navigationActive = accent;

  // 🦶 Footer
  static const Color footerBackground = primary;
  static const Color footerHeading = Color(0xFFFFFFFF);
  static const Color footerText = Color(0xFFD6E4F0);
  static const Color footerIcon = accent;

  // 🎯 Icon
  static const Color icon = heading;
  static const Color iconAccent = accent;

  // 🚨 Status
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);



  static const Color bgCream = Color(0xFFF9F6EE);      // બેકગ્રાઉન્ડ ક્રીમ
  //static const Color textMaroon = Color(0xFF4A1525);   // લખાણનો મરૂન
  static const Color textMaroon = Color(0xFF12355B);   // લખાણનો મરૂન
  static const Color textOrange = Color(0xFFFF4500);   // હાઈલાઈટ ઓરેન્જ
  static const Color btnYellow = Color(0xFFFFC107);    // સંપર્ક બટનનો પીળો
  static const Color sectionMaroon = Color(0xFF5A062D); // ૨જો સેક્શન ડાર્ક મરૂન
  static const Color imageBgGrey = Color(0xFFE0E0E0);   // Colors.black12 જેવો લાઈટ ગ્રે
  static const Color imageIconGrey = Color(0xFF9E9E9E);


  static const Color deepSpaceBlue = Color(0xFF0a1628);
  static const Color twilightPurple = Color(0xFF4A3B6B);
  static const Color darkerNav = Color(0xFF151932);

  static const Color urgentRed = Color(0xFFFF5252);
  static const Color alertsBg = Color(0xFF1A2840);
  static const Color warningOrange = Color(0xFFff6644);
  static const Color healingTeal = Color(0xFF00ffaa);
  static const Color hopeGreen = Color(0xFF81C784);
  static const Color tealDark = Color(0xFF26A69A);

  static const Color tornadoPurple = Color(0xFF9C27B0);
  static const Color droughtBrown = Color(0xFF8D6E63);
  static const Color volcanoDarkRed = Color(0xFFD32F2F);

  static const Color cardBg = Color(0xFF252A40);
  static const Color textGrey = Color(0xFFB0B3C7);

  static Color getColorForEvent(DisasterEvent event) {
    if (event.eventType == 'TO') return tornadoPurple;
    if (event.eventType == 'DR') return droughtBrown;
    if (event.eventType == 'VO') return volcanoDarkRed;

    final l = event.alertLevel.toLowerCase();
    if (l.contains('red')) return urgentRed;
    if (l.contains('orange')) return warningOrange;
    return hopeGreen;
  }
}