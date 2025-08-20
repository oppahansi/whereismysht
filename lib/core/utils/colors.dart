// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flex_color_scheme/flex_color_scheme.dart";

Color primaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.primary;

Color onPrimaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.onPrimary;

Color primaryContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.primaryContainer;

Color onPrimaryContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.onPrimaryContainer;

Color secondaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.secondary;

Color onSecondaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.onSecondary;

Color secondaryContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.secondaryContainer;

Color onSecondaryContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.onSecondaryContainer;

Color tertiaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.tertiary;

Color onTertiaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.onTertiary;

Color tertiaryContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.tertiaryContainer;

Color onTertiaryContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.onTertiaryContainer;

Color errorColor(BuildContext context) => Theme.of(context).colorScheme.error;

Color onErrorColor(BuildContext context) =>
    Theme.of(context).colorScheme.onError;

Color errorContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.errorContainer;

Color onErrorContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.onErrorContainer;

Color backgroundColor(BuildContext context) =>
    Theme.of(context).colorScheme.surface;

Color onBackgroundColor(BuildContext context) =>
    Theme.of(context).colorScheme.onSurface;

Color surfaceColor(BuildContext context) =>
    Theme.of(context).colorScheme.surface;

Color surfaceTintColor(BuildContext context) =>
    Theme.of(context).colorScheme.surfaceTint;

Color surfaceContainerLowColor(BuildContext context) =>
    Theme.of(context).colorScheme.surfaceContainerLow;

Color surfaceContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.surfaceContainer;

Color onSurfaceColor(BuildContext context) =>
    Theme.of(context).colorScheme.onSurface;

Color surfaceDimColor(BuildContext context) =>
    Theme.of(context).colorScheme.surfaceDim;

Color surfaceContainerHighest(BuildContext context) =>
    Theme.of(context).colorScheme.surfaceContainerHighest;

Color onSurfaceVariantColor(BuildContext context) =>
    Theme.of(context).colorScheme.onSurfaceVariant;

Color outlineColor(BuildContext context) =>
    Theme.of(context).colorScheme.outline;

Color outlineVariantColor(BuildContext context) =>
    Theme.of(context).colorScheme.outlineVariant;

Color shadowColor(BuildContext context) => Theme.of(context).colorScheme.shadow;

Color scrimColor(BuildContext context) => Theme.of(context).colorScheme.scrim;

Color inverseSurfaceColor(BuildContext context) =>
    Theme.of(context).colorScheme.inverseSurface;

Color onInverseSurfaceColor(BuildContext context) =>
    Theme.of(context).colorScheme.onInverseSurface;

Color inversePrimaryColor(BuildContext context) =>
    Theme.of(context).colorScheme.inversePrimary;

Color getColorForRating(int quality) {
  if (quality <= 5) {
    return Color.lerp(Colors.red, Colors.yellow, quality / 5)!;
  } else {
    return Color.lerp(Colors.yellow, Colors.green, (quality - 5) / 5)!;
  }
}

Color weightDiffColor(double weightDiff) {
  if (weightDiff < 0) {
    return Colors.green;
  } else if (weightDiff == 0) {
    return Colors.grey;
  } else {
    return Colors.red;
  }
}

Color get weightIconColor => Colors.greenAccent.darken(30);
