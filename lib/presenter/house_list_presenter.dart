import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/repository/search_repository.dart';

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
  HouseListPresenter(String? userId, HouseSearchingModelUpdate? houseFilters) {
    // compute(_loadStoredHouseInIsolate, null);
    _loadStoredHouse();
    getAllHouses();
    getLikingHouses(userId);
    if(houseFilters != null) {
      getFilteredHouses(houseFilters);
    }
  }


  void refreshData(String? userId, HouseSearchingModelUpdate? houseFilters) {
    getAllHouses();
    getLikingHouses(userId);
    if(houseFilters != null) {
      getFilteredHouses(houseFilters);
    }
  }

  void getAllHouses() async {
    try {
      final houses = await houseRepository.getAllHouses();
      if (houses.isNotEmpty) {
        housesList = houses;
        _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
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

  void getFilteredHouses(HouseSearchingModelUpdate? houseFilters) async {
    try {
      final houses = await searchRepository.getSimilarFilteredHouses(houseFilters!);
      housesSearchingList = houses;
      _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
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
      dynamic storedHouse = await houseRepository.getStoredHouseLocalFile();
      if (storedHouse != null) {
        // String path = "/images_houses/${storedHouse.name}/${storedHouse.city}/${storedHouse.neighborhood}/${storedHouse.address}/";
        // List<String> imagesUrls = await houseRepository.uploadHouseImages(path, storedHouse.images); //TODO Uncomment when storage bug is fixed
        // houseRepository.createHouse(HouseModelUpdate.fromJson({...storedHouse, "images": imagesUrls}));
        houseRepository.createHouse(HouseModelUpdate.fromJson({...storedHouse}));
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
          duration: const Duration(days: 15),
          backgroundColor: Colors.green[400]!,
          icon: const Icon( Icons.check, color: Colors.white, size: 35,),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED
        );

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
