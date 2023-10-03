import 'package:json_annotation/json_annotation.dart';

part 'likes_model.g.dart';

@JsonSerializable()
class LikesModel{

  int id;
  bool likes_pet;
  String personality;
  int sleep;
  bool bring_people;
  String clean;
  String smoke;

  LikesModel({
    required this.id,
    required this.likes_pet,
    required this.personality,
    required this.sleep,
    required this.bring_people,
    required this.clean,
    required this.smoke,
  });

  factory LikesModel.fromJson(Map<String, dynamic> json) =>
      _$LikesModelFromJson(json);

  Map<String, dynamic> toJson() => _$LikesModelToJson(this);
}