import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:logger/logger.dart';

/// Handles deep links for payment callback
/// Expected URL format: wavenadmin://payment-result?order_id=xxx&transaction_status=settlement
class DeepLinkHandler {
  static final DeepLinkHandler _instance = DeepLinkHandler._internal();
  factory DeepLinkHandler() => _instance;
  DeepLinkHandler._internal();

  final _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  
  /// Callback when payment result is received
  Function(String bookingId, String status, Map<String, String> params)? onPaymentResult;

  /// Initialize deep link listener
  Future<void> initialize() async {
    try {
      // Handle link that opened the app (cold start)
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        Logger().d('Initial deep link: $initialUri');
      }

      // Handle links while app is running (hot start)
      _linkSubscription = _appLinks.uriLinkStream.listen(
        (uri) {
          Logger().d('Received deep link: $uri');
        },
        onError: (err) {
          Logger().e('Deep link error: $err');
        },
      );

      Logger().i('Deep link handler initialized');
    } catch (e) {
      Logger().e('Failed to initialize deep link handler: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    _linkSubscription?.cancel();
  }
}
