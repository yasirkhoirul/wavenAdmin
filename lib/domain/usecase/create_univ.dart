import 'package:wavenadmin/domain/entity/university_detail.dart';
import 'package:wavenadmin/domain/repository/university_repository.dart';

class CreateUniv {
  final UniversityRepository universityRepository;
  const CreateUniv(this.universityRepository);

  Future<String> execute(UniversityDetail payload)async{
    return universityRepository.createUniv(payload);
  }
}