import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_game/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(hours: 1),
  ));

  bool internetConnection = true;
  String? url;

  final connectivityResult = await (Connectivity().checkConnectivity());
  final int connectivityIndex = connectivityResult.index;
  if (connectivityIndex == 4) {
    internetConnection = false;
  } else {
    try {
      await remoteConfig.fetchAndActivate();
      url = await getUrl(remoteConfig);
    } catch (_) {
      internetConnection = false;
    }
  }

  runApp(App(
    internetConnection: internetConnection,
    url: url,
    remoteConfig: remoteConfig,
  ));
}

Future<String> getUrl(FirebaseRemoteConfig remoteConfig) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? url = prefs.getString('url1');

  if (url == null) {
    url = remoteConfig.getString('url');
    prefs.setString('url', url);
  }

  return url;
}
