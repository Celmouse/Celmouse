import 'dart:convert';

import 'package:controller/src/domain/models/mouse_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MouseSettingsPersistenceService {
  static const String _key = 'current_mouse_move_settings';

  static Future<void> saveSettings(MouseSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(settings.toJson()));
  }

  static Future<MouseSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return MouseSettings();
    return MouseSettings.fromJson(jsonDecode(json));
  }
}
