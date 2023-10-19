import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  // Title text style
  static TextStyle titleTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: color,
      );
  static TextStyle titleTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      );
  static TextStyle titleTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: color,
      );

  // Body text style
  static TextStyle bodyTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle bodyTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle bodyTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: color,
      );

  // Normal text style
  static TextStyle normalTextStyle(
          {Color color = Colors.black, double size = 16}) =>
      GoogleFonts.poppins(
        fontSize: size,
        fontWeight: FontWeight.normal,
        color: color,
      );

  // Error text style
  static TextStyle errorTextStyleSmall({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: Colors.red,
      );
}
