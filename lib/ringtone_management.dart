import 'dart:async';

import 'package:flutter/services.dart';

class RingtoneManagement {
  static const MethodChannel _channel =
      const MethodChannel('ringtone_management');

  static const int TYPE_ALARM = 4;
  static const int TYPE_ALL = 7;
  static const int TYPE_NOTIFICATION = 2;
  static const int TYPE_RINGTONE = 1;

  Future<List<String>> get getRingtonesTitle async {
    try {
      return await _channel
          .invokeListMethod<String>('ringtone:get_ringtones_title');
    } on PlatformException catch (e) {
      throw (e.message);
    }
  }

  Future<List<Map<String, dynamic>>> get getRingtonesData async {
    try {
      final List<Map<dynamic, dynamic>> items =
          await _channel.invokeListMethod<Map<dynamic, dynamic>>(
              'ringtone:get_ringtones_data');

      return items.map((Map<dynamic, dynamic> item) {
        return Map<String, dynamic>.from(item);
      }).toList();
    } on PlatformException catch (e) {
      throw (e.message);
    }
  }

  Future setRingtoneType(int type) {
    return _channel.invokeMethod('ringtone:set_ringtone_type', {'type': type});
  }
}
