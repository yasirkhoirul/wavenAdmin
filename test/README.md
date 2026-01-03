# Test Coverage Report

## Overview
This directory contains unit tests for the WavenAdmin Flutter application.

## Test Structure

```
test/
├── common/
│   └── environment_config_test.dart       # Environment configuration tests
├── data/
│   ├── datasource/
│   │   ├── addon_remote_data_source_test.dart   # Addon data source tests
│   │   └── auth_remote_data_source_test.dart    # Auth data source tests
│   ├── model/
│   │   └── addon_detail_model_test.dart          # Model serialization tests
│   └── repository/
│       ├── addons_repository_test.dart           # Addon repository tests
│       └── auth_repository_test.dart             # Auth repository tests
└── domain/
    └── usecase/
        ├── create_addon_test.dart                # Create addon use case tests
        └── delete_addon_test.dart                # Delete addon use case tests
```

## Running Tests

### Run all tests
```bash
flutter test
```

### Run specific test file
```bash
flutter test test/data/datasource/auth_remote_data_source_test.dart
```

### Run tests with coverage
```bash
flutter test --coverage
```

### Generate coverage report (requires lcov)
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Test Coverage by Layer

### ✅ Data Layer Tests
- **Remote Data Sources**: Auth, Addon
- **Repositories**: Auth, Addon
- **Models**: Addon detail model serialization

### ✅ Domain Layer Tests
- **Use Cases**: Create Addon, Delete Addon

### ✅ Common Tests
- **Environment Config**: Configuration validation

## Testing Approach

### Unit Tests
- Test individual components in isolation
- Mock external dependencies (Dio, HTTP client, repositories)
- Verify correct behavior and error handling

### Test Patterns Used
1. **AAA Pattern** (Arrange-Act-Assert)
   - Arrange: Setup test data and mocks
   - Act: Execute the function under test
   - Assert: Verify the expected outcome

2. **Mocking**
   - Using `mocktail` for flexible mocking
   - Mock all external dependencies
   - Verify method calls and interactions

3. **Edge Cases**
   - Test successful scenarios
   - Test error scenarios
   - Test boundary conditions

## Dependencies

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.4
  mocktail: ^1.0.4
```

## Best Practices

1. **Test Naming**: Use descriptive names that explain what is being tested
   ```dart
   test('should return Token when login is successful', () async { ... });
   ```

2. **Test Isolation**: Each test should be independent and not rely on other tests

3. **Mock Verification**: Always verify that mocked methods are called with expected parameters
   ```dart
   verify(() => mockRemoteDataSource.login(tEmail, tPassword)).called(1);
   ```

4. **Error Testing**: Test both success and failure scenarios
   ```dart
   test('should throw exception when API call fails', () async { ... });
   ```

## Future Test Coverage

### TODO: Add tests for
- [ ] Booking data sources and repositories
- [ ] Package data sources and repositories
- [ ] User data sources and repositories
- [ ] University data sources and repositories
- [ ] Dashboard data sources and repositories
- [ ] Pengaturan data sources and repositories
- [ ] Photographer data sources and repositories
- [ ] Widget tests for UI components
- [ ] Integration tests for critical flows
- [ ] Riverpod notifier tests

## Continuous Integration

Add to your CI/CD pipeline:
```yaml
# GitHub Actions example
- name: Run tests
  run: flutter test --coverage
  
- name: Upload coverage
  uses: codecov/codecov-action@v3
  with:
    files: ./coverage/lcov.info
```

## Contributing

When adding new features:
1. Write tests first (TDD approach recommended)
2. Ensure all tests pass before committing
3. Maintain test coverage above 80%
4. Update this README when adding new test files
