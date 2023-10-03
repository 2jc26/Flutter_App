import '../models/house/house_model_update.dart';
import '../repository/house_repository.dart';
import '../screens/house_list.dart';


class HouseListPresenter {
  final HouseRepository houseRepository = HouseRepository();
  List<HouseModelUpdate>? housesList = [];
  late HouseListView _backView= HouseListView();
  HouseListPresenter() {
    getAllHouses();
  }

  void getAllHouses() async {
    try {
      final houses = await houseRepository.getAllHouses();
      if (houses != null) {
        housesList = houses;
        _backView.refreshHouseListView(housesList!);
      }
    } catch (error) {
      rethrow;
    }
  }

  set backView(HouseListView value) {
    _backView = value;
    _backView.refreshHouseListView(housesList!);
  }

}