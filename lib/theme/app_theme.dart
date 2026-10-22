import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const dark = Color(0xFF0F2A1C);
  static const primary = Color(0xFF3A8F68);
  static const mint = Color(0xFF6FE3A8);
  static const bg = Color(0xFFF1F9F4);
  static const text = Color(0xFF12281C);
  static const muted = Color(0xFF7BA48F);
  static const border = Color(0xFFCFEBDB);
}

class AppText {
  static TextStyle display(double size, {Color color = Colors.white}) =>
      GoogleFonts.dmSerifDisplay(fontSize: size, color: color, height: 1.1);

  static TextStyle body(
    double size, {
    Color color = AppColors.text,
    FontWeight weight = FontWeight.w400,
  }) =>
      GoogleFonts.dmSans(fontSize: size, color: color, fontWeight: weight);
}

class AppAssets {
  static const farmBg = 'assets/images/farm_bg.jpg';
}