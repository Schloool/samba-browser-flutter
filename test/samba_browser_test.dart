import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:samba_browser/samba_browser.dart';

void main() {
  const MethodChannel channel = MethodChannel('samba_browser');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
