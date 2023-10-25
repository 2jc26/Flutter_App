import 'package:giusseppe_flut/dao/house/dao_house_entity.dart';
import 'package:giusseppe_flut/dao/houseLiking/dao_house_liking_entity.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseLiking/house_liking_model_update.dart';

class HouseRepository {
  final HouseDaoFireStore houseDao= HouseDaoFireStore();
  final HouseLikingDaoFireStore houseLikingDao = HouseLikingDaoFireStore();

  Future<List<HouseModelUpdate>> getAllHouses() async {
    try {
      return await houseDao.getAllHouses();
    } catch (error) {
      rethrow;
    }
  }

  Future<HouseModelUpdate> getHouseById(String id) async {
    try {
      return await houseDao.getHouseById(id);
    } catch (error) {
      rethrow;
    }
  }

  Future<List<HouseModelUpdate>> getSimilarLikingHouses(String id) async {
    try {
      HouseLikingModelUpdate? liking = await houseLikingDao.getHouseLikingById(id);
      if (liking == null) {
        return [];
      }
      return await houseDao.getHousesByLikings(liking);
    } catch (error) {
      rethrow;
    }
  }

}