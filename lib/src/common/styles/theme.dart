import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData light() => ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    colorScheme: const ColorScheme.light(),
  );

  static ThemeData dark() => ThemeData(
    scaffoldBackgroundColor: AppColor.n212121,
    colorScheme: const ColorScheme.dark(),
  );
}