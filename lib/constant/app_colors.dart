// ---------------------------------------------------------------------------
// 4. THEME & COLORS
// ---------------------------------------------------------------------------
import 'dart:ui';

import '../model/disaser_event.dart';

class AppColors {

  // ✅ રાજપુરોહિત ઓનલાઇન થીમના ગ્લોબલ કલર્સ
  static const Color bgCream = Color(0xFFF9F6EE);      // બેકગ્રાઉન્ડ ક્રીમ
  static const Color textMaroon = Color(0xFF4A1525);   // લખાણનો મરૂન
  static const Color textOrange = Color(0xFFFF4500);   // હાઈલાઈટ ઓરેન્જ
  static const Color btnYellow = Color(0xFFFFC107);    // સંપર્ક બટનનો પીળો
  static const Color sectionMaroon = Color(0xFF5A062D); // ૨જો સેક્શન ડાર્ક મરૂન


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