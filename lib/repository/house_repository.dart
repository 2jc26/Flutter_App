import 'dart:typed_data';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseLiking/house_liking_model_update.dart';
import '../service/connectivity_manager_service.dart';
import 'dart:async';

import '../service_adapter/house/dao_house_entity.dart';
import '../service_adapter/houseLiking/dao_house_liking_entity.dart';

class HouseRepository {
  final HouseDaoFireStore houseDao= HouseDaoFireStore();
  final HouseLikingDaoFireStore houseLikingDao = HouseLikingDaoFireStore();
  
  late StreamSubscription<bool> connectionSubscription;
  bool connectivity = ConnectivityManagerService().connectivity;

  HouseRepository() {
    initializeConnectivity();
  }

  Future<void> initializeConnectivity() async {
    connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
      print("internal connectivity" + connectivity.toString());
    });
    print("connectivity" + connectivity.toString());
  }

  Future<List<HouseModelUpdate>> getAllHouses() async {
    try {
      if(connectivity!) {
        return await houseDao.getAllHouses();
      } else {
        return []; // TODO: remove and add local/cache behavior
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Uint8List?> getImage(String image) async {
    return houseDao.getImage(image);
  }

  Future<List<HouseModelUpdate>> getSimilarLikingHouses(String id) async {
    try {
      if(connectivity!) {
        HouseLikingModelUpdate? liking = await houseLikingDao.getHouseLikingById(id);
        if (liking == null) {
          return [];
        }
        return await houseDao.getHousesByLikings(liking);
      } else {
        return []; // TODO: remove and add local/cache behavior
      }
    } catch (error) {
      rethrow;
    }
  }

}