import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/repository/search_repository.dart';

import '../repository/house_repository.dart';


class HouseSearchPresenter {

  final HouseRepository houseRepository = HouseRepository();
  final SearchRepository searchRepository = SearchRepository();

  HouseSearchingModelUpdate? houseSearching;

  void updateHouseSearchingById(String id, HouseSearchingModelUpdate searchFilters) async {
    try {
      await searchRepository.updateHouseSearchingById(id, searchFilters);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateHouseFilters(HouseSearchingModelUpdate searchFilters) async {
    try {
      await searchRepository.updateHouseFilters(searchFilters);
    } catch (error) {
      rethrow;
    }
  }

}