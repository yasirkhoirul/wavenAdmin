import 'package:flutter_test/flutter_test.dart';
import 'package:wavenadmin/data/model/addon_detail_model.dart';
import 'package:wavenadmin/data/model/list_addons_model.dart';
import 'package:wavenadmin/domain/entity/addon_detail.dart';

void main() {
  group('AddonDetailData Model', () {
    const tCreatedAt = '2024-01-01T00:00:00Z';
    
    final tAddonDetailData = AddonDetailData(
      id: '123',
      title: 'Test Addon',
      price: 100000,
      isActive: true,
      createdAt: tCreatedAt,
    );

    group('toEntity', () {
      test('should convert AddonDetailData to AddonDetail entity', () {
        // Act
        final result = tAddonDetailData.toEntity();

        // Assert
        expect(result, isA<AddonDetail>());
        expect(result.id, tAddonDetailData.id);
        expect(result.title, tAddonDetailData.title);
        expect(result.price, tAddonDetailData.price);
        expect(result.isActive, tAddonDetailData.isActive);
        expect(result.createdAt, tAddonDetailData.createdAt);
      });
    });

    group('fromJson', () {
      test('should deserialize JSON to AddonDetailData', () {
        // Arrange
        final json = {
          'id': '123',
          'title': 'Test Addon',
          'price': 100000,
          'is_active': true,
          'created_at': '2024-01-01T00:00:00.000Z',
        };

        // Act
        final result = AddonDetailData.fromJson(json);

        // Assert
        expect(result.id, '123');
        expect(result.title, 'Test Addon');
        expect(result.price, 100000);
        expect(result.isActive, true);
      });
    });

    group('toJson', () {
      test('should serialize AddonDetailData to JSON', () {
        // Act
        final result = tAddonDetailData.toJson();

        // Assert
        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], '123');
        expect(result['title'], 'Test Addon');
        expect(result['price'], 100000);
        expect(result['is_active'], true);
      });
    });
  });

  group('ListAddonsResponse Model', () {
    test('should convert ListAddonsResponse to ListAddons entity', () {
      // Arrange
      final tResponse = ListAddonsResponse(
        message: 'Success',
        data: [
          AddonItem(
            id: '1',
            title: 'Addon 1',
            price: 50000,
            isActive: true,
          ),
          AddonItem(
            id: '2',
            title: 'Addon 2',
            price: 75000,
            isActive: false,
          ),
        ],
        metadata: Metadata(
          count: 2,
          totalPages: 1,
          page: 1,
          limit: 10,
        ),
      );

      // Act
      final result = tResponse.toEntity();

      // Assert
      expect(result.addons.length, 2);
      expect(result.addons.first.title, 'Addon 1');
      expect(result.addons.last.title, 'Addon 2');
      expect(result.count, 2);
      expect(result.totalPages, 1);
    });
  });

  group('CreateAddonRequest Model', () {
    test('should serialize to JSON correctly', () {
      // Arrange
      final request = CreateAddonRequest(
        title: 'New Addon',
        price: 100000,
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['title'], 'New Addon');
      expect(json['price'], 100000);
    });
  });

  group('UpdateAddonRequest Model', () {
    test('should serialize to JSON with all fields', () {
      // Arrange
      final request = UpdateAddonRequest(
        title: 'Updated Addon',
        price: 150000,
        isActive: false,
      );

      // Act
      final json = request.toJson();

      // Assert
      expect(json['title'], 'Updated Addon');
      expect(json['price'], 150000);
      expect(json['is_active'], false);
    });
  });
}
