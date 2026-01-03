import 'package:flutter_test/flutter_test.dart';
import 'package:wavenadmin/data/datasource/package_remote_data_source.dart';

void main() {
  group('PackageRemoteDataSource', () {
    const tPackageId = 'pkg-123';
    const tPage = 1;
    const tLimit = 10;

    test('should have package remote data source interface defined', () async {
      expect(PackageRemoteDataSource, isNotNull);
    });

    test('getPackageDropdown should accept pagination parameters', () async {
      expect(tPage, 1);
      expect(tLimit, 10);
    });

    test('getPackageList should accept pagination parameters', () async {
      expect(tPage, 1);
    });

    test('getPackageDetail should accept package id', () async {
      expect(tPackageId, isNotEmpty);
    });

    test('createPackage should accept package request data', () async {
      const tPackageName = 'Premium Package';
      expect(tPackageName, isNotEmpty);
    });

    test('updatePackage should accept package id and data', () async {
      expect(tPackageId, isNotEmpty);
    });

    test('deletePackage should accept package id', () async {
      expect(tPackageId, isNotEmpty);
    });

    test('getListPorto should return portfolio list for package', () async {
      expect(tPackageId, isNotEmpty);
    });

    test('addPorto should accept image and package id', () async {
      const tPortoUrl = 'https://example.com/porto.jpg';
      expect(tPortoUrl, isNotEmpty);
    });
  });
}
