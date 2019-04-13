import 'dart:async';

import 'package:flutter/services.dart';

class RingtoneManagement {
  static const MethodChannel _channel =
      const MethodChannel('ringtone_management');

  static const int TYPE_ALARM = 4;
  static const int TYPE_ALL = 7;
  static const int TYPE_NOTIFICATION = 2;
  static const int TYPE_RINGTONE = 1;

  Future<List> get getRingtonesTitle async {
    return _channel.invokeListMethod('ringtone:get_ringtones_title');
  }

  Future<List> get getRingtonesData async {
    return _channel.invokeListMethod('ringtone:get_ringtones_data');
  }

  Future setRingtoneType(int type) {
    return _channel.invokeMethod('ringtone:set_ringtone_type', {'type': type});
  }
}
