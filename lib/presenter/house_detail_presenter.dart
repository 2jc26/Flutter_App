import 'dart:typed_data';

import '../models/house/house_model_update.dart';
import '../repository/house_repository.dart';
import '../screens/house_detail.dart';


class HouseDetailPresenter {
  final HouseRepository houseRepository = HouseRepository();
  HouseModelUpdate? house;
  late HouseDetailView _backView;

  HouseDetailPresenter() {
    _backView = HouseDetailView();
  }

  Future<Uint8List?> getImage(String image) async {
    return houseRepository.getImage(image);
  }

  set backView(HouseDetailView value) {
    _backView = value;
    if (house != null) { // Check if house is not null before refreshing the view
      _backView.refreshHouseDetailView(house!);
    }
  }

}