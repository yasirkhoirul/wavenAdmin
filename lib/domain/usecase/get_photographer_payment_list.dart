import 'package:wavenadmin/common/constant.dart';
import 'package:wavenadmin/data/model/photographer_payment_model.dart';
import 'package:wavenadmin/domain/repository/photographer_payment_repository.dart';

class GetPhotographerPaymentList {
  final PhotographerPaymentRepository repository;

  GetPhotographerPaymentList(this.repository);

  Future<PhotographerPaymentResponse> execute(
    int page,
    int limit, {
    String? search,
    DateTime? startTime,
    DateTime? endTime,
    String? sortBy,
    Sort? sort,
  }) async {
    return await repository.getPhotographerPaymentList(
      page,
      limit,
      search: search,
      startTime: startTime,
      endTime: endTime,
      sortBy: sortBy,
      sort: sort,
    );
  }
}
