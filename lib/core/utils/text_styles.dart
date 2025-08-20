// Flutter Imports
import "package:flutter/material.dart";

TextTheme textTheme(BuildContext context) => Theme.of(context).textTheme;

TextStyle? displayLarge(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 57.0,
    minFontSize: 45.0,
    maxFontSize: 64.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: -0.25,
);

TextStyle? displayMedium(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 45.0,
    minFontSize: 36.0,
    maxFontSize: 52.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
);

TextStyle? displaySmall(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 36.0,
    minFontSize: 28.0,
    maxFontSize: 44.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
);

/// Headline styles
TextStyle? headlineLarge(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 32.0,
    minFontSize: 26.0,
    maxFontSize: 40.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
);

TextStyle? headlineMedium(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 28.0,
    minFontSize: 22.0,
    maxFontSize: 36.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
);

TextStyle? headlineSmall(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 24.0,
    minFontSize: 20.0,
    maxFontSize: 32.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.0,
);

/// Title styles
TextStyle? titleLarge(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 22.0,
    minFontSize: 18.0,
    maxFontSize: 28.0,
  ),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.0,
);

TextStyle? titleMedium(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 16.0,
    minFontSize: 14.0,
    maxFontSize: 20.0,
  ),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);

TextStyle? titleSmall(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 14.0,
    minFontSize: 12.0,
    maxFontSize: 18.0,
  ),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
);

/// Body styles
TextStyle? bodyLarge(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 16.0,
    minFontSize: 14.0,
    maxFontSize: 20.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.5,
);

TextStyle? bodyMedium(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 14.0,
    minFontSize: 12.0,
    maxFontSize: 18.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

TextStyle? bodySmall(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 12.0,
    minFontSize: 10.0,
    maxFontSize: 16.0,
  ),
  fontWeight: FontWeight.w400,
  letterSpacing: 0.4,
);

/// Label styles
TextStyle? labelLarge(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 14.0,
    minFontSize: 12.0,
    maxFontSize: 18.0,
  ),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.1,
);

TextStyle? labelMedium(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 12.0,
    minFontSize: 10.0,
    maxFontSize: 16.0,
  ),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

TextStyle? labelSmall(BuildContext context) => TextStyle(
  fontSize: _getResponsiveFontSize(
    context,
    baseFontSize: 11.0,
    minFontSize: 9.0,
    maxFontSize: 14.0,
  ),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);

double _getResponsiveFontSize(
  BuildContext context, {
  required double baseFontSize,
  double referenceWidth = 360.0,
  double referenceHeight = 640.0,
  double minFontSize = 12.0,
  double maxFontSize = 24.0,
}) {
  final size = MediaQuery.of(context).size;
  final screenWidth = size.width;
  final screenHeight = size.height;

  final widthScale = screenWidth / referenceWidth;
  final heightScale = screenHeight / referenceHeight;
  final scale = widthScale < heightScale ? widthScale : heightScale;

  final responsiveFontSize = baseFontSize * scale;
  return responsiveFontSize.clamp(minFontSize, maxFontSize);
}
