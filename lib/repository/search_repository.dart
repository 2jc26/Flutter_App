
import 'package:giusseppe_flut/dao/house/dao_house_entity.dart';
import 'package:giusseppe_flut/dao/houseSearching/dao_house_searching_entity.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';

class SearchRepository {

  final HouseSearchingDaoFireStore houseSearchDao= HouseSearchingDaoFireStore();

  final HouseDaoFireStore houseDao= HouseDaoFireStore();

  Future<List<HouseModelUpdate>> getAllHouses() async {
    try {
      return await houseDao.getAllHouses();
    } catch (error) {
      rethrow;
    }
  }

  Future<HouseSearchingModelUpdate?> getHouseById(String id) async {
    try {
      return await houseSearchDao.getHouseSearchingById(id);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateHouseSearchingById(String id, HouseSearchingModelUpdate searchFilters) async {
    try {
      await houseSearchDao.updateHouseSearchingById(id, searchFilters);
    } catch (error) {
      rethrow;
    }
  }

}