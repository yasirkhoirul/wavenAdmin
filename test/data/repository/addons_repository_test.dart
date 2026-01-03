import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wavenadmin/data/addons_repository_impl.dart';
import 'package:wavenadmin/data/datasource/addon_remote_data_source.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/data/model/list_addons_model.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';

class MockAddonRemoteDataSource extends Mock implements AddonRemoteDataSource {}

void main() {
  late AddonsRepositoryImpl repository;
  late MockAddonRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAddonRemoteDataSource();
    repository = AddonsRepositoryImpl(mockRemoteDataSource);
  });

  group('AddonsRepository', () {
    group('getListAddons', () {
      const tPage = 1;
      const tLimit = 10;
      const tSearch = 'test';

      test('should return ListAddons when data source call is successful', () async {
        // Arrange
        final tResponse = ListAddonsResponse(
          message: 'Success',
          data: [
            AddonItem(
              id: '1',
              title: 'Test Addon',
              price: 100000,
              isActive: true,
            ),
          ],
          metadata: Metadata(
            count: 1,
            totalPages: 1,
            page: 1,
            limit: 10,
          ),
        );

        when(() => mockRemoteDataSource.getListAddons(
          tPage,
          tLimit,
          search: tSearch,
        )).thenAnswer((_) async => tResponse);

        // Act
        final result = await repository.getListAddons(tPage, tLimit, search: tSearch);

        // Assert
        expect(result, isA<ListAddons>());
        expect(result.addons, isNotEmpty);
        expect(result.addons.first.title, 'Test Addon');
        verify(() => mockRemoteDataSource.getListAddons(
          tPage,
          tLimit,
          search: tSearch,
        )).called(1);
      });

      test('should throw exception when data source throws', () async {
        // Arrange
        when(() => mockRemoteDataSource.getListAddons(
          tPage,
          tLimit,
          search: tSearch,
        )).thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => repository.getListAddons(tPage, tLimit, search: tSearch),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getAddonDetail', () {
      const tAddonId = '123';

      test('should return AddonDetail when successful', () async {
        // Arrange
        final tResponse = AddonDetailResponse(
          message: 'Success',
          data: AddonDetailData(
            id: tAddonId,
            title: 'Test Addon',
            price: 100000,
            isActive: true,
            createdAt: '2024-01-01',
          ),
        );

        when(() => mockRemoteDataSource.getAddonDetail(tAddonId))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await repository.getAddonDetail(tAddonId);

        // Assert
        expect(result, isA<AddonDetail>());
        expect(result.id, tAddonId);
        expect(result.title, 'Test Addon');
        verify(() => mockRemoteDataSource.getAddonDetail(tAddonId)).called(1);
      });
    });

    group('createAddon', () {
      final tRequest = CreateAddonRequest(
        title: 'New Addon',
        price: 50000,
      );

      test('should return success message when addon is created', () async {
        // Arrange
        final tResponse = CreateAddonResponse(message: 'Addon created successfully');

        when(() => mockRemoteDataSource.createAddon(tRequest))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await repository.createAddon(tRequest);

        // Assert
        expect(result, 'Addon created successfully');
        verify(() => mockRemoteDataSource.createAddon(tRequest)).called(1);
      });
    });

    group('updateAddon', () {
      const tAddonId = '123';
      final tRequest = UpdateAddonRequest(
        title: 'Updated Addon',
        price: 75000,
        isActive: true,
      );

      test('should return success message when addon is updated', () async {
        // Arrange
        const tMessage = 'Addon updated successfully';

        when(() => mockRemoteDataSource.updateAddon(tAddonId, tRequest))
            .thenAnswer((_) async => tMessage);

        // Act
        final result = await repository.updateAddon(tAddonId, tRequest);

        // Assert
        expect(result, tMessage);
        verify(() => mockRemoteDataSource.updateAddon(tAddonId, tRequest)).called(1);
      });
    });

    group('deleteAddon', () {
      const tAddonId = '123';

      test('should return success message when addon is deleted', () async {
        // Arrange
        final tResponse = DeleteAddonResponse(message: 'Addon deleted successfully');

        when(() => mockRemoteDataSource.deleteAddon(tAddonId))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await repository.deleteAddon(tAddonId);

        // Assert
        expect(result, 'Addon deleted successfully');
        verify(() => mockRemoteDataSource.deleteAddon(tAddonId)).called(1);
      });
    });
  });
}
