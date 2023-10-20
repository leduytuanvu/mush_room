import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppTextStyle {
  // Title text style
  static TextStyle titleTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 24.sp,
        color: color,
      );

  static TextStyle titleTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 20.sp,
        color: color,
      );

  static TextStyle titleTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 16.sp,
        color: color,
      );
  static TextStyle titleTextStyleH4({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
        color: color,
      );

  // Body text style
  static TextStyle bodyTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle bodyTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle bodyTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );
  static TextStyle bodyTextStyleH4({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );
  // Button text style
  static TextStyle labelTextStyleH1({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 22.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle labelTextStyleH2({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle labelTextStyleH3({Color color = Colors.black}) =>
      GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
        color: color,
      );

  static TextStyle smailText({Color color = Colors.grey})=>GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: color,
  );
  static TextStyle errorText()=>GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Colors.red,
  );

}
