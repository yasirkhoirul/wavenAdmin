import 'package:wavenadmin/data/model/delete_batch_user_model.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class DeleteBatchUser {
  final UserRepositoty repository;

  const DeleteBatchUser(this.repository);

  Future<DeleteBatchUserResponse> execute(List<String> userIds) async {
    return await repository.deleteBatchUser(userIds);
  }
}
