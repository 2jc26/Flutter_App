import 'package:json_annotation/json_annotation.dart';

part 'house_filtering_model_update.g.dart';

@JsonSerializable()
class HouseFilteringModelUpdate {
  int city;
  int neighborhood;
  int address;
  int housingType;
  int rentPrice;
  int stratum;
  int area;
  int apartmentFloor;
  int roomsNumber;
  int bathroomsNumber;
  int laundryArea;
  int internet;
  int tv;
  int furnished;
  int elevator;
  int gymnasium;
  int reception;
  int supermarkets;
  // Image
  HouseFilteringModelUpdate({
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

  factory HouseFilteringModelUpdate.fromJson(Map<String, dynamic> json) =>
      _$HouseFilteringModelUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$HouseFilteringModelUpdateToJson(this);
}