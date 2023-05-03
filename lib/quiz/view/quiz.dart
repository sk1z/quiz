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
        theme: theme,
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
        path: '/question/:question_number',
        builder: (BuildContext context, GoRouterState state) {
          return QuizQuestionPage(
            questionNumber: int.parse(state.params['question_number']!),
            score: int.parse(state.queryParams['score']!),
            health: int.parse(state.queryParams['health']!),
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
      final int questionNumber = state.questionNumber;
      if (questionNumber == -1) {
        return '/';
      } else if (questionNumber > -1) {
        return '/question/${state.questions[questionNumber]}'
            '?score=${state.score}&health=${state.health}';
      }
      return '/result';
    },
    refreshListenable: _quizState,
  );
}

class _QuizStateRefreshStream extends ChangeNotifier {
  _QuizStateRefreshStream(QuizBloc bloc) : _state = bloc.state {
    _subscription = bloc.stream.asBroadcastStream().listen((state) {
      if (state.questionNumber != _state.questionNumber) {
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
