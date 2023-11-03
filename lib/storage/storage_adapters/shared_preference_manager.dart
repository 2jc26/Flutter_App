import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAdapter {
  static SharedPreferencesAdapter? _instance;
  final Future<SharedPreferences> _prefsInstance = SharedPreferences.getInstance();

  factory SharedPreferencesAdapter() {
    _instance ??= SharedPreferencesAdapter._();
    return _instance!;
  }

  SharedPreferencesAdapter._();

  Future<void> remove({required String key}) async {
    final instance = await _prefsInstance;
    instance.remove(key);
  }

  Future<String?> readStr({required String key}) async {
    final instance = await _prefsInstance;
    return instance.getString(key);
  }

  Future<void> writeStr({required String key, required String value}) async {
    final instance = await _prefsInstance;
    await instance.setString(key, value);
  }
}
