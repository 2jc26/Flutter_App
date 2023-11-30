import 'dart:io';
import 'dart:typed_data';

import 'package:giusseppe_flut/screens/house_creation.dart';

import '../models/house/house_model_update.dart';
import '../repository/house_repository.dart';

class HouseCreationPresenter {

  final HouseRepository houseRepository = HouseRepository();

  HouseModelUpdate? house;

  late HouseCreationView _backView = HouseCreationView();

  HouseListPresenter() {
    getTopDescriptions();
  }

  void getTopDescriptions() async {
    _backView.refreshHouseCreationView(await houseRepository.getTopDescriptions());
  }

  void createHouse(String userId,String name, String housingType, String rentPrice, String description, String city, String neighborhood, String address, String floor, String appartmentArea, String roomsNumber, String roomArea, String bathroomNumber, String stratum, bool elevator, bool furnished, bool gymnasium, bool internet, bool laundryArea, bool pets, bool reception, bool smoke, bool supermarkets, bool tv, bool vape, List<File> images) async {
    try {
      // TODO: Upload Images to Firebase Storage
      String path = "/images_houses/$name/$city/$neighborhood/$address/";
      // List<String> imagesUrls = await houseRepository.uploadHouseImages(path, images); //TODO Uncomment when storage bug is fixed
      // HouseModelUpdate house = HouseModelUpdate(id: "", name: name, city: city, neighborhood: neighborhood, address: address, housingType: housingType, rentPrice: double.parse(rentPrice), stratum: int.parse(stratum), area: double.parse(appartmentArea), apartmentFloor: int.parse(floor), roomsNumber: int.parse(roomsNumber), roomArea: double.parse(roomArea), bathroomsNumber: int.parse(bathroomNumber), laundryArea: laundryArea, internet: internet, tv: tv, furnished: furnished, elevator: elevator, gymnasium: gymnasium, reception: reception, supermarkets: supermarkets, description: description, rating: 5, longitude: -74.069, latitude: 4.6487, images: imagesUrls);
      HouseModelUpdate house = HouseModelUpdate(id: "", name: name, city: city, neighborhood: neighborhood, address: address, housingType: housingType, rentPrice: double.parse(rentPrice), stratum: int.parse(stratum), area: double.parse(appartmentArea), apartmentFloor: int.parse(floor), roomsNumber: int.parse(roomsNumber), roomArea: double.parse(roomArea), bathroomsNumber: int.parse(bathroomNumber), laundryArea: laundryArea, internet: internet, tv: tv, furnished: furnished, elevator: elevator, gymnasium: gymnasium, reception: reception, supermarkets: supermarkets, description: description, rating: 5, longitude: -74.069, latitude: 4.6487, images: ["https://firebasestorage.googleapis.com/v0/b/senehouse-v2.appspot.com/o/images_houses%2FMariposas%20Doradas_Bogota_Teusaquillo_Avenida%206%20%2322-10%2F1.jpg?alt=media&token=5d3f54d1-67a4-467b-8faf-ac04987e5a64"]);
      houseRepository.createHouse(house);
    } catch (error) {
      rethrow;
    }
  }

  set backView(HouseCreationView value) {
    _backView = value;
  }

}