// Web implementation using package:web
import 'package:web/web.dart' as web;

void openUrlInNewTabImpl(String url) {
  web.window.open(url, '_blank');
}
