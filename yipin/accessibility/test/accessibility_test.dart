import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:accessibility/accessibility.dart';

void main() {
  const MethodChannel channel = MethodChannel('accessibility');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Accessibility.platformVersion, '42');
  });
}
