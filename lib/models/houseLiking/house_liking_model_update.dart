import 'package:json_annotation/json_annotation.dart';

part 'house_liking_model_update.g.dart';

@JsonSerializable()
class HouseLikingModelUpdate {
  String city;
  int stratum;
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
  HouseLikingModelUpdate({
    required this.city,
    required this.stratum,
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

  factory HouseLikingModelUpdate.fromJson(Map<String, dynamic> json) =>
      _$HouseLikingModelUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$HouseLikingModelUpdateToJson(this);
}