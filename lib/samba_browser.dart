
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class SambaBrowser {
  static const MethodChannel _channel = MethodChannel('samba_browser');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List> getShareList(String url, String domain, String username, String password) async {
    Map<String, String> args = {
      'url': url,
      'domain': domain,
      'username': username,
      'password': password,
    };

    final List drives = await _channel.invokeMethod('getShareList', args);
    return drives;
  }

  static Future<Uint8List> getFileBytes(String url, String domain, String username, String password) async {
    Map<String, String> args = {
      'url': url,
      'domain': domain,
      'username': username,
      'password': password,
    };

    final Uint8List fileBytes = await _channel.invokeMethod('getFileBytes', args);
    return fileBytes;
  }
}
