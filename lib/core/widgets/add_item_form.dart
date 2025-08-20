// Dart Imports
import "dart:io";
import "dart:async";

// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_image_compress/flutter_image_compress.dart";
import "package:intl/intl.dart";
import "package:image_picker/image_picker.dart";
import "package:material_symbols_icons/symbols.dart";

// Project Imports
import "package:where_is_my_sht/core/models/item_transaction.dart";
import "package:where_is_my_sht/core/models/item_transaction_image.dart";
import "package:where_is_my_sht/core/services/item_transaction_image_service.dart";
import "package:where_is_my_sht/core/services/item_transaction_service.dart";
import "package:where_is_my_sht/core/utils/extensions.dart";
import "package:where_is_my_sht/core/utils/image_utils.dart";
import "package:where_is_my_sht/core/utils/text_styles.dart";
import "package:where_is_my_sht/feature/lent/lent_screen.dart";
import "package:where_is_my_sht/l10n/app_localizations.dart";
import "package:where_is_my_sht/main_screen.dart";

class AddItemForm extends ConsumerStatefulWidget {
  const AddItemForm({super.key});

  @override
  ConsumerState<AddItemForm> createState() => _AddLentItemFormState();
}

class _AddLentItemFormState extends ConsumerState<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _lentToController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  Map<XFile, String> images = {};

  @override
  void dispose() {
    _itemNameController.dispose();
    _lentToController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(currentTabIndexProvider);
    final localizations = AppLocalizations.of(context)!;

    var borrowedLentTo = "";
    if (currentIndex == getRouteIndex(LentScreen.path)) {
      borrowedLentTo = localizations.lent_to;
    } else {
      borrowedLentTo = localizations.borrowed_from;
    }

    _dateController.text = DateFormat.yMd().format(selectedDate);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    localizations.add_item,
                    style: titleMedium(context).withWeight(FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _itemNameController,
                  decoration: InputDecoration(
                    labelText: "${localizations.item.capitalize()}*",
                  ),
                  validator: (value) => _validateField(value, localizations),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _lentToController,
                  decoration: InputDecoration(
                    labelText: "${borrowedLentTo.capitalize()}*",
                  ),
                  validator: (value) => _validateField(value, localizations),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: localizations.note.capitalize(),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: localizations.date.capitalize(),
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      locale: Localizations.localeOf(context),
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now().add(const Duration(days: 1)),
                    );
                    if (!mounted) return;
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                        _dateController.text = DateFormat.yMd().format(picked);
                      });
                    }
                  },
                  validator: (value) => _validateField(value, localizations),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildImagePicker(context),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    onPressed: () => _submit(ref),
                    child: Text(localizations.add_item.capitalize()),
                  ),
                ),
                const SizedBox(height: 16),
                Text("* ${localizations.required_field}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(localizations.images.capitalize()),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...images.entries.map((entry) {
                final img = entry.key;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      Image.file(File(img.path), width: 60, height: 60),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              images.remove(img);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Symbols.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () async {
                    await ImageUtils.showPickImageSheet(
                      context,
                      onPicked: (file, source) async {
                        if (!mounted) return;
                        setState(() {
                          images[file] = source;
                        });
                      },
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(
                      child: Icon(Symbols.add, size: 32, color: Colors.black54),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String? _validateField(String? value, AppLocalizations localizations) {
    return value == null || value.trim().isEmpty
        ? localizations.required_field
        : null;
  }

  Future<void> _submit(WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      var itemTransactionService = ItemTransactionService();

      // Decide transaction type based on active tab
      final currentIndex = ref.read(currentTabIndexProvider);
      final isLentTab = currentIndex == getRouteIndex(LentScreen.path);
      final txType = isLentTab
          ? TransactionType.lent
          : TransactionType.borrowed;

      var transactionId = await itemTransactionService.addItem(
        ItemTransaction(
          itemName: _itemNameController.text.trim(),
          personName: _lentToController.text.trim(),
          date: selectedDate,
          type: txType,
          notes: _noteController.text.trim().isEmpty
              ? null
              : _noteController.text.trim(),
        ),
      );

      if (transactionId != 0) {
        var itemTransactionImageService = ItemTransactionImageService();
        var imagesToAdd = await Future.wait(
          images.keys.map((image) async {
            return ItemTransactionImage(
              transactionId: transactionId,
              image: await image.readAsBytes(),
            );
          }),
        );

        await itemTransactionImageService.addImages(imagesToAdd);
      }

      if (!mounted) return;

      _itemNameController.clear();
      _lentToController.clear();
      _noteController.clear();
      _dateController.clear();
      setState(() {
        images.clear();
      });

      Navigator.of(context).pop();
    }
  }
}
