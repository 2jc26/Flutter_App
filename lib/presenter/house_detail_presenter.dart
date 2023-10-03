import '../models/house/house_model_update.dart';
import '../repository/house_repository.dart';
import '../screens/house_detail.dart';


class HouseDetailPresenter {
  final HouseRepository houseRepository = HouseRepository();
  HouseModelUpdate? house;
  late HouseDetailView _backView;

  HouseDetailPresenter(String id) {
    _backView = HouseDetailView();
    getHouseById(id);
  }

  void getHouseById(String id) async {
    try {
      final h = await houseRepository.getHouseById(id);
      if (house != null) {
        house = h;
        _backView.refreshHouseDetailView(house!);
      }
    } catch (error) {
      rethrow;
    }
  }

  set backView(HouseDetailView value) {
    _backView = value;
    _backView.refreshHouseDetailView(house!);
  }

}