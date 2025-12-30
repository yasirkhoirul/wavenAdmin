// Platform-agnostic helper for web operations
import 'web_helper_stub.dart'
    if (dart.library.html) 'web_helper_web.dart'
    if (dart.library.io) 'web_helper_io.dart';

/// Opens a URL in a new browser tab/window
/// Only works when running on web platform
void openUrlInNewTab(String url) {
  openUrlInNewTabImpl(url);
}
