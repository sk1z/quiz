import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ThemeData get theme => kDebugMode ? _createTheme : _releaseTheme;

final _releaseTheme = _createTheme;

ThemeData get _createTheme {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xff55b993),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 21),
      bodyMedium: TextStyle(fontSize: 21),
    ),
  );
}
