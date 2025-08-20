// Flutter Imports
import "package:flutter/cupertino.dart";

// Package Imports
import "package:flex_color_scheme/flex_color_scheme.dart";

final light = FlexThemeData.light(
  // Using FlexColorScheme built-in FlexScheme enum based colors
  scheme: FlexScheme.deepBlue,
  // Component theme configurations for light mode.
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
  ),
  // Direct ThemeData properties.
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
);

// The FlexColorScheme defined dark mode ThemeData.
final dark = FlexThemeData.dark(
  // Using FlexColorScheme built-in FlexScheme enum based colors.
  scheme: FlexScheme.deepBlue,
  // Component theme configurations for dark mode.
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    blendOnColors: true,
    useM2StyleDividerInM3: true,
    inputDecoratorIsFilled: true,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    alignedDropdown: true,
    navigationRailUseIndicator: true,
  ),
  // Direct ThemeData properties.
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
);
