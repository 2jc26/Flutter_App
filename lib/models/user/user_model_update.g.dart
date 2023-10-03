// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelUpdate _$UserModelUpdateFromJson(Map<String, dynamic> json) =>
    UserModelUpdate(
      username: json['username'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      id: json['id'] as int,
      age: json['age'] as int,
      bring_people: json['bring_people'] as String,
      sleep: json['sleep'] as int,
      phone: json['phone'] as int,
      vape: json['vape'] as bool,
      personality: json['personality'] as String,
      likes_pets: json['likes_pets'] as bool,
      clean: json['clean'] as String,
      smoke: json['smoke'] as bool,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$UserModelUpdateToJson(UserModelUpdate instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'id': instance.id,
      'age': instance.age,
      'bring_people': instance.bring_people,
      'sleep': instance.sleep,
      'phone': instance.phone,
      'vape': instance.vape,
      'personality': instance.personality,
      'likes_pets': instance.likes_pets,
      'clean': instance.clean,
      'smoke': instance.smoke,
      'gender': instance.gender,
    };
