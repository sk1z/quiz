import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_game/bloc/quiz_bloc.dart';
import 'package:quiz_game/pages/pages.dart';

class App extends StatelessWidget {
  App({super.key}) : _quizBloc = QuizBloc();

  final QuizBloc _quizBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _quizBloc,
      child: MaterialApp.router(
        title: 'Quiz Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        routerConfig: _router,
      ),
    );
  }

  late final _QuizStateRefreshStream _quizState =
      _QuizStateRefreshStream(_quizBloc);

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/stage/:stage',
        builder: (BuildContext context, GoRouterState state) {
          return StagePage(stage: int.parse(state.params['stage']!));
        },
      ),
      GoRoute(
        path: '/result',
        builder: (BuildContext context, GoRouterState state) {
          return const ResultPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final int stage = _quizState.state.stage;
      if (stage == -1) {
        return '/';
      } else if (stage > -1) {
        return '/stage/$stage';
      } else if (stage == -2) {
        return '/result';
      }
    },
    refreshListenable: _quizState,
  );
}

class _QuizStateRefreshStream extends ChangeNotifier {
  _QuizStateRefreshStream(QuizBloc bloc) : _state = bloc.state {
    _subscription = bloc.stream.asBroadcastStream().listen((state) {
      if (state != _state) {
        _state = state;
        notifyListeners();
      }
    });
  }

  late final StreamSubscription<QuizState> _subscription;

  QuizState _state;
  QuizState get state => _state;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
