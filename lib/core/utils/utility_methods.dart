// Dart Imports
import 'dart:typed_data';

// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:material_symbols_icons/symbols.dart';

// Project Imports
import 'package:lendnborrow/l10n/app_localizations.dart';

Future<void> showImageModal(BuildContext context, Uint8List bytes) async {
  final localizations = AppLocalizations.of(context)!;

  await showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(250),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: InteractiveViewer(
                minScale: 0.75,
                maxScale: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(bytes, fit: BoxFit.contain),
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  tooltip: localizations.close,
                  style: IconButton.styleFrom(backgroundColor: Colors.black54),
                  icon: const Icon(Symbols.close, color: Colors.white),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
