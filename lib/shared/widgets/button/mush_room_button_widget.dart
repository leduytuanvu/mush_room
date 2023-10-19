import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_constants.dart';

class MushRoomButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final List<Color> gradientColors;
  final TextStyle textStyle;
  final Alignment gradientBegin;
  final Alignment gradientEnd;
  final double width;
  final double height;
  final double borderRadius;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final double paddingAll;
  final double paddingHorizontal;
  final double paddingVertical;

  const MushRoomButtonWidget({
    Key? key,
    required this.label,
    required this.onPressed,
    this.gradientColors = const [
      AppConstants.buttonColor,
      AppConstants.buttonColor,
    ],
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 8.0,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
    this.paddingLeft = 0.0,
    this.paddingRight = 0.0,
    this.paddingAll = 0.0,
    this.paddingHorizontal = 0.0,
    this.paddingVertical = 0.0,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: paddingAll != 0.0
          ? EdgeInsets.all(paddingAll)
          : ((paddingHorizontal != 0.0 || paddingVertical != 0.0)
              ? EdgeInsets.symmetric(
                  horizontal: paddingHorizontal, vertical: paddingVertical)
              : EdgeInsets.only(
                  left: paddingLeft,
                  right: paddingRight,
                  top: paddingTop,
                  bottom: paddingBottom)),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: gradientBegin,
            end: gradientEnd,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Center(
              child: Text(
                label,
                style: textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
