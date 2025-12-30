import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/photographer_booking.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_bookings.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_booking_state.dart';

part 'photographer_booking_notifier.g.dart';

@riverpod
class PhotographerBookingNotifier extends _$PhotographerBookingNotifier {
  @override
  PhotographerBookingState build(
    String photographerId,
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    // Defer the data fetch to avoid setting state during build
    Future.microtask(() => _fetchData());
    return PhotographerBookingState.initial();
  }

  Future<void> _fetchData() async {
    state = state.copyWith(requestState: RequestState.loading);

    try {
      final usecase = locator<GetPhotographerBookings>();
      final response = await usecase.execute(
        photographerId,
        page,
        limit,
        search: search,
        startTime: startTime,
        endTime: endTime,
      );

      final bookings = response.data.map((booking) => booking.toEntity()).toList();

      state = state.copyWith(
        items: bookings,
        metadata: response.metadata==null?PhotographerBookingMetadata(count: 0, totalPages: 0, page: 0, limit: limit): response.metadata!.toEntity(),
        currentPage: response.metadata==null?0: response.metadata!.page - 1,
        requestState: RequestState.succes,
        message: response.message,
      );
    } catch (e) {
      state = state.copyWith(
        requestState: RequestState.error,
        message: e.toString(),
      );
    }
  }

  Future<void> appendData() async {
    if (state.metadata == null) return;

    final nextPage = state.currentPage + 1;
    if (nextPage >= state.metadata!.totalPages) return;

    try {
      final usecase = locator<GetPhotographerBookings>();
      final response = await usecase.execute(
        photographerId,
        nextPage + 1,
        limit,
        search: search,
        startTime: startTime,
        endTime: endTime,
      );

      final bookings = response.data.map((booking) => booking.toEntity()).toList();

      state = state.copyWith(
        items: [...state.items, ...bookings],
        metadata: response.metadata==null?PhotographerBookingMetadata(count: 0, totalPages: 0, page: 0, limit: limit):response.metadata!.toEntity(),
        currentPage: nextPage,
      );
    } catch (e) {
      state = state.copyWith(
        requestState: RequestState.error,
        message: e.toString(),
      );
    }
  }

  Future<void> back() async {
    if (state.currentPage <= 0) return;

    state = state.copyWith(
      currentPage: state.currentPage - 1,
    );
  }

  Future<void> refresh() async {
    await _fetchData();
  }
}
