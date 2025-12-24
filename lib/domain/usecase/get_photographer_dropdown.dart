import 'package:wavenadmin/domain/entity/photographer_dropdown.dart';
import 'package:wavenadmin/domain/repository/user_repositoty.dart';

class GetPhotographerDropdown {
  final UserRepositoty repository;
  const GetPhotographerDropdown(this.repository);

  Future<PhotographerDropdown> execute(int page, int limit, {String? search}) async {
    return await repository.getPhotographerDropdown(page, limit, search: search);
  }
}
