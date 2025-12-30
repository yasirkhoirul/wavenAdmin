import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/photographer_payment.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_payment_list.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_payment_state.dart';

part 'photographer_payment_notifier.g.dart';

enum SortPhotographerPayment { name, status }

@riverpod
class PhotographerPaymentNotifier extends _$PhotographerPaymentNotifier {
  @override
  PhotographerPaymentState build(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    SortPhotographerPayment? sortBy,
    Sort? sort,
  }) {
    // Defer the data fetch to avoid setting state during build
    Future.microtask(() => _fetchData());
    return const PhotographerPaymentState();
  }

  Future<void> _fetchData() async {
    state = state.copyWith(requestState: RequestState.loading);
    
    try {
      final usecase = locator<GetPhotographerPaymentList>();
      
      String? sortByParam;
      if (sortBy != null) {
        sortByParam = sortBy == SortPhotographerPayment.name ? 'name' : 'status';
      }
      
      final response = await usecase.execute(
        page+1,
        limit,
        search: search,
        startTime: startTime,
        endTime: endTime,
        sortBy: sortByParam,
        sort: sort,
      );
      Logger().d(response.metadata);
      final items = response.data.map((e) => e.toEntity()).toList();
      final metadata = response.metadata== null? PhotographerPaymentMetadata(count: 0, totalPages: 0, page: 0, limit: limit) :response.metadata!.toEntity();

      if (ref.mounted) {
        state = state.copyWith(
          isReach: items.length<limit,
          highestPage: 0,
          items: items,
          metadata: metadata,
          currentPage: 0,
          requestState: RequestState.succes,
        );
      }
    } catch (e, s) {
      Logger().e('Error fetching photographer payment list', error: e, stackTrace: s);
      if (ref.mounted) {
        state = state.copyWith(
          requestState: RequestState.error,
          message: e.toString(),
        );
      }
    }
  }

  Future<void> appendData() async {
    if (state.metadata == null) return;
    if (state.currentPage + 1 >= state.metadata!.totalPages) return;
    state = state.copyWith(currentPage: state.currentPage + 1 );
    if (state.currentPage<=state.highestpage)return;
    state = state.copyWith(requestState: RequestState.loading);

    try {
      final usecase = locator<GetPhotographerPaymentList>();
      final nextPage = state.currentPage;
      
      String? sortByParam;
      if (sortBy != null) {
        sortByParam = sortBy == SortPhotographerPayment.name ? 'name' : 'status';
      }
      if(state.isReach)return;
      final response = await usecase.execute(
        nextPage,
        limit,
        search: search,
        startTime: startTime,
        endTime: endTime,
        sortBy: sortByParam,
        sort: sort,
      );

      final newItems = response.data.map((e) => e.toEntity()).toList();
      final allItems = [...state.items, ...newItems];

      if (ref.mounted) {
        state = state.copyWith(
          isReach: response.data.length<limit,
          highestPage: nextPage,
          items: allItems,
          currentPage: nextPage,
          requestState: RequestState.succes,
        );
      }
    } catch (e, s) {
      Logger().e('Error appending photographer payment data', error: e, stackTrace: s);
      if (ref.mounted) {
        state = state.copyWith(
          requestState: RequestState.error,
          message: e.toString(),
        );
      }
    }
  }

  void back() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  void refresh() {
    _fetchData();
  }
}

