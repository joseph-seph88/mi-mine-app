import 'package:catching_josh/catching_josh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  final SharedPreferences _prefs;

  PrefsService(this._prefs);

  Future<StandardResult> setString(String key, String value) async {
    return await joshAsync(
      () => _prefs.setString(key, value),
      logTitle: '[PrefsService-setString]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  StandardResult getString(String key) {
    return joshSync(
      () => _prefs.getString(key),
      logTitle: '[PrefsService-getString]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> setBool(String key, bool value) async {
    return await joshAsync(
      () => _prefs.setBool(key, value),
      logTitle: '[PrefsService-setBool]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  StandardResult getBool(String key) {
    return joshSync(() {
      return _prefs.getBool(key);
    }, logTitle: '[PrefsService-getBool]');
  }

  Future<StandardResult> setInt(String key, int value) async {
    return await joshAsync(() {
      return _prefs.setInt(key, value);
    }, logTitle: '[PrefsService-setInt]');
  }

  StandardResult getInt(String key) {
    return joshSync(
      () => _prefs.getInt(key),
      logTitle: '[PrefsService-getInt]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> remove(String key) async {
    return await joshAsync(
      () => _prefs.remove(key),
      logTitle: '[PrefsService-remove]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }

  Future<StandardResult> clear() async {
    return await joshAsync(
      () => _prefs.clear(),
      logTitle: '[PrefsService-clear]',
      showErrorLog: true,
      showSuccessLog: true,
    );
  }
}
