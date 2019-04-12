import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ringtone_management/ringtone_management.dart';

void main() {
  const MethodChannel channel = MethodChannel('ringtone_management');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await RingtoneManagement.platformVersion, '42');
  });
}
