// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_transaction_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(lentItems)
const lentItemsProvider = LentItemsProvider._();

final class LentItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ItemTransaction>>,
          List<ItemTransaction>,
          FutureOr<List<ItemTransaction>>
        >
    with
        $FutureModifier<List<ItemTransaction>>,
        $FutureProvider<List<ItemTransaction>> {
  const LentItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lentItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lentItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<ItemTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ItemTransaction>> create(Ref ref) {
    return lentItems(ref);
  }
}

String _$lentItemsHash() => r'760c8cb4ccaa9105b20b40eb575137c9b853ac90';

@ProviderFor(borrowedItems)
const borrowedItemsProvider = BorrowedItemsProvider._();

final class BorrowedItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ItemTransaction>>,
          List<ItemTransaction>,
          FutureOr<List<ItemTransaction>>
        >
    with
        $FutureModifier<List<ItemTransaction>>,
        $FutureProvider<List<ItemTransaction>> {
  const BorrowedItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'borrowedItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$borrowedItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<ItemTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ItemTransaction>> create(Ref ref) {
    return borrowedItems(ref);
  }
}

String _$borrowedItemsHash() => r'0c985348412a6a8f7aa69353e2bb8bb9f9b6fd80';

@ProviderFor(historyItems)
const historyItemsProvider = HistoryItemsProvider._();

final class HistoryItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ItemTransaction>>,
          List<ItemTransaction>,
          FutureOr<List<ItemTransaction>>
        >
    with
        $FutureModifier<List<ItemTransaction>>,
        $FutureProvider<List<ItemTransaction>> {
  const HistoryItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<ItemTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ItemTransaction>> create(Ref ref) {
    return historyItems(ref);
  }
}

String _$historyItemsHash() => r'5fefc32beae5d09b06a3d129b26b96d495cb1973';

@ProviderFor(lostItems)
const lostItemsProvider = LostItemsProvider._();

final class LostItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ItemTransaction>>,
          List<ItemTransaction>,
          FutureOr<List<ItemTransaction>>
        >
    with
        $FutureModifier<List<ItemTransaction>>,
        $FutureProvider<List<ItemTransaction>> {
  const LostItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lostItemsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lostItemsHash();

  @$internal
  @override
  $FutureProviderElement<List<ItemTransaction>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ItemTransaction>> create(Ref ref) {
    return lostItems(ref);
  }
}

String _$lostItemsHash() => r'ceefe2ad1ef98b6e17b0206c624fd23303e8d14b';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
