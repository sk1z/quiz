import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_game/app/app.dart';
import 'package:quiz_game/no_connection/view/no_connection_page.dart';
import 'package:quiz_game/quiz/quiz.dart';
import 'package:quiz_game/webview/view/webview_page.dart';

class App extends StatelessWidget {
  App({
    super.key,
    required this.internetConnection,
    this.url,
    required this.remoteConfig,
    required this.isEmu,
  });

  final bool internetConnection;
  final String? url;
  final FirebaseRemoteConfig remoteConfig;
  final bool isEmu;

  final QuizBloc _quizBloc = QuizBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (_) => AppBloc(
            internetConnection: internetConnection,
            url: url,
            remoteConfig: remoteConfig),
        child: BlocBuilder<AppBloc, AppState>(
          builder: (BuildContext context, AppState state) {
            if (!state.internetConnection) {
              return const NoConnectionPage();
            } else if (state.url == null || state.url == '' || isEmu) {
              return BlocProvider.value(
                value: _quizBloc,
                child: Quiz(quizBloc: _quizBloc),
              );
            }

            return WebViewPage(url: state.url!);
          },
        ),
      ),
    );
  }
}
