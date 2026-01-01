// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BookingNotifier)
const bookingProvider = BookingNotifierFamily._();

final class BookingNotifierProvider
    extends $AsyncNotifierProvider<BookingNotifier, BookingListState> {
  const BookingNotifierProvider._({
    required BookingNotifierFamily super.from,
    required ({String? search, Sort? sort, SortBooking? sortBy}) super.argument,
  }) : super(
         retry: null,
         name: r'bookingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookingNotifierHash();

  @override
  String toString() {
    return r'bookingProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  BookingNotifier create() => BookingNotifier();

  @override
  bool operator ==(Object other) {
    return other is BookingNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookingNotifierHash() => r'1b667b942014d15b5069fb6381ef10b839973701';

final class BookingNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          BookingNotifier,
          AsyncValue<BookingListState>,
          BookingListState,
          FutureOr<BookingListState>,
          ({String? search, Sort? sort, SortBooking? sortBy})
        > {
  const BookingNotifierFamily._()
    : super(
        retry: null,
        name: r'bookingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookingNotifierProvider call({
    String? search,
    Sort? sort,
    SortBooking? sortBy,
  }) => BookingNotifierProvider._(
    argument: (search: search, sort: sort, sortBy: sortBy),
    from: this,
  );

  @override
  String toString() => r'bookingProvider';
}

abstract class _$BookingNotifier extends $AsyncNotifier<BookingListState> {
  late final _$args =
      ref.$arg as ({String? search, Sort? sort, SortBooking? sortBy});
  String? get search => _$args.search;
  Sort? get sort => _$args.sort;
  SortBooking? get sortBy => _$args.sortBy;

  FutureOr<BookingListState> build({
    String? search,
    Sort? sort,
    SortBooking? sortBy,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      search: _$args.search,
      sort: _$args.sort,
      sortBy: _$args.sortBy,
    );
    final ref =
        this.ref as $Ref<AsyncValue<BookingListState>, BookingListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BookingListState>, BookingListState>,
              AsyncValue<BookingListState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
