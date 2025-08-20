// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(SettingsServiceNotifier)
const settingsServiceNotifierProvider = SettingsServiceNotifierProvider._();

final class SettingsServiceNotifierProvider
    extends $AsyncNotifierProvider<SettingsServiceNotifier, Settings> {
  const SettingsServiceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsServiceNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsServiceNotifierHash();

  @$internal
  @override
  SettingsServiceNotifier create() => SettingsServiceNotifier();
}

String _$settingsServiceNotifierHash() =>
    r'18a3243193b2d9bc4eb3d1cb3fccf3bab1adb0ac';

abstract class _$SettingsServiceNotifier extends $AsyncNotifier<Settings> {
  FutureOr<Settings> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Settings>, Settings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Settings>, Settings>,
              AsyncValue<Settings>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
