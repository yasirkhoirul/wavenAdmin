import 'package:wavenadmin/data/model/photographer_detail_model.dart';
import 'package:wavenadmin/domain/repository/photographer_payment_repository.dart';

class GetPhotographerDetail {
  final PhotographerPaymentRepository repository;

  GetPhotographerDetail(this.repository);

  Future<PhotographerDetailResponse> execute(String id) {
    return repository.getPhotographerDetail(id);
  }
}
