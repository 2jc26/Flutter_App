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
  HouseListPresenter(String? userId) {
    getAllHouses();
    getLikingHouses(userId);
    getSearchingHouses(userId);
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

  void getSearchingHouses(String? userId) async {
    try {
      final houses = await searchRepository.getSimilarSearchingHouses(userId!);
      print(houses);
      if (houses.isNotEmpty) {
        housesSearchingList = houses;
        _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
      }
    } catch (error) {
      rethrow;
    }
  }

  set backView(HouseListView value) {
    _backView = value;
    _backView.refreshHouseListView(housesList,housesLikingList,housesSearchingList);
  }

}