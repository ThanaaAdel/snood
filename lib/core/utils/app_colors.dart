import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  static Color primary = HexColor('#E07F2D');
  static Color secondPrimary = HexColor('#1B4893');
  static Color orangeThirdPrimary = HexColor('#F15C22');
  static Color blueLiteColor = HexColor('#00B3DC');
  static Color blueTextColor = HexColor('#5663FF');
  static Color grayTextColor = HexColor('#6E7FAA');
  static Color goldStarColor = HexColor('#FFCC00');
  static Color unStarColor = HexColor('#E9E9EE');
  static Color scaffoldColor = HexColor('#F5F5F5');
  static Color avatarColor = HexColor('#96B2B5');
  static Color grayColor = HexColor('#525252');

  static Color hint = Colors.grey;
  static Color blackLite = Colors.black54;
  static Color error = Colors.red;
  static Color success = Colors.green;
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color gray = Colors.grey;
  static Color grayLite = Colors.grey[700]!;
  static Color gray1 = HexColor('#C4C4C4');
  static Color gray2 = HexColor('#BABABB');
  // static Color gray6 = HexColor('#A7A7A7');
  // static Color gray7 = HexColor('#A0A1A0');
  static Color red = HexColor('#FF0000');
  static Color blue3 = const Color(0xff3646ff);
  static Color bink = HexColor('#FF9F9F');
  static Color purple1 = HexColor('#854AA4');
  static Color purple1light = HexColor('#E3D2FE');
  static Color blue = HexColor('#2D6CB4');
  static Color baseGrayColor = HexColor('#eff3f9');
  static Color blue1 = HexColor('#2D6CB4');
  static Color blue2 = HexColor('#8290F8');
  static Color blue4 = const Color(0xff3E3F68);
  static Color bluelight = HexColor('#D7EAF9');
  static Color orange = HexColor('#E07F2D');
  static Color orangelight = HexColor('#FFEAD7');
  static Color opacityWhite = Colors.white.withOpacity(0.5);
  static Color transparent = Colors.transparent;

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lightens(String color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(HexColor(color));
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
