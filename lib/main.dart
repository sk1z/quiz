import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
    minimumFetchInterval: const Duration(seconds: 1),
  ));

  final bool isEmu = await checkIsEmu();

  bool internetConnection = true;
  String? url;

  final connectivityResult = await (Connectivity().checkConnectivity());
  final int connectivityIndex = connectivityResult.index;
  if (connectivityIndex == 4) {
    internetConnection = false;
  } else {
    try {
      url = await getUrl(remoteConfig);
    } catch (_) {
      internetConnection = false;
    }
  }

  runApp(App(
    internetConnection: internetConnection,
    url: url,
    remoteConfig: remoteConfig,
    isEmu: isEmu,
  ));
}

Future<String> getUrl(FirebaseRemoteConfig remoteConfig) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? url = prefs.getString('url');
  url = null;

  if (url == null) {
    await remoteConfig.fetchAndActivate();
    url = remoteConfig.getString('url');
    if (url != '') {
      prefs.setString('url', url);
    }
  }

  return url;
}

Future<bool> checkIsEmu() async {
  final em = await DeviceInfoPlugin().androidInfo;
  var phoneModel = em.model;
  var buildProduct = em.product;
  var buildHardware = em.hardware;
  var result = (em.fingerprint.startsWith('generic') ||
      phoneModel.contains('google_sdk') ||
      phoneModel.contains('droid4x') ||
      phoneModel.contains('Emulator') ||
      phoneModel.contains('Android SDK built for x86') ||
      em.manufacturer.contains('Genymotion') ||
      buildHardware == 'goldfish' ||
      buildHardware == 'vbox86' ||
      buildProduct == 'sdk' ||
      buildProduct == 'google_sdk' ||
      buildProduct == 'sdk_x86' ||
      buildProduct == 'vbox86p' ||
      em.brand.contains('google') ||
      em.board.toLowerCase().contains('nox') ||
      em.bootloader.toLowerCase().contains('nox') ||
      buildHardware.toLowerCase().contains('nox') ||
      !em.isPhysicalDevice ||
      buildProduct.toLowerCase().contains('nox'));
  if (result) return true;
  result = result ||
      (em.brand.startsWith('generic') && em.device.startsWith('generic'));
  if (result) return true;
  result = result || ('google_sdk' == buildProduct);
  return result;
}
