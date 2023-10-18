import 'package:flutter/material.dart';

class MushRoomDecoration {
  /// Creating the first instance
  static final MushRoomDecoration _instance = MushRoomDecoration._internal();

  MushRoomDecoration._internal();

  /// With this factory setup, any time  NavigationService() is called
  /// within the appication _instance will be returned and not a new instance
  factory MushRoomDecoration() => _instance;

 static Decoration create({
    bool enableLinearGradient = false,
    AlignmentGeometry beginLinearGradient = Alignment.topCenter,
    AlignmentGeometry endLinearGradient = Alignment.bottomCenter,
    Color beginColorLinearGradient = Colors.red,
    Color endColorLinearGradient = Colors.white,
    double radius = 10,
    Color borderColor = Colors.transparent,
  }) =>
      BoxDecoration(
        gradient: (enableLinearGradient)
            ? LinearGradient(
                begin: beginLinearGradient,
                end: endLinearGradient,
                colors: [
                  beginColorLinearGradient,
                  endColorLinearGradient,
                ],
              )
            : null,
        boxShadow: [
          BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.grey.withOpacity(0.5))
        ],
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(radius),
      );

}
