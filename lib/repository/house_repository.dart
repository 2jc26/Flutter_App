import 'dart:convert';
import 'dart:io';

import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/storage/storage_adapters/file_manager.dart';
import 'dart:async';

import '../service_adapter/house/dao_house_entity.dart';

class HouseRepository {

  FileManager fileManager = FileManager();

  final HouseDaoFireStore houseDao= HouseDaoFireStore();

  bool connectivity = ConnectivityManagerService().connectivity;
  late StreamSubscription<bool> connectionSubscription;

  HouseRepository() {
    FileManager.initialFile();
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
        createFileStoredHouse(house);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<String>> uploadHouseImages(String folderPath, List<File> images) async {
    try {
      List<String> imagesUrl = [];
      if(connectivity) {
        int count = 1;
        for (var image in images) {
          imagesUrl.add((await houseDao.uploadImage(folderPath, image, count.toString()))!);
          count++;
        }
      }
      return imagesUrl;
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

  Future<void> addVisitToHouse(String houseId) async {
    try {
      if(connectivity) {
        await houseDao.addVisitToHouse(houseId);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<String>> getTopDescriptions() async {
    try {
      if(connectivity) {
        return await houseDao.getTopDescriptions();
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

    Future<HouseModelUpdate?> getStoredHouseLocalFile(String username, String password, String id) async {
    try {
      final storedHouse = await fileManager.read(File('${FileManager.directory.path}/storedhouse.json'));
      if (storedHouse != null) {
        return HouseModelUpdate.fromJson({...storedHouse});
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createFileStoredHouse(HouseModelUpdate storedHouse) async {
    try {
      await fileManager.write(File('${FileManager.directory.path}/storedhouse.json'), json.encode(storedHouse.toJson()));
    } catch (error) {
      rethrow;
    }
  }

}