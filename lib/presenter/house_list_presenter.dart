import 'dart:typed_data';

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

  Future<Uint8List?> getImage(String image) async {
    return houseRepository.getImage(image);
  }

  set backView(HouseListView value) {
    _backView = value;
    _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
  }

}