import 'package:flutter/material.dart';

class ThemeController {
  ThemeController._();
  static final instance = ThemeController._();

  final ValueNotifier<ThemeMode> mode = ValueNotifier(ThemeMode.light);

  void setDark(bool isDark) =>
      mode.value = isDark ? ThemeMode.dark : ThemeMode.light;
}
