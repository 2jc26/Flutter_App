// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLikingsLinkModel _$UserLikingsLinkModelFromJson(
        Map<String, dynamic> json) =>
    UserLikingsLinkModel(
      username: json['username'] as String,
      liking_id: json['liking_id'] as int,
    );

Map<String, dynamic> _$UserLikingsLinkModelToJson(
        UserLikingsLinkModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'liking_id': instance.liking_id,
    };
