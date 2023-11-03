import 'package:giusseppe_flut/storage/preference_storages/defautl_storage.dart';

class IdProvider extends DefaultStorage {

  Future<String?> getId() async {
    final adapter = await this.adapter;
    return adapter.readStr(key: 'id');
  }

  Future<void> setId(String id) async {
    final adapter = await this.adapter;
    adapter.writeStr(key: 'id', value: id);
  }
}