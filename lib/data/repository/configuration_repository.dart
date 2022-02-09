import 'package:movie_app_task/core/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sharedpreference/sharedpreference.dart';

class ConfigurationRepository {
  final SharedPreferences _sharedPreferences;

  ConfigurationRepository(
    this._sharedPreferences,
  );

  bool? getRememberMeStatus() {
    return _sharedPreferences.getBool(AppKey.rememberMe);
  }

  void setRememberMeStatus(bool value) {
    _sharedPreferences.setBool(AppKey.rememberMe, value);
  }
}
