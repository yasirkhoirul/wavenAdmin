import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';
import 'package:wavenadmin/persentation/riverpod/state/booking_list_state.dart';

part 'booking_notifier.g.dart';

@riverpod
class BookingNotifier extends _$BookingNotifier {
  static const int limit = 10;

  @override
  Future<BookingListState> build({String? search, Sort? sort}) async {
    final response = await AsyncValue.guard(() {
      final usecase = ref.read(getListBooking);
      return usecase.execute(1, limit, sort: sort, search: search);
    });

    if (response.hasError) {
      throw response.error!;
    }

    final responseData = response.requireValue;
    Logger().d("ini adalah respond pertama kali ${responseData.bookings}");
    return BookingListState().replaceData(responseData);
  }

  Future<void> loadMore({String? search, Sort? sort}) async {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.isLoadingMore || !current.hasMore) return;

    final nextPage = current.currentPage + 1;
    
    // Cek apakah sudah pernah load page ini
    if (nextPage <= current.highestPage) {
      state = AsyncValue.data(current.copyWith(currentPage: nextPage));
      return;
    }

    // Set loading more
    state = AsyncValue.data(current.copyWith(isLoadingMore: true));

    final response = await AsyncValue.guard(() {
      final usecase = ref.read(getListBooking);
      return usecase.execute(nextPage, limit, search: search, sort: sort);
    });

    if (response.hasError) {
      state = AsyncValue.data(
        current.copyWith(isLoadingMore: false, error: response.error),
      );
      return;
    }

    state = AsyncValue.data(current.appendData(response.requireValue));
  }

  void prevPage() {
    final current = state.asData?.value;
    if (current == null || current.currentPage <= 0) return;
    
    state = AsyncValue.data(current.copyWith(currentPage: current.currentPage - 1));
  }
}