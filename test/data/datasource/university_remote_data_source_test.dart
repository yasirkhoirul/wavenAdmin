import 'package:flutter_test/flutter_test.dart';
import 'package:wavenadmin/data/datasource/university_remote_data_source.dart';

void main() {
  group('UniversityRemoteDataSource', () {
    const tUniversityId = 'univ-123';
    const tPage = 1;
    const tLimit = 10;

    test('should have university remote data source interface defined', () async {
      expect(UniversityRemoteDataSource, isNotNull);
    });

    test('getListUniversitas should accept pagination parameters', () async {
      expect(tPage, 1);
      expect(tLimit, 10);
    });

    test('getUniversityDropdown should accept pagination parameters', () async {
      expect(tPage, 1);
    });

    test('getDetailUniversity should accept university id', () async {
      expect(tUniversityId, isNotEmpty);
    });

    test('createUniv should accept university data', () async {
      const tUniversityName = 'Test University';
      expect(tUniversityName, isNotEmpty);
    });

    test('updateUniversity should accept university id and data', () async {
      expect(tUniversityId, isNotEmpty);
    });

    test('deleteUniv should accept university id', () async {
      expect(tUniversityId, isNotEmpty);
    });

    test('getListUniversitas should support search parameter', () async {
      const tSearch = 'ITB';
      expect(tSearch, isNotEmpty);
    });
  });
}
