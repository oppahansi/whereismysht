// Dart Imports
import "dart:async";
import "dart:io";
import "dart:typed_data";
import "dart:ui" as ui;

// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_image_compress/flutter_image_compress.dart";
import "package:image_picker/image_picker.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:path_provider/path_provider.dart";

// Project Imports
import "package:lendnborrow/l10n/app_localizations.dart";

class ImageUtils {
  static const int defaultMaxBytes = 2 * 1024 * 1024; // 2 MB
  static const int firstTargetQuality = 80;
  static const int secondTargetQuality = 50;
  static const int defaultMaxSide = 1280;

  static Future<void> showPickImageSheet(
    BuildContext context, {
    required Future<void> Function(XFile file, String source) onPicked,
    int maxBytes = defaultMaxBytes,
    int maxSide = defaultMaxSide,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final picker = ImagePicker();

    await showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Symbols.camera_alt),
            title: Text(localizations.take_photo),
            onTap: () async {
              final picked = await picker.pickImage(source: ImageSource.camera);

              if (!context.mounted) {
                return;
              }

              await _processPicked(
                context,
                picked,
                "camera",
                onPicked,
                maxBytes,
                maxSide,
              );
            },
          ),
          ListTile(
            leading: const Icon(Symbols.photo_library),
            title: Text(localizations.pick_from_gallery),
            onTap: () async {
              final picked = await picker.pickImage(
                source: ImageSource.gallery,
              );

              if (!context.mounted) {
                return;
              }

              await _processPicked(
                context,
                picked,
                "gallery",
                onPicked,
                maxBytes,
                maxSide,
              );
            },
          ),
        ],
      ),
    );
  }

  static Future<void> _processPicked(
    BuildContext context,
    XFile? picked,
    String source,
    Future<void> Function(XFile file, String source) onPicked,
    int maxBytes,
    int maxSide,
  ) async {
    if (picked != null) {
      final compressed = await compressToLimits(
        picked,
        maxBytes: maxBytes,
        maxSide: maxSide,
      );

      if (!context.mounted) {
        return;
      }

      if (compressed != null) {
        await onPicked(compressed, source);

        if (!context.mounted) {
          return;
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Image is too large even after compression (max 2 MB).",
              ),
            ),
          );
        }
      }
    }
    if (context.mounted) Navigator.of(context).pop();
  }

  static Future<XFile?> compressToLimits(
    XFile picked, {
    int maxBytes = defaultMaxBytes,
    int maxSide = defaultMaxSide,
  }) async {
    final tempDir = await getTemporaryDirectory();

    final bytes = await File(picked.path).readAsBytes();
    final img = await _decodeImage(bytes);

    int? targetW;
    int? targetH;
    if (img.width > maxSide || img.height > maxSide) {
      if (img.width >= img.height) {
        targetW = maxSide;
        targetH = (img.height * maxSide / img.width).round();
      } else {
        targetH = maxSide;
        targetW = (img.width * maxSide / img.height).round();
      }
    }

    // Try quality=80 first
    final pathQ80 =
        "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_q80_${picked.name}";
    XFile? q80File;
    if (targetW != null && targetH != null) {
      q80File = await FlutterImageCompress.compressAndGetFile(
        picked.path,
        pathQ80,
        quality: firstTargetQuality,
        minWidth: targetW,
        minHeight: targetH,
        keepExif: true,
      );
    } else {
      q80File = await FlutterImageCompress.compressAndGetFile(
        picked.path,
        pathQ80,
        quality: firstTargetQuality,
        keepExif: true,
      );
    }
    if (q80File != null && await q80File.length() <= maxBytes) return q80File;

    // Fallback quality=50
    final pathQ50 =
        "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_q50_${picked.name}";
    XFile? q50File;
    if (targetW != null && targetH != null) {
      q50File = await FlutterImageCompress.compressAndGetFile(
        picked.path,
        pathQ50,
        quality: secondTargetQuality,
        minWidth: targetW,
        minHeight: targetH,
        keepExif: true,
      );
    } else {
      q50File = await FlutterImageCompress.compressAndGetFile(
        picked.path,
        pathQ50,
        quality: secondTargetQuality,
        keepExif: true,
      );
    }
    if (q50File != null && await q50File.length() <= maxBytes) return q50File;

    return null;
  }

  // Public: decode bytes to ui.Image (dimensions).
  static Future<ui.Image> _decodeImage(List<int> bytes) {
    final completer = Completer<ui.Image>();
    ui.decodeImageFromList(Uint8List.fromList(bytes), (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }
}
