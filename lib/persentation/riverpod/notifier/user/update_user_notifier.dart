import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wavenadmin/data/datasource/user_remote_data_source.dart';
import 'package:wavenadmin/data/model/update_user_request_model.dart';
import 'package:wavenadmin/injection.dart';

part 'update_user_notifier.g.dart';

@riverpod
class UpdateUserNotifier extends _$UpdateUserNotifier {
  @override
  FutureOr<String?> build() async {
    return null;
  }

  Future<void> updateUser(String userId, UpdateUserRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final remoteData = locator<UserRemoteDataSource>();
      final response = await remoteData.updateUser(userId, request);
      return response.message;
    });
  }

  void reset() {
    state = const AsyncData(null);
  }
}
