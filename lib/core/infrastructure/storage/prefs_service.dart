import 'package:catching_josh/catching_josh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  final SharedPreferences _prefs;

  PrefsService(this._prefs);

  Future<StandardResult> setString(String key, String value) async {
    return await joshAsync(() => _prefs.setString(key, value));
  }

  Future<StandardResult> setStringList(String key, List<String> value) async {
    return await joshAsync(() => _prefs.setStringList(key, value));
  }

  StandardResult getString(String key) {
    return joshSync(() => _prefs.getString(key));
  }

  StandardResult getStringList(String key) {
    return joshSync(() => _prefs.getStringList(key));
  }

  Future<StandardResult> setBool(String key, bool value) async {
    return await joshAsync(() => _prefs.setBool(key, value));
  }

  StandardResult getBool(String key) {
    return joshSync(() => _prefs.getBool(key));
  }

  Future<StandardResult> setInt(String key, int value) async {
    return await joshAsync(() => _prefs.setInt(key, value));
  }

  StandardResult getInt(String key) {
    return joshSync(() => _prefs.getInt(key));
  }

  Future<StandardResult> remove(String key) async {
    return await joshAsync(() => _prefs.remove(key));
  }

  Future<StandardResult> clear() async {
    return await joshAsync(() => _prefs.clear());
  }
}
