// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project Imports
import 'package:where_is_my_sht/core/utils/colors.dart';
import 'package:where_is_my_sht/core/utils/extensions.dart';
import 'package:where_is_my_sht/core/utils/text_styles.dart';
import 'package:where_is_my_sht/main_screen.dart';

class SectionTitle extends ConsumerWidget {
  const SectionTitle({super.key, required this.title, required this.path});

  final String title;
  final String path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: bodyMedium(context).withColor(primaryColor(context)),
        ),
        IconButton(
          icon: const Icon(Symbols.keyboard_arrow_right),
          onPressed: () {
            ref.read(currentTabIndexProvider.notifier).state = getRouteIndex(
              path,
            );
          },
        ),
      ],
    );
  }
}
