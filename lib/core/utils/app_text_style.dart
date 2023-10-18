import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {

  // Title text style
  static TextStyle titleTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: color,
      );
  static TextStyle titleTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: color,
      );
  static TextStyle titleTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      );
  static TextStyle titleTextStyleH4({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
      );

  static TextStyle bodyTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 30,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle bodyTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 26,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle bodyTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle bodyTextStyleH4({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle normanText({Color color = Colors.black,double size = 16}) =>
      GoogleFonts.roboto(
        fontSize: size,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle errorTextSmail({Color color = Colors.black}) =>
      GoogleFonts.roboto(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: Colors.red,
      );
}
