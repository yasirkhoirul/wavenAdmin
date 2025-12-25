// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_form_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BookingForm)
const bookingFormProvider = BookingFormProvider._();

final class BookingFormProvider
    extends $AsyncNotifierProvider<BookingForm, BookingFormState> {
  const BookingFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingFormHash();

  @$internal
  @override
  BookingForm create() => BookingForm();
}

String _$bookingFormHash() => r'a895abc3e72e40170bbeb510d426a8bbbf54184d';

abstract class _$BookingForm extends $AsyncNotifier<BookingFormState> {
  FutureOr<BookingFormState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<BookingFormState>, BookingFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BookingFormState>, BookingFormState>,
              AsyncValue<BookingFormState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
