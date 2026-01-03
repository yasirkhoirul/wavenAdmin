import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wavenadmin/data/auth_repositoryimpl.dart';
import 'package:wavenadmin/data/datasource/auth_remote_data_source.dart';
import 'package:wavenadmin/data/datasource/local_data.dart';
import 'package:wavenadmin/data/model/tokenmode.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockLocalData extends Mock implements LocalData {}

void main() {
  late AuthRepositoryimpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockLocalData mockLocalData;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalData = MockLocalData();
    repository = AuthRepositoryimpl(mockRemoteDataSource, localData: mockLocalData);
  });

  group('AuthRepository', () {
    group('postLogin', () {
      const tUsername = 'test@example.com';
      const tPassword = 'password123';
      const tAccessToken = 'access_token_123';
      const tRefreshToken = 'refresh_token_123';

      test('should return "berhasil" when login and save token are successful', () async {
        // Arrange
        final tToken = Token(
          tAccessToken,
          tRefreshToken,
        );

        when(() => mockRemoteDataSource.login(tUsername, tPassword))
            .thenAnswer((_) async => tToken);
        when(() => mockLocalData.saveToken(tAccessToken, tRefreshToken))
            .thenAnswer((_) async => true);

        // Act
        final result = await repository.postLogin(tUsername, tPassword);

        // Assert
        expect(result, 'berhasil');
        verify(() => mockRemoteDataSource.login(tUsername, tPassword)).called(1);
        verify(() => mockLocalData.saveToken(tAccessToken, tRefreshToken)).called(1);
      });

      test('should throw exception when save token fails', () async {
        // Arrange
        final tToken = Token(
          tAccessToken,
          tRefreshToken,
        );

        when(() => mockRemoteDataSource.login(tUsername, tPassword))
            .thenAnswer((_) async => tToken);
        when(() => mockLocalData.saveToken(tAccessToken, tRefreshToken))
            .thenAnswer((_) async => false);

        // Act & Assert
        expect(
          () => repository.postLogin(tUsername, tPassword),
          throwsA(isA<Exception>()),
        );
      });

      test('should throw exception when login fails', () async {
        // Arrange
        when(() => mockRemoteDataSource.login(tUsername, tPassword))
            .thenThrow(Exception('Login failed'));

        // Act & Assert
        expect(
          () => repository.postLogin(tUsername, tPassword),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getTokenAcces', () {
      const tAccessToken = 'access_token_123';

      test('should return access token when available', () async {
        // Arrange
        when(() => mockLocalData.getAccesToken())
            .thenAnswer((_) async => tAccessToken);

        // Act
        final result = await repository.getTokenAcces();

        // Assert
        expect(result, tAccessToken);
        verify(() => mockLocalData.getAccesToken()).called(1);
      });

      test('should return null when no token available', () async {
        // Arrange
        when(() => mockLocalData.getAccesToken()).thenAnswer((_) async => null);

        // Act
        final result = await repository.getTokenAcces();

        // Assert
        expect(result, null);
      });
    });

    group('getTokenRefresh', () {
      const tRefreshToken = 'refresh_token_123';

      test('should return refresh token when available', () async {
        // Arrange
        when(() => mockLocalData.getRefreshToken())
            .thenAnswer((_) async => tRefreshToken);

        // Act
        final result = await repository.getTokenRefresh();

        // Assert
        expect(result, tRefreshToken);
        verify(() => mockLocalData.getRefreshToken()).called(1);
      });
    });

    group('postLogout', () {
      const tRefreshToken = 'refresh_token_123';

      test('should complete successfully when logout succeeds', () async {
        // Arrange
        when(() => mockLocalData.getRefreshToken())
            .thenAnswer((_) async => tRefreshToken);
        when(() => mockRemoteDataSource.logout(tRefreshToken))
            .thenAnswer((_) async => true);
        when(() => mockLocalData.deleteToken()).thenAnswer((_) async => true);

        // Act
        await repository.postLogout();

        // Assert
        verify(() => mockLocalData.getRefreshToken()).called(1);
        verify(() => mockRemoteDataSource.logout(tRefreshToken)).called(1);
        verify(() => mockLocalData.deleteToken()).called(1);
      });

      test('should throw exception when logout fails', () async {
        // Arrange
        when(() => mockLocalData.getRefreshToken())
            .thenAnswer((_) async => tRefreshToken);
        when(() => mockRemoteDataSource.logout(tRefreshToken))
            .thenAnswer((_) async => false);

        // Act & Assert
        try {
          await repository.postLogout();
          fail('Should have thrown an exception');
        } catch (e) {
          expect(e, isA<String>());
        }
        verifyNever(() => mockLocalData.deleteToken());
      });

      test('should handle empty refresh token', () async {
        // Arrange
        when(() => mockLocalData.getRefreshToken()).thenAnswer((_) async => null);
        when(() => mockRemoteDataSource.logout('')).thenAnswer((_) async => true);
        when(() => mockLocalData.deleteToken()).thenAnswer((_) async => true);

        // Act
        await repository.postLogout();

        // Assert
        verify(() => mockRemoteDataSource.logout('')).called(1);
        verify(() => mockLocalData.deleteToken()).called(1);
      });
    });
  });
}
