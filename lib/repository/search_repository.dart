

import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';

import '../service_adapter/house/dao_house_entity.dart';
import '../service_adapter/houseSearching/dao_house_searching_entity.dart';

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

  Future<List<HouseModelUpdate>> getSimilarFilteredHouses(HouseSearchingModelUpdate houseFilters) async {
    try {
      return await houseDao.getHousesByFilters(houseFilters);
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

  Future<void> updateHouseFilters(HouseSearchingModelUpdate searchFilters) async {
    try {
      await houseSearchDao.updateHouseFilters(searchFilters);
    } catch (error) {
      rethrow;
    }
  }
}