

import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import '../service/connectivity_manager_service.dart';
import 'dart:async';

import '../service_adapter/house/dao_house_entity.dart';
import '../service_adapter/houseSearching/dao_house_searching_entity.dart';

class SearchRepository {

  final HouseSearchingDaoFireStore houseSearchDao= HouseSearchingDaoFireStore();

  final HouseDaoFireStore houseDao= HouseDaoFireStore();

  late StreamSubscription<bool> connectionSubscription;
  bool connectivity = ConnectivityManagerService().connectivity;

  SearchRepository() {
    connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }

  Future<List<HouseModelUpdate>> getSimilarFilteredHouses(HouseSearchingModelUpdate houseFilters, {int skip = 0, int limit= 5}) async {
    try {
      if(connectivity) {
        return await houseDao.getHousesByFilters(houseFilters, skip: skip, limit: limit);
      } else {
        return []; // TODO: remove and add local/cache behavior
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<int> getLenght(HouseSearchingModelUpdate? houseFilters){
    try {
      if(connectivity) {
        return houseDao.getLenghtFilters(houseFilters);
      } else {
        return Future.value(0);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateHouseSearchingById(String id, HouseSearchingModelUpdate searchFilters) async {
    try {
      if(connectivity) {
        await houseSearchDao.updateHouseSearchingById(id, searchFilters);
      } else {
        await houseSearchDao.updateHouseSearchingById(id, searchFilters); // TODO: remove and add local/cache behavior
      }
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