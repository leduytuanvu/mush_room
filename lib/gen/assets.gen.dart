/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/icon_add.png
  AssetGenImage get iconAdd => const AssetGenImage('assets/icons/icon_add.png');

  /// File path: assets/icons/icon_bell.png
  AssetGenImage get iconBell =>
      const AssetGenImage('assets/icons/icon_bell.png');

  /// File path: assets/icons/icon_loading.png
  AssetGenImage get iconLoading =>
      const AssetGenImage('assets/icons/icon_loading.png');

  /// File path: assets/icons/icon_logo_app.png
  AssetGenImage get iconLogoApp =>
      const AssetGenImage('assets/icons/icon_logo_app.png');

  /// File path: assets/icons/icon_notifcation_green.png
  AssetGenImage get iconNotifcationGreen =>
      const AssetGenImage('assets/icons/icon_notifcation_green.png');

  /// File path: assets/icons/icon_profile.png
  AssetGenImage get iconProfile =>
      const AssetGenImage('assets/icons/icon_profile.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        iconAdd,
        iconBell,
        iconLoading,
        iconLogoApp,
        iconNotifcationGreen,
        iconProfile
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/onboarding_1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding_1.png');

  /// List of all assets
  List<AssetGenImage> get values => [onboarding1];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/icon_home.svg
  String get iconHome => 'assets/svgs/icon_home.svg';

  /// File path: assets/svgs/icon_profile.svg
  String get iconProfile => 'assets/svgs/icon_profile.svg';

  /// List of all assets
  List<String> get values => [iconHome, iconProfile];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
