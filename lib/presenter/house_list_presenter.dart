import '../models/house/house_model_update.dart';
import '../repository/house_repository.dart';
import '../screens/house_list.dart';


class HouseListPresenter {
  final HouseRepository houseRepository = HouseRepository();
  List<HouseModelUpdate> housesList = [];
  List<HouseModelUpdate> housesLikingList = [];
  late HouseListView _backView= HouseListView();
  HouseListPresenter() {
    getAllHouses();
    getLikingHouses();
  }

  void getAllHouses() async {
    try {
      final houses = await houseRepository.getAllHouses();
      if (houses != null) {
        housesList = houses;
        _backView.refreshHouseListView(housesList,housesLikingList);
      }
    } catch (error) {
      rethrow;
    }
  }

  void getLikingHouses() async {
    try {
      final houses = await houseRepository.getSimilarLikingHouses("3rzGsju5Bznuyp7t1tla");
      if (houses != null) {
        housesLikingList = houses;
        _backView.refreshHouseListView(housesList,housesLikingList);
      }
    } catch (error) {
      rethrow;
    }
  }



  set backView(HouseListView value) {
    _backView = value;
    _backView.refreshHouseListView(housesList,housesLikingList);
  }

}