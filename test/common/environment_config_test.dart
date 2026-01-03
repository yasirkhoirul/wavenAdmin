import 'package:flutter_test/flutter_test.dart';
import 'package:wavenadmin/common/environment_config.dart';

void main() {
  group('EnvironmentConfig', () {
    test('should have default values', () {
      expect(EnvironmentConfig.apiBaseUrl, isNotEmpty);
      expect(EnvironmentConfig.apiTimeout, greaterThan(0));
      expect(EnvironmentConfig.environment, isNotEmpty);
    });

    test('should identify development environment correctly', () {
      expect(EnvironmentConfig.isDevelopment, isA<bool>());
    });

    test('should identify production environment correctly', () {
      expect(EnvironmentConfig.isProduction, isA<bool>());
    });

    test('should identify staging environment correctly', () {
      expect(EnvironmentConfig.isStaging, isA<bool>());
    });

    test('apiTimeout should be positive integer', () {
      expect(EnvironmentConfig.apiTimeout, greaterThan(0));
      expect(EnvironmentConfig.apiTimeout, isA<int>());
    });

    test('environment should be one of valid values', () {
      final validEnvironments = ['development', 'staging', 'production'];
      expect(validEnvironments, contains(EnvironmentConfig.environment));
    });
  });
}
