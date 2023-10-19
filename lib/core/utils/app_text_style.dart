import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  // Title text style
  static TextStyle titleTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 28,
        color: color,
      );

  static TextStyle titleTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 24,
        color: color,
      );

  static TextStyle titleTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 20,
        color: color,
      );

  // Body text style
  static TextStyle bodyTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle bodyTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle bodyTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: color,
      );

  // Button text style
  static TextStyle labelTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle labelTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle labelTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle errorTextSmail() => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.red,
      );
}
