import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/common/deep_link_handler.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';
import 'package:wavenadmin/persentation/riverpod/state/booking_list_state.dart';

part 'booking_notifier.g.dart';

@riverpod
class BookingNotifier extends _$BookingNotifier {
  static const int limit = 10;

  @override
  Future<BookingListState> build({String? search, Sort? sort, SortBooking? sortBy}) async {
    final response = await AsyncValue.guard(() {
      final usecase = ref.read(getListBooking);
      return usecase.execute(1, limit, sort: sort, search: search, sortBy: sortBy);
    });

    if (response.hasError) {
      throw response.error!;
    }

    final responseData = response.requireValue;
    Logger().d("ini adalah respond pertama kali ${responseData.bookings}");
    _listen();
    return BookingListState().replaceData(responseData);
  }

  void _listen(){
    DeepLinkHandler().onPaymentResult = (bookingId,status,params){
      Logger().i('Payment callback received in BookingForm - Booking: $bookingId, Status: $status');
      
      // Check if provider is still mounted before accessing state
      if (!ref.mounted) {
        Logger().w('BookingForm provider is disposed, skipping state update');
        return;
      }
      
      // You can handle the payment result here
      // For example: show dialog, refresh booking list, navigate to booking detail, etc.
      final currentState = state.value;
      if (currentState == null) return;
      
      if (status.toLowerCase() == 'success' || status.toLowerCase() == 'settlement') {
        state = AsyncValue.data(
          currentState.copyWith(
            bookingId: bookingId,
            bookingStatus: status
          ),
        );
        Logger().i('Payment successful for booking: $bookingId');
        // TODO: Show success dialog or navigate to booking detail
      } else {
        state = AsyncValue.data(
          currentState.copyWith(
            bookingId: bookingId,
            bookingStatus: status
          ),
        );
        Logger().w('Payment failed/cancelled for booking: $bookingId');
      }
    };
  }

  void onResetBookingResult(){
    Logger().d("ini dipanggil");
    final current = state.asData?.value;
    if (current == null) return;
    state == AsyncValue.data(
      current.copyWith(
        bookingId: null,
        bookingStatus: null
      )
    );
  }

  Future<void> loadMore({String? search, Sort? sort, SortBooking? sortBy}) async {
    final current = state.asData?.value;
    if (current == null) return;
    
    if (current.isLoadingMore) return;

    final nextPage = current.currentPage + 1;
    

    if (nextPage <= current.highestPage) {
      state = AsyncValue.data(current.copyWith(currentPage: nextPage,isLoading: false));
      return;
    }
    if (!current.hasMore)return;
    // Update highestPage dan set loading more sekaligus
    state = AsyncValue.data(current.copyWith(
      highestPage: nextPage,
      isLoadingMore: true,
    ));
    Logger().d("highestPage setelah update = $nextPage, currentPage = ${current.currentPage}");

    final response = await AsyncValue.guard(() {
      final usecase = ref.read(getListBooking);
      return usecase.execute(nextPage + 1, limit, search: search, sort: sort, sortBy: sortBy);
    });

    if (response.hasError) {
      final latest = state.asData?.value ?? current;
      state = AsyncValue.data(
        latest.copyWith(isLoadingMore: false, error: response.error),
      );
      return;
    }

    final latest = state.asData?.value ?? current;
    state = AsyncValue.data(latest.appendData(response.requireValue));
  }

  void prevPage() {
    final current = state.asData?.value;
    if (current == null || current.currentPage <= 0) return;
    
    state = AsyncValue.data(current.copyWith(currentPage: current.currentPage - 1));
  }
}