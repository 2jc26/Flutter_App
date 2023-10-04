import 'package:json_annotation/json_annotation.dart';

part 'house_searching_model_update.g.dart';

@JsonSerializable()
class HouseSearchingModelUpdate {
  String city;
  String neighborhood;
  String address;
  String housingType;
  String rentPrice;
  int stratum;
  double area;
  int apartmentFloor;
  int roomsNumber;
  int bathroomsNumber;
  bool laundryArea;
  bool internet;
  bool tv;
  bool furnished;
  bool elevator;
  bool gymnasium;
  bool reception;
  bool supermarkets;
  // Image
  HouseSearchingModelUpdate({
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.housingType,
    required this.rentPrice,
    required this.stratum,
    required this.area,
    required this.apartmentFloor,
    required this.roomsNumber,
    required this.bathroomsNumber,
    required this.laundryArea,
    required this.internet,
    required this.tv,
    required this.furnished,
    required this.elevator,
    required this.gymnasium,
    required this.reception,
    required this.supermarkets,
  });

  factory HouseSearchingModelUpdate.fromJson(Map<String, dynamic> json) =>
      _$HouseSearchingModelUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$HouseSearchingModelUpdateToJson(this);
}