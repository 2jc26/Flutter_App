import 'package:giusseppe_flut/storage/preference_storages/defautl_storage.dart';

class NicknameProvider extends DefaultStorage {

  Future<String?> getNickname() async {
    final adapter = await this.adapter;
    return adapter.readStr(key: 'nickname');
  }

  Future<void> setNickname(String nickname) async {
    final adapter = await this.adapter;
    adapter.writeStr(key: 'nickname', value: nickname);
  }
}