// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppBarColorViewModel)
final appBarColorViewModelProvider = AppBarColorViewModelProvider._();

final class AppBarColorViewModelProvider
    extends $NotifierProvider<AppBarColorViewModel, Color> {
  AppBarColorViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appBarColorViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appBarColorViewModelHash();

  @$internal
  @override
  AppBarColorViewModel create() => AppBarColorViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Color value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Color>(value),
    );
  }
}

String _$appBarColorViewModelHash() =>
    r'caedddecc5101c6ab439d8648a3bf0e7cf16e593';

abstract class _$AppBarColorViewModel extends $Notifier<Color> {
  Color build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Color, Color>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Color, Color>,
              Color,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
