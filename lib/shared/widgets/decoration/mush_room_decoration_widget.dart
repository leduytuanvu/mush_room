import 'package:flutter/material.dart';

class MushRoomDecoration {
  /// Creating the first instance

  static Decoration defaultDecorationGradient({double radius = 10}) =>
      BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffBBCAFF),
            Colors.white,
          ],
        ),
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.5))
        ],
        borderRadius: BorderRadius.circular(radius),
      );

  static Decoration defaultDecoration(
          {double radius = 10,
          Color color = Colors.white,
          Color borderColor = Colors.transparent}) =>
      BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
        borderRadius: BorderRadius.circular(radius),
      );

  static Decoration defaultDecorationBottomSheet(
          {double radius = 10,
          Color color = Colors.white,
          Color borderColor = Colors.transparent}) =>
      BoxDecoration(
        color: color,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 2,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      );

  static Decoration defaultDecorationImage({
    double radius = 10,
    Color color = Colors.white,
    Color borderColor = Colors.transparent,
    required String image,
  }) =>
      BoxDecoration(
          color: color,
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill));

  Decoration defaultDecorationCircle(
          {Color color = Colors.white,
          Color borderColor = Colors.transparent}) =>
      BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
        shape: BoxShape.circle,
      );
}
