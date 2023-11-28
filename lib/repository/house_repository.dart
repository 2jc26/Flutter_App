import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'dart:async';

import '../service_adapter/house/dao_house_entity.dart';

class HouseRepository {

  final HouseDaoFireStore houseDao= HouseDaoFireStore();

  bool connectivity = ConnectivityManagerService().connectivity;
  late StreamSubscription<bool> connectionSubscription;

  HouseRepository() {
    connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }

  Future<List<HouseModelUpdate>> getAllHouses() async {
    try {
      if(connectivity) {
        return await houseDao.getAllHouses();
      } else {
        return []; //TODO Search in Local
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createHouse(HouseModelUpdate house) async {
    try {
      if(connectivity) {
        houseDao.createHouse(house);
      } else {
        // Save in FIles
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<HouseModelUpdate>> getSimilarLikingHouses(String id) async {
    try {
      if(connectivity) {
        return await houseDao.getHouseLikingByUserId(id);
      } else {
        return []; //TODO Search in Local
      }
    } catch (error) {
      rethrow;
    }
  }

}