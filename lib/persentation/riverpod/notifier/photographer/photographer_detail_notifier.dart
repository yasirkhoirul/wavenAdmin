import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/usecase/get_photographer_detail.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_detail_state.dart';

part 'photographer_detail_notifier.g.dart';

@riverpod
class PhotographerDetailNotifier extends _$PhotographerDetailNotifier {
  @override
  PhotographerDetailState build(String photographerId) {
    Future.microtask(() => _fetchData(photographerId));
    return PhotographerDetailState.initial();
  }

  Future<void> _fetchData(String photographerId) async {
    state = state.copyWith(requestState: RequestState.loading);

    try {
      final usecase = locator<GetPhotographerDetail>();
      final response = await usecase.execute(photographerId);

      state = state.copyWith(
        detail: response.toEntity(),
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

  Future<void> refresh() async {
    await _fetchData(photographerId);
  }
}
