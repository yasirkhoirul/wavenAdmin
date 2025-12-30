import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/domain/entity/user_fotografer.dart';
import 'package:wavenadmin/domain/usecase/create_fotografer.dart';
import 'package:wavenadmin/injection.dart';
import 'package:wavenadmin/persentation/riverpod/state/photographer_create_state.dart';

part 'create_fotografer.g.dart';

@riverpod
class CreateFotograferNotifier extends _$CreateFotograferNotifier {
  @override
  PhotographerCreateState build() {
    return PhotographerCreateState();
  }

  bool onCheck() {
    final missing = state.data.phoneNumber == null ||
        state.data.phoneNumber!.isEmpty ||
        state.data.accountNumber == null ||
        state.data.accountNumber!.isEmpty ||
        state.data.bankAccount == null ||
        state.data.bankAccount!.isEmpty ||
        state.data.gears == null ||
        state.data.gears!.isEmpty ||
        state.data.feePerHour == null ||
        state.username.isEmpty ||
        state.email.isEmpty ||
        state.password.isEmpty;

    return !missing;
  }

  void onInput(UserFotografer data , String email,String password, String username){
    state = state.copyWith(
      data: data,
      email: email,
      password: password,
      username: username,
    );
  }

  Future<String> onSubmit() async {
    state = state.copyWith(request: RequestState.loading);

    final check = onCheck();
    if (check) {
      try {
        final usecase = locator<CreateFotografer>();
        final data = await usecase.execute(
          state.data,
          state.username,
          state.password,
          state.email,
        );
        state = state.copyWith(request: RequestState.succes);
        return data;
      } catch (e) {
        Logger().e('Error creating fotografer: $e');
        state = state.copyWith(request: RequestState.error);
        return '';
      }
    } else {
      state = state.copyWith(request: RequestState.error);
      return '';
    }
  }
}
