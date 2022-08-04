import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:samba_browser/samba_browser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _shareList = 'Not loaded';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String allDrives;

    try {
      List drives = await SambaBrowser.getShareList('smb://test/home/', 'test.net', 'user', 'password');
      allDrives = drives.join(', ');

      Uint8List fileBytes = await SambaBrowser.getFileBytes('smb://test/home/myFile.pdf', 'test.net', 'user', 'password');

    } on PlatformException {
      allDrives = 'Failed to get drives.';
    }

    if (!mounted) return;

    setState(() {
      _shareList = allDrives;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SAMBA Plugin example app'),
        ),
        body: Center(
          child: Text('ShareList: $_shareList\n'),
        ),
      ),
    );
  }
}
