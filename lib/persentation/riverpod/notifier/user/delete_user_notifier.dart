import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/domain/usecase/delete_batch_user.dart';
import 'package:wavenadmin/domain/usecase/delete_user.dart';
import 'package:wavenadmin/persentation/riverpod/provider/usecase_providers.dart';

part 'delete_user_notifier.g.dart';

@riverpod
class DeleteUserNotifier extends _$DeleteUserNotifier {
  late DeleteUser _deleteUserUsecase;
  late DeleteBatchUser _deleteBatchUserUsecase;

  @override
  FutureOr<String?> build() {
    _deleteUserUsecase =  ref.read(deleteUserUsecase);
    _deleteBatchUserUsecase = ref.read(deleteBatchUserUsecase);
    return null;
  }

  Future<void> deleteUser(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final message = await _deleteUserUsecase.execute(userId);
        return message;
      },
    );
  }

  Future<void> deleteBatchUser(List<String> userIds) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final response = await _deleteBatchUserUsecase.execute(userIds);
        return response.message;
      },
    );
  }
}