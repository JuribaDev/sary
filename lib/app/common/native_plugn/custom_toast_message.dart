import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SaryToastMessage {
  static const MethodChannel channel = MethodChannel('com.sary.juriba/toast');

  // static Future<bool> cancel() async {
  //   bool res = await channel.invokeMethod("cancel");
  //   return res;
  // }

  static Future<void> showToast({
    required String message,
  }) async {
    final Map<String, dynamic> arg = <String, dynamic>{
      'message': message,
    };
    await channel.invokeMethod('saryToast', arg);
  }
}
