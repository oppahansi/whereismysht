// Dart Imports
import "dart:async";
import "dart:io";

// Flutter Imports
import "package:flutter/material.dart";

// Package Imports
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_image_compress/flutter_image_compress.dart";
import "package:image_picker/image_picker.dart";
import "package:intl/intl.dart";
import "package:material_symbols_icons/symbols.dart";

// Project Imports
import "package:lendnborrow/core/models/item_transaction.dart";
import "package:lendnborrow/core/models/item_transaction_image.dart";
import "package:lendnborrow/core/services/item_transaction_service.dart";
import "package:lendnborrow/core/services/item_transaction_image_service.dart";
import "package:lendnborrow/core/provider/item_transaction_provider.dart";
import "package:lendnborrow/core/utils/extensions.dart";
import "package:lendnborrow/core/utils/colors.dart";
import "package:lendnborrow/core/utils/image_utils.dart";
import "package:lendnborrow/core/utils/text_styles.dart";
import "package:lendnborrow/l10n/app_localizations.dart";

class EditItemForm extends ConsumerStatefulWidget {
  final ItemTransaction item;

  const EditItemForm({super.key, required this.item});

  @override
  ConsumerState<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends ConsumerState<EditItemForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _itemNameController;
  late final TextEditingController _personController;
  late final TextEditingController _noteController;
  late final TextEditingController _dateController;

  late DateTime selectedDate;
  // Existing images from DB
  List<ItemTransactionImage> _existingImages = [];
  // Track deletions (by existing image id)
  final Set<int> _deletedImageIds = {};
  // Newly added images in this session (file + source label)
  final Map<XFile, String> _newImages = {};

  @override
  void initState() {
    super.initState();
    selectedDate = widget.item.date;
    _itemNameController = TextEditingController(text: widget.item.itemName);
    _personController = TextEditingController(text: widget.item.personName);
    _noteController = TextEditingController(text: widget.item.notes ?? "");
    _dateController = TextEditingController(
      text: DateFormat.yMd().format(widget.item.date),
    );
    // Load existing images
    // It's safe to assume edit form receives a persisted item with non-null id
    if (widget.item.id != null) {
      _loadImages(widget.item.id!);
    }
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _personController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _loadImages(int transactionId) async {
    final images = await ItemTransactionImageService().getImagesForTransaction(
      transactionId,
    );
    if (!mounted) return;
    setState(() {
      _existingImages = images;
      _deletedImageIds.clear();
    });
  }

  String? _validateField(String? value, AppLocalizations l10n) {
    return value == null || value.trim().isEmpty ? l10n.required_field : null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // 1) Update base item
    await ItemTransactionService().updateItem(
      ItemTransaction(
        id: widget.item.id,
        itemName: _itemNameController.text.trim(),
        personName: _personController.text.trim(),
        date: selectedDate,
        notes: _noteController.text.trim().isEmpty
            ? null
            : _noteController.text.trim(),
        type: widget.item.type,
        wasReturned: widget.item.wasReturned,
        returnedDate: widget.item.returnedDate,
      ),
    );

    // 2) Apply image changes (delete removed, add new)
    if (widget.item.id != null) {
      final imageService = ItemTransactionImageService();
      // Delete marked images
      if (_deletedImageIds.isNotEmpty) {
        await Future.wait(
          _deletedImageIds.map((id) => imageService.deleteImage(id)),
        );
      }
      // Add newly picked images
      if (_newImages.isNotEmpty) {
        final toAdd = await Future.wait(
          _newImages.keys.map((x) async {
            final bytes = await x.readAsBytes();
            return ItemTransactionImage(
              transactionId: widget.item.id!,
              image: bytes,
            );
          }),
        );
        await imageService.addImages(toAdd);
      }
    }

    // Refresh only the active list (lent or borrowed)
    switch (widget.item.type) {
      case TransactionType.lent:
        ref.invalidate(lentItemsProvider);
        break;
      case TransactionType.borrowed:
        ref.invalidate(borrowedItemsProvider);
        break;
      case TransactionType.lost:
        // no-op; type will be lent/borrowed for lost entries
        break;
    }
    if (widget.item.wasLost) {
      ref.invalidate(lostItemsProvider);
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final personLabel = switch (widget.item.type) {
      TransactionType.lent => localizations.lent_to,
      TransactionType.borrowed => localizations.borrowed_from,
      TransactionType.lost => localizations.lost_to, // generic label
    }.capitalize();

    return Material(
      color: surfaceDimColor(context),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      localizations.edit_item,
                      style: titleMedium(context).withWeight(FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _itemNameController,
                    decoration: InputDecoration(
                      labelText: "${localizations.item.capitalize()}*",
                    ),
                    validator: (v) => _validateField(v, localizations),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _personController,
                    decoration: InputDecoration(labelText: "$personLabel*"),
                    validator: (v) => _validateField(v, localizations),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
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
                        lastDate: DateTime(2100),
                      );
                      if (!mounted) return;
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          _dateController.text = DateFormat.yMd().format(
                            picked,
                          );
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildImageEditor(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: Text(localizations.update.capitalize()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageEditor(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final existingVisible = _existingImages.where(
      (img) => img.id != null && !_deletedImageIds.contains(img.id!),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.images.capitalize()),
        const SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Existing images
              ...existingVisible.map((img) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      Image.memory(
                        img.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (img.id != null) {
                              setState(() {
                                _deletedImageIds.add(img.id!);
                              });
                            }
                          },
                          child: Container(
                            decoration: const BoxDecoration(
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
              // Newly added images this session
              ..._newImages.entries.map((entry) {
                final file = entry.key;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Stack(
                    children: [
                      Image.file(
                        File(file.path),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _newImages.remove(file);
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
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
              // Add button
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () async {
                    await ImageUtils.showPickImageSheet(
                      context,
                      onPicked: (file, source) async {
                        if (!mounted) return;
                        setState(() {
                          _newImages[file] = source;
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
}
