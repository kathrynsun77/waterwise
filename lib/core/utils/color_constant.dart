import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color whiteA7005e = fromHex('#5effffff');

  static Color indigo100 = fromHex('#c7c9d9');

  static Color black900 = fromHex('#000000');

  static Color blueGray400 = fromHex('#6f9c95');

  static Color gray800 = fromHex('#404040');

  static Color blueGray500 = fromHex('#668e87');

  static Color blueGray700 = fromHex('#4a6964');

  static Color deepPurpleA200 = fromHex('#6e5de7');

  static Color blueGray4003d = fromHex('#3d6f9c95');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray300 = fromHex('#dde5e9');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
