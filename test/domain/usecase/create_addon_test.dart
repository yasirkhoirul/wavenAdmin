import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';
import 'package:wavenadmin/domain/entity/list_addons.dart';
import 'package:wavenadmin/domain/repository/addons_repository.dart';
import 'package:wavenadmin/domain/usecase/create_addon.dart';

class MockAddonsRepository extends Mock implements AddonsRepository {}
class FakeCreateAddonRequest extends Fake implements CreateAddonRequest {}

void main() {
  late CreateAddon usecase;
  late MockAddonsRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeCreateAddonRequest());
  });

  setUp(() {
    mockRepository = MockAddonsRepository();
    usecase = CreateAddon(mockRepository);
  });

  group('CreateAddon UseCase', () {
    const tTitle = 'New Addon';
    const tPrice = 100000;

    test('should create addon and return success message', () async {
      // Arrange
      const tMessage = 'Addon created successfully';
      final tRequest = CreateAddonRequest(title: tTitle, price: tPrice);
      
      when(() => mockRepository.createAddon(any()))
          .thenAnswer((_) async => tMessage);

      // Act
      final result = await usecase.execute(tRequest);

      // Assert
      expect(result, tMessage);
      verify(() => mockRepository.createAddon(any())).called(1);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      final tRequest = CreateAddonRequest(title: tTitle, price: tPrice);
      
      when(() => mockRepository.createAddon(any()))
          .thenThrow(Exception('Failed to create addon'));

      // Act & Assert
      expect(
        () => usecase.execute(tRequest),
        throwsA(isA<Exception>()),
      );
    });
  });
}
