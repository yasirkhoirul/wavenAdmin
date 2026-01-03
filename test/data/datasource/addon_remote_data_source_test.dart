import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wavenadmin/data/datasource/addon_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/data/model/list_addons_model.dart';

class MockDioClient extends Mock implements DioClient {}
class MockDio extends Mock implements Dio {}
class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late AddonRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;
  late MockDio mockDio;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDioClient = MockDioClient();
    mockDio = MockDio();
    when(() => mockDioClient.dio).thenReturn(mockDio);
    dataSource = AddonRemoteDataSourceImpl(mockDioClient);
  });

  group('AddonRemoteDataSource', () {
    group('getListAddons', () {
      const tPage = 1;
      const tLimit = 10;
      const tSearch = 'test';

      test('should return ListAddonsResponse when API call is successful', () async {
        // Arrange
        final responseData = {
          'message': 'Success',
          'data': [
            {
              'id': '1',
              'title': 'Test Addon',
              'price': 100000,
              'is_active': true,
              'created_at': '2024-01-01T00:00:00Z',
            }
          ],
          'metadata': {
            'count': 1,
            'total_pages': 1,
            'page': 1,
            'limit': 10,
          }
        };

        when(() => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // Act
        final result = await dataSource.getListAddons(tPage, tLimit, search: tSearch);

        // Assert
        expect(result, isA<ListAddonsResponse>());
        expect(result.data, isNotEmpty);
        expect(result.data.first.title, 'Test Addon');
        verify(() => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        )).called(1);
      });

      test('should throw exception when API call fails', () async {
        // Arrange
        when(() => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        )).thenThrow(DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: ''),
          ),
        ));

        // Act & Assert
        expect(
          () => dataSource.getListAddons(tPage, tLimit, search: tSearch),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getAddonDetail', () {
      const tAddonId = '123';

      test('should return AddonDetailResponse when successful', () async {
        // Arrange
        final responseData = {
          'message': 'Success',
          'data': {
            'id': tAddonId,
            'title': 'Test Addon',
            'price': 100000,
            'is_active': true,
            'created_at': '2024-01-01T00:00:00Z',
          }
        };

        when(() => mockDio.get(any())).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // Act
        final result = await dataSource.getAddonDetail(tAddonId);

        // Assert
        expect(result, isA<AddonDetailResponse>());
        expect(result.data.id, tAddonId);
        expect(result.data.title, 'Test Addon');
      });
    });

    group('createAddon', () {
      final tRequest = CreateAddonRequest(
        title: 'New Addon',
        price: 50000,
      );

      test('should return success response when addon is created', () async {
        // Arrange
        final responseData = {
          'message': 'Addon created successfully',
        };

        when(() => mockDio.post(
          any(),
          data: any(named: 'data'),
        )).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 201,
          requestOptions: RequestOptions(path: ''),
        ));

        // Act
        final result = await dataSource.createAddon(tRequest);

        // Assert
        expect(result, isA<CreateAddonResponse>());
        expect(result.message, 'Addon created successfully');
        verify(() => mockDio.post(
          any(),
          data: any(named: 'data'),
        )).called(1);
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
        const responseMessage = 'Addon updated successfully';
        final responseData = {'message': responseMessage};

        when(() => mockDio.put(
          any(),
          data: any(named: 'data'),
        )).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // Act
        final result = await dataSource.updateAddon(tAddonId, tRequest);

        // Assert
        expect(result, responseMessage);
        verify(() => mockDio.put(
          any(),
          data: any(named: 'data'),
        )).called(1);
      });
    });

    group('deleteAddon', () {
      const tAddonId = '123';

      test('should return delete response when successful', () async {
        // Arrange
        final responseData = {
          'message': 'Addon deleted successfully',
        };

        when(() => mockDio.delete(any())).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

        // Act
        final result = await dataSource.deleteAddon(tAddonId);

        // Assert
        expect(result, isA<DeleteAddonResponse>());
        expect(result.message, 'Addon deleted successfully');
        verify(() => mockDio.delete(any())).called(1);
      });
    });
  });
}
