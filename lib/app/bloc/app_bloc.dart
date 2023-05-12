import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_game/main.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required bool internetConnection, required String url})
      : super(AppState(internetConnection: internetConnection, url: url)) {
    on<ConnectionEstablished>(_connectionEstablished);

    if (!internetConnection) {
      _connectivitySubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result != ConnectivityResult.none) {
          add(ConnectionEstablished());
        }
      });
    }
  }

  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void _connectionEstablished(
      ConnectionEstablished event, Emitter<AppState> emit) async {
    _connectivitySubscription.cancel();

    final String url = await getUrl();

    emit(AppState(internetConnection: true, url: url));
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
