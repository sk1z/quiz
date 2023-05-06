import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quiz_game/quiz/quiz.dart';

class Quiz extends StatelessWidget {
  Quiz({super.key, required this.quizBloc});

  final QuizBloc quizBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: quizBloc,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }

  late final _QuizStateRefreshStream _quizState =
      _QuizStateRefreshStream(quizBloc);

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const QuizStartPage();
        },
      ),
      GoRoute(
        path: '/question/:round',
        builder: (BuildContext context, GoRouterState state) {
          return QuizRoundPage(
            round: int.parse(state.params['round']!),
            question: int.parse(state.queryParams['question']!),
            score: int.parse(state.queryParams['score']!),
            answer: int.parse(state.queryParams['answer']!),
          );
        },
      ),
      GoRoute(
        path: '/result',
        builder: (BuildContext context, GoRouterState state) {
          return const QuizResultPage();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final QuizState state = _quizState.state;
      if (state.round == -1) {
        return '/';
      } else if (state.round > -1) {
        return '/question/${state.round + 1}'
            '?question=${state.questions[state.round]}'
            '&score=${state.score}'
            '&answer=${state.answer}';
      }
      return '/result';
    },
    refreshListenable: _quizState,
  );
}

class _QuizStateRefreshStream extends ChangeNotifier {
  _QuizStateRefreshStream(QuizBloc bloc) : _state = bloc.state {
    _subscription = bloc.stream.asBroadcastStream().listen((state) {
      if (state.round != _state.round || state.answer != _state.answer) {
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
