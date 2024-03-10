import 'package:flutter/material.dart';

import 'settings_service.dart';

class Settings extends ChangeNotifier {
  final SettingsService _settingsService;

  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;

  static Settings? _instance;

  static Settings get instance => _instance!;

  factory Settings.init() {
    _instance = _instance ?? Settings._internal(SettingsService())
      ..loadSettings();
    return _instance!;
  }

  Settings._internal(this._settingsService);

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;

    _themeMode = newThemeMode;

    notifyListeners();

    await _settingsService.updateThemeMode(newThemeMode);
  }
}
