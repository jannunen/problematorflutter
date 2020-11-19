import 'package:problemator/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedObjects {
  static CachedSharedPreferences prefs;
}

class CachedSharedPreferences {
  static SharedPreferences sharedPreferences;
  static CachedSharedPreferences instance;

  static final cachedKeyList = {
    Constants.firstRun,
    Constants.sessionUid,
    Constants.sessionUsername,
    Constants.sessionName,
    Constants.configDarkMode,
  };

  static final sessionKeyList = {
    Constants.sessionName,
    Constants.sessionUid,
    Constants.sessionUsername,
  };
  static Map<String, dynamic> map = Map();

  static Future<CachedSharedPreferences> getInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(Constants.firstRun) == null ||
        sharedPreferences.get(Constants.firstRun)) {
      // if first run, then set these values
      await sharedPreferences.setBool(Constants.configDarkMode, false);
      await sharedPreferences.setBool(Constants.configImageCompression, true);
      await sharedPreferences.setBool(Constants.firstRun, false);
    }
    for (String key in cachedKeyList) {
      map[key] = sharedPreferences.get(key);
    }
    if (instance == null) {
      instance = CachedSharedPreferences();
    }
    return instance;
  }

  String getString(String key) {
    if (cachedKeyList.contains(key)) {
      return map[key];
    }
    return sharedPreferences.getString(key);
  }

  bool getBool(String key) {
    if (cachedKeyList.contains(key)) {
      return map[key];
    }
    return sharedPreferences.getBool(key);
  }

  Future<bool> setString(String key, String value) async {
    bool result = await sharedPreferences.setString(key, value);
    if (result) map[key] = value;
    return result;
  }

  Future<bool> setBool(String key, bool value) async {
    bool result = await sharedPreferences.setBool(key, value);
    if (result) map[key] = value;
    return result;
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
    map = Map();
  }

  Future<void> clearSession() async {
    await sharedPreferences.remove(Constants.sessionUsername);
    await sharedPreferences.remove(Constants.sessionUid);
    await sharedPreferences.remove(Constants.sessionName);
    map.removeWhere((k, v) => (sessionKeyList.contains(k)));
  }
}
