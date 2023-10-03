import 'package:json_annotation/json_annotation.dart';

part 'house_model_update.g.dart';

@JsonSerializable()
class HouseModelUpdate {
  String id;
  String name;
  String city;
  String neighborhood;
  String address;
  String housingType;
  String rentPrice;
  int stratum;
  double area;
  int apartmentFloor;
  int roomsNumber;
  double roomArea;
  int bathroomsNumber;
  bool laundryArea;
  bool internet;
  bool tv;
  bool furnished;
  bool elevator;
  bool gymnasium;
  bool reception;
  bool supermarkets;
  String description;
  int rating;
  double longitude;
  double latitude;
  // Image
  HouseModelUpdate({
    required this.id,
    required this.name,
    required this.city,
    required this.neighborhood,
    required this.address,
    required this.housingType,
    required this.rentPrice,
    required this.stratum,
    required this.area,
    required this.apartmentFloor,
    required this.roomsNumber,
    required this.roomArea,
    required this.bathroomsNumber,
    required this.laundryArea,
    required this.internet,
    required this.tv,
    required this.furnished,
    required this.elevator,
    required this.gymnasium,
    required this.reception,
    required this.supermarkets,
    required this.description,
    required this.rating,
    required this.longitude,
    required this.latitude,
  });

  factory HouseModelUpdate.fromJson(Map<String, dynamic> json) =>
      _$HouseModelUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$HouseModelUpdateToJson(this);
}