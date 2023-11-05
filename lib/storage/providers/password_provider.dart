import 'package:giusseppe_flut/storage/preference_storages/defautl_storage.dart';

class PasswordProvider extends DefaultStorage {

  Future<String?> getPassword() async {
    final adapter = await this.adapter;
    return adapter.readStr(key: 'password');
  }

  Future<void> setPassword(String password) async {
    final adapter = await this.adapter;
    adapter.writeStr(key: 'password', value: password);
  }
}