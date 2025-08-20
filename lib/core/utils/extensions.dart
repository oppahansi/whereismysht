// Flutter Imports
import "package:flutter/material.dart";

extension TextStyleFontWeightExtension on TextStyle? {
  TextStyle? withWeight(FontWeight fontWeight) =>
      this?.copyWith(fontWeight: fontWeight);
}

extension TextStyleColorExtension on TextStyle? {
  TextStyle? withColor(Color color) => this?.copyWith(color: color);
}

extension TextStyleFontSizeExtension on TextStyle? {
  TextStyle? withFontSize(double fontSize) =>
      this?.copyWith(fontSize: fontSize);
}

extension TextStyleWeightColorExtension on TextStyle? {
  TextStyle? withWeightAndColor(FontWeight fontWeight, Color color) =>
      this?.copyWith(fontWeight: fontWeight, color: color);
}

extension TextStyleFontSizeColorExtension on TextStyle? {
  TextStyle? withFontSizeAndColor(double fontSize, Color color) =>
      this?.copyWith(fontSize: fontSize, color: color);
}

extension StringCapitalizeExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}

extension BuildContextPushNamedExtension on BuildContext {
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
