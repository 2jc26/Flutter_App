
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

  Future<List<HouseModelUpdate>> getSimilarSearchingHouses(String id) async {
    try {
      HouseSearchingModelUpdate? searching = await houseSearchDao.getHouseSearchingById(id);
      if (searching == null) {
        throw Exception("No house searching found");
      }
      return await houseDao.getHousesBySearchs(searching);
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