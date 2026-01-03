import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:wavenadmin/data/datasource/auth_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/dio.dart';
import 'package:wavenadmin/data/model/tokenmode.dart';

class MockDioClient extends Mock implements DioClient {}
class MockHttpClient extends Mock implements http.Client {}
class FakeUri extends Fake implements Uri {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockDioClient mockDioClient;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    mockDioClient = MockDioClient();
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSourceImpl(mockDioClient, mockHttpClient);
  });

  group('AuthRemoteDataSource', () {
    group('login', () {
      const tEmail = 'test@example.com';
      const tPassword = 'password123';
      const tAccessToken = 'access_token_123';
      const tRefreshToken = 'refresh_token_123';

      test('should return Token when login is successful', () async {
        // Arrange
        final responseBody = '''
        {
          "message": "success"
        }
        ''';
        
        final responseHeaders = {
          'x-access-token': tAccessToken,
          'x-refresh-token': tRefreshToken,
        };
        
        when(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response(
          responseBody, 
          200, 
          headers: responseHeaders,
        ));

        // Act
        final result = await dataSource.login(tEmail, tPassword);

        // Assert
        expect(result, isA<Token>());
        expect(result.accesToken, tAccessToken);
        expect(result.refreshToken, tRefreshToken);
        verify(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).called(1);
      });

      test('should throw exception when login fails', () async {
        // Arrange
        when(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response('Unauthorized', 401));

        // Act & Assert
        expect(
          () => dataSource.login(tEmail, tPassword),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('logout', () {
      const tRefreshToken = 'refresh_token_123';

      test('should return true when logout is successful', () async {
        // Arrange
        final responseBody = '{"message": "Logged out successfully"}';
        
        when(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response(responseBody, 200));

        // Act
        final result = await dataSource.logout(tRefreshToken);

        // Assert
        expect(result, true);
        verify(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).called(1);
      });

      test('should return false when logout fails', () async {
        // Arrange
        when(() => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
        )).thenAnswer((_) async => http.Response('Error', 500));

        // Act
        final result = await dataSource.logout(tRefreshToken);

        // Assert
        expect(result, false);
      });
    });
  });
}
