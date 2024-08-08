import 'package:flutter/material.dart';

class AppColours {
  const AppColours._privateConstructor();
  static const AppColours instance = AppColours._privateConstructor();

  //!
  final Color blue = const Color(0xFF1C77FF);
  final Color purple = const Color(0xFF6420AA);
  final Color peach = const Color(0xFFFF6464);
  final Color red = const Color.fromARGB(255, 236, 13, 13);
  final Color black = const Color(0XFF171717);
  final Color white = const Color(0xFFFFFFFF);

  //! TEXT COLOURS
  final Color grey200 = const Color(0xFFEAECF0);
  final Color grey300 = const Color(0xFFD0D5DD);
  final Color grey500 = const Color(0xFF667085);
  final Color grey600 = const Color(0xFF475467);
  final Color grey700 = const Color(0xFF344054);
  final Color grey900 = const Color(0xFF101828);

  //! BUTTON SHADOWS
  final Color whiteButtonShadowGradientOne = const Color(0xFF123769);
  final Color whiteButtonShadowGradientTwo = const Color(0xFF2A3B51);
  final Color blueButtonShadowGradientOne = const Color(0xFF034CB8);
  final Color blueButtonShadowGradientTwo = const Color(0xFF19396A);
}
