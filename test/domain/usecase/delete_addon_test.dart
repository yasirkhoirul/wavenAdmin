import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';
import 'package:wavenadmin/domain/usecase/delete_addon.dart';

class MockAddonsRepository extends Mock implements AddonsRepository {}

void main() {
  late DeleteAddon usecase;
  late MockAddonsRepository mockRepository;

  setUp(() {
    mockRepository = MockAddonsRepository();
    usecase = DeleteAddon(mockRepository);
  });

  group('DeleteAddon UseCase', () {
    const tAddonId = '123';

    test('should delete addon and return success message', () async {
      // Arrange
      const tMessage = 'Addon deleted successfully';
      
      when(() => mockRepository.deleteAddon(tAddonId))
          .thenAnswer((_) async => tMessage);

      // Act
      final result = await usecase.execute(tAddonId);

      // Assert
      expect(result, tMessage);
      verify(() => mockRepository.deleteAddon(tAddonId)).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(() => mockRepository.deleteAddon(tAddonId))
          .thenThrow(Exception('Failed to delete addon'));

      // Act & Assert
      expect(
        () => usecase.execute(tAddonId),
        throwsA(isA<Exception>()),
      );
    });

    test('should handle empty addon id', () async {
      // Arrange
      const tEmptyId = '';
      
      when(() => mockRepository.deleteAddon(tEmptyId))
          .thenThrow(Exception('Invalid addon id'));

      // Act & Assert
      expect(
        () => usecase.execute(tEmptyId),
        throwsA(isA<Exception>()),
      );
    });
  });
}
