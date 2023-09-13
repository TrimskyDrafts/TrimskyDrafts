import 'package:shared_preferences/shared_preferences.dart';

class Settings {
  static const int lightThemeId = 0, dartThemeId = 1;
  static late SharedPreferences _storage;
  static late bool isBeta;
  static late int themeId;

  static Future<void> loadData() async {
    _storage = await SharedPreferences.getInstance();
    bool? getBetaData = _storage.getBool('beta');
    isBeta = getBetaData ?? false;
    if(getBetaData == null) _storage.setBool('beta', false);

    int? getThemeId = _storage.getInt('theme_id');
    themeId = getThemeId ?? lightThemeId;
    if(getThemeId == null) _storage.setInt('theme_id', lightThemeId);
  }

  static Future<void> setTheme(int themeId) async {
    Settings.themeId = themeId;
    await _storage.setInt('theme_id', themeId);
  }

  static Future<void> setBetaVersion(bool isBeta) async {
    Settings.isBeta = isBeta;
    await _storage.setBool('beta', isBeta);
  }
}