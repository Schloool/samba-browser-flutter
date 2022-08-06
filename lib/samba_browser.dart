
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class SambaBrowser {
  static const MethodChannel _channel = MethodChannel('samba_browser');

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

  static Future<String> saveFile(String saveFolder, String fileName, String url, String domain, String username, String password) async {
    Map<String, String> args = {
      'saveFolder': saveFolder.endsWith('/') ? saveFolder : '$saveFolder/',
      'fileName': fileName.startsWith('/') ? fileName.replaceFirst('/', '') : fileName,
      'url': url,
      'domain': domain,
      'username': username,
      'password': password,
    };

    final String filePath = await _channel.invokeMethod('saveFile', args);
    return filePath;
  }
}
