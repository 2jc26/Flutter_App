import 'package:giusseppe_flut/storage/storage_adapters/shared_preference_manager.dart';

abstract class DefaultStorage {
  
  Future<SharedPreferencesAdapter> get adapter async => SharedPreferencesAdapter();
}
