import 'package:giusseppe_flut/dao/house/dao_house_entity.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';

class HouseRepository {
  final HouseDaoFireStore houseDao= HouseDaoFireStore();

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

}