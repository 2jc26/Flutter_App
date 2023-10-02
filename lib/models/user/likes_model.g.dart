// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikesModel _$LikesModelFromJson(Map<String, dynamic> json) => LikesModel(
      id: json['id'] as int,
      likes_pet: json['likes_pet'] as bool,
      personality: json['personality'] as String,
      sleep: json['sleep'] as int,
      bring_people: json['bring_people'] as bool,
      clean: json['clean'] as String,
      smoke: json['smoke'] as String,
    );

Map<String, dynamic> _$LikesModelToJson(LikesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'likes_pet': instance.likes_pet,
      'personality': instance.personality,
      'sleep': instance.sleep,
      'bring_people': instance.bring_people,
      'clean': instance.clean,
      'smoke': instance.smoke,
    };
