// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:material_symbols_icons/symbols.dart";

// Project Imports
import "package:lendnborrow/core/services/native_backup.dart";
import "package:lendnborrow/core/utils/colors.dart";
import "package:lendnborrow/core/utils/extensions.dart";
import "package:lendnborrow/core/utils/screen_sizes.dart";
import "package:lendnborrow/core/utils/text_styles.dart";
import "package:lendnborrow/l10n/app_localizations.dart";

class ExImportSetting extends StatelessWidget {
  const ExImportSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        SizedBox(
          width: screenWidth(context, 0.90),
          child: Row(
            children: [
              Icon(Symbols.warning, color: errorColor(context)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  localizations.export_import_hint,
                  style: bodySmall(context).withColor(errorColor(context)),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Symbols.save_alt),
          title: Text(localizations.export_db),
          subtitle: Text(localizations.save_backup_to),
          onTap: () async {
            try {
              final ok = await NativeBackup.exportWithPicker();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    ok
                        ? localizations.export_success
                        : localizations.export_canceled,
                  ),
                ),
              );
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.export_failed)),
              );
            }
          },
        ),
        ListTile(
          leading: const Icon(Symbols.restore),
          title: Text(localizations.import_db),
          subtitle: Text(localizations.pick_a_backup_file),
          onTap: () async {
            final confirm = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(localizations.restore_db),
                content: Text(localizations.restore_warning),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text(localizations.cancel.capitalize()),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: Text(localizations.restore.capitalize()),
                  ),
                ],
              ),
            );
            if (confirm != true) return;
            try {
              final ok = await NativeBackup.importWithPicker();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    ok
                        ? localizations.restore_done_restart
                        : localizations.import_canceled,
                  ),
                ),
              );
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.import_failed)),
              );
            }
          },
        ),
      ],
    );
  }
}
