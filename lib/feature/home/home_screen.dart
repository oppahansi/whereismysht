// Flutter Imports
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";

// Project Imports
import "package:where_is_my_sht/core/widgets/debug_settings_controlls.dart";
import "package:where_is_my_sht/feature/home/home_summary.dart";

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String path = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (kDebugMode) DebugSettingsControlls(),
          const HomeSummary(),
        ],
      ),
    );
  }
}
