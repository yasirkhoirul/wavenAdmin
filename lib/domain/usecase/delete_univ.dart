import 'package:wavenadmin/domain/repository/university_repository.dart';

class DeleteUniv {
  final UniversityRepository universityRepository;
  const DeleteUniv(this.universityRepository);

  Future<String> execute(String idUniv)async{
    return  universityRepository.deleteUniv(idUniv);
  }
}