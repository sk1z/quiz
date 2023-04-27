import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_game/app.dart';
import 'package:quiz_game/webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.fetchAndActivate();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? url = prefs.getString('url');
  if (url == null) {
    url = remoteConfig.getString('url');
    prefs.setString('url', url);
  }
  // if (url == '') {
  //   runApp(App());
  // } else {
  //   runApp(App());
  // }

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: const WebView(url: 'https://google.com'),
  ));
}
