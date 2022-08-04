
import 'dart:async';

import 'package:flutter/services.dart';

class SambaBrowser {
  static const MethodChannel _channel = MethodChannel('samba_browser');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List> getDrives(String url, {String? domain, String? username, String? password}) async {
    Map<String, String> args = {
      'url': url,
      if (domain != null) 'domain': domain,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    };

    final List drives = await _channel.invokeMethod('getShareList', args);
    return drives;
  }
}
