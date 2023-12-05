import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/repository/search_repository.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';

import '../models/house/house_model_update.dart';
import '../repository/house_repository.dart';
import '../screens/house_list.dart';


class HouseListPresenter {
  final HouseRepository houseRepository = HouseRepository();
  final SearchRepository searchRepository = SearchRepository();
  List<HouseModelUpdate> housesList = [];
  List<HouseModelUpdate> housesLikingList = [];
  List<HouseModelUpdate> housesSearchingList = [];
  late HouseListView _backView= HouseListView();
  int _number = 0;
  HouseListPresenter(String? userId, HouseSearchingModelUpdate? houseFilters) {
    // compute(_loadStoredHouseInIsolate, null);
    _loadStoredHouse();
    if(houseFilters != null) {
      getFilteredHouses(houseFilters);
    } else {
      getAllHouses();
      getLikingHouses(userId);
    }
  }


  void refreshData(String? userId, HouseSearchingModelUpdate? houseFilters, {int skip = 0, int limit= 5}) {
    if(houseFilters != null) {
      getFilteredHouses(houseFilters,skip: skip, limit: 5);
    } else {
      getAllHouses(skip: skip, limit: 5);
      getLikingHouses(userId);
    }
  }

  Future<void> getAllHouses({int skip = 0, int limit= 5}) async {
    try {
      _number = await houseRepository.getLenght();
      _number = (_number/5).ceil();
      final houses = await houseRepository.getAllHouses(skip: skip, limit: limit);
      if (houses.isNotEmpty) {
        housesList = houses;        
        _backView.refreshNumber(_number);
        _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
        _backView.acutalized(false);
      }
    } catch (error) {
      rethrow;
    }
  }

  void getLikingHouses(String? userId) async {
    try {
      final houses = await houseRepository.getSimilarLikingHouses(userId!);
      if (houses.isNotEmpty) {
        housesLikingList = houses;
        _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
      }
    } catch (error) {
      rethrow;
    }
  }

  void getFilteredHouses(HouseSearchingModelUpdate? houseFilters, {int skip = 0, int limit= 5}) async {
    try {
      _number = await searchRepository.getLenght(houseFilters);
      _number = (_number/5).ceil();
      final houses = await searchRepository.getSimilarFilteredHouses(houseFilters!, skip: skip, limit: limit);
      housesSearchingList = houses;
      _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
      _backView.refreshNumber(_number);
      _backView.acutalized(false);
    } catch (error) {
      rethrow;
    }
  }

  void addVisitToHouse(String houseId) async {
    try {
      await houseRepository.addVisitToHouse(houseId);
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> _loadStoredHouse() async {
    try {
      Map<String, dynamic>? storedHouse = await houseRepository.getStoredHouseLocalFile();
      if (storedHouse != null && ConnectivityManagerService().connectivity == true) {
        List<File> images = await houseRepository.getLocalImages();
        String path = "/images_houses/${storedHouse['name']}_${storedHouse['city']}_${storedHouse['neighborhood']}_${storedHouse['address']}/";
        List<String> imagesUrls = await houseRepository.uploadHouseImages(path, images);
        houseRepository.createHouse(HouseModelUpdate.fromJson({...storedHouse, "images": imagesUrls}));
        _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
        // Create a snackbar to show success on the creation of the house
        Get.rawSnackbar(
          messageText: const Text(
            'House created successfully!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          isDismissible: true,
          duration: const Duration(seconds: 15),
          backgroundColor: Colors.green[400]!,
          icon: const Icon( Icons.check, color: Colors.white, size: 35,),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
          snackPosition: SnackPosition.TOP
        );
        houseRepository.deleteStoredHouseLocalFile();
        return true;
      }
      return false;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> _loadStoredHouseInIsolate(dynamic _) async {
    return await _loadStoredHouse();
  }


  set backView(HouseListView value) {
    _backView = value;
    _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
  }

}
