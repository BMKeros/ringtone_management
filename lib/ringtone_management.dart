import 'dart:async';

import 'package:flutter/services.dart';

class RingtoneManagement {
  static const MethodChannel _channel =
      const MethodChannel('ringtone_management');

  Future<List> get getRingtonesTitle async {
    return _channel.invokeListMethod('ringtone:get_ringtones_title');
  }

  Future<List> get getRingtonesData async {
    return _channel.invokeListMethod('ringtone:get_ringtones_data');
  }

  Future play(Map data) async {
    return _channel.invokeMethod('ringtone:play', data);
  }
}
