import 'dart:convert';
import 'dart:io';

import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
<<<<<<< HEAD
=======
import 'package:giusseppe_flut/storage/storage_adapters/file_manager.dart';
>>>>>>> origin/develop
import 'dart:async';

import '../service_adapter/house/dao_house_entity.dart';

class HouseRepository {

<<<<<<< HEAD
=======
  FileManager fileManager = FileManager();

>>>>>>> origin/develop
  final HouseDaoFireStore houseDao= HouseDaoFireStore();

  bool connectivity = ConnectivityManagerService().connectivity;
  late StreamSubscription<bool> connectionSubscription;

  HouseRepository() {
<<<<<<< HEAD
=======
    FileManager.initialFile();
>>>>>>> origin/develop
    connectionSubscription = ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }

<<<<<<< HEAD
  Future<List<HouseModelUpdate>> getAllHouses() async {
    try {
      if(connectivity) {
        return await houseDao.getAllHouses();
      } else {
        return []; //TODO Search in Local
      }
=======
  Future<List<HouseModelUpdate>> getAllHouses({int skip = 0, int limit= 5}) async {
    try {
      if(connectivity) {
        return await houseDao.getAllHouses(skip: skip, limit: limit);
      } else {
        return []; //TODO Search in Local
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<int> getLenght(){
    try {
      if(connectivity) {
        return houseDao.getLenght();
      } else {
        return Future.value(0);
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

  Future<List<File>> getLocalImages() async {
    try {
      return await fileManager.getLocalImages();
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
      } else {
        fileManager.saveImagesLocally(images);
      }
      return imagesUrl;
>>>>>>> origin/develop
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
<<<<<<< HEAD
=======
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

    Future<Map<String, dynamic>?> getStoredHouseLocalFile() async {
    try {
      final storedHouse = await fileManager.read(File('${FileManager.directory.path}/storedhouse.json'));
      if (storedHouse != null) {
        return storedHouse;
      }
      return null;
    } catch (error) {
      rethrow;
    }
  }

  void deleteStoredHouseLocalFile() async {
    try {
      fileManager.deleteStoredImages();
      await fileManager.delete(File('${FileManager.directory.path}/storedhouse.json'));
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

  Future<List<HouseModelUpdate>> getTopHouses() async {
    try {
      if(connectivity) {
        return await houseDao.getTopHouses();
      } else {
        return [];
      }
>>>>>>> origin/develop
    } catch (error) {
      rethrow;
    }
  }

}