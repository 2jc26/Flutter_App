import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'dart:async';

import '../service_adapter/house/dao_house_entity.dart';

class HouseRepository {
  final HouseDaoFireStore houseDao= HouseDaoFireStore();

  Future<List<HouseModelUpdate>> getAllHouses() async {
    try {
      return await houseDao.getAllHouses();
    } catch (error) {
      rethrow;
    }
  }

  Future<List<HouseModelUpdate>> getSimilarLikingHouses(String id) async {
    try {
      return await houseDao.getHouseLikingByUserId(id);
    } catch (error) {
      rethrow;
    }
  }

}