import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:quiz_game/main.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required bool internetConnection,
    String? url,
    required FirebaseRemoteConfig remoteConfig,
  })  : _remoteConfig = remoteConfig,
        super(AppState(internetConnection: internetConnection, url: url)) {
    on<ConnectionEstablished>(_connectionEstablished);

    if (!internetConnection) {
      _connectivitySubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        log(result.toString());
        if (result.index != 4) {
          add(ConnectionEstablished());
        }
      });
    }
  }

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final FirebaseRemoteConfig _remoteConfig;

  void _connectionEstablished(
      ConnectionEstablished event, Emitter<AppState> emit) async {
    _connectivitySubscription?.cancel();
    final String url = await getUrl(_remoteConfig);

    emit(AppState(internetConnection: true, url: url));
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
