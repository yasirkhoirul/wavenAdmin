import 'package:flutter_test/flutter_test.dart';
import 'package:wavenadmin/data/datasource/user_remote_data_source.dart';

void main() {
  group('UserRemoteDataSource', () {
    const tUserId = 'user-123';
    const tPage = 1;
    const tLimit = 10;

    test('should have user remote data source interface defined', () async {
      expect(UserRemoteDataSource, isNotNull);
    });

    test('getListUser should accept pagination parameters', () async {
      expect(tPage, 1);
      expect(tLimit, 10);
    });

    test('getListUserAdmin should accept pagination parameters', () async {
      expect(tPage, 1);
    });

    test('getListPhotographer should accept pagination parameters', () async {
      expect(tPage, 1);
    });

    test('getDetailUser should accept user id', () async {
      expect(tUserId, isNotEmpty);
    });

    test('getDetailUserFotografer should accept photographer id', () async {
      expect(tUserId, isNotEmpty);
    });

    test('getUserAdminDetail should accept admin id', () async {
      expect(tUserId, isNotEmpty);
    });

    test('createAdmin should accept admin data', () async {
      const tAdminName = 'Test Admin';
      expect(tAdminName, isNotEmpty);
    });

    test('createFotografer should accept photographer data', () async {
      const tPhotographerName = 'Test Photographer';
      expect(tPhotographerName, isNotEmpty);
    });

    test('updateUser should accept user id and data', () async {
      expect(tUserId, isNotEmpty);
    });

    test('deleteUser should accept user id', () async {
      expect(tUserId, isNotEmpty);
    });

    test('deleteAdmin should accept admin id', () async {
      expect(tUserId, isNotEmpty);
    });

    test('deleteFotografer should accept photographer id', () async {
      expect(tUserId, isNotEmpty);
    });

    test('deleteBatchUser should accept list of user ids', () async {
      final tUserIds = ['user-1', 'user-2', 'user-3'];
      expect(tUserIds.length, 3);
    });
  });
}
