import 'package:json_annotation/json_annotation.dart';

part 'user_link_model.g.dart';

@JsonSerializable()
class UserLikingsLinkModel{

  String username;
  int liking_id;

  UserLikingsLinkModel({
    required this.username,
    required this.liking_id,
  });

  factory UserLikingsLinkModel.fromJson(Map<String, dynamic> json) =>
      _$UserLikingsLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserLikingsLinkModelToJson(this);
}