// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_liking_model_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseLikingModelUpdate _$HouseLikingModelUpdateFromJson(
        Map<String, dynamic> json) =>
    HouseLikingModelUpdate(
      city: json['city'] as String,
      stratum: json['stratum'] as int,
      roomsNumber: json['roomsNumber'] as int,
      bathroomsNumber: json['bathroomsNumber'] as int,
      laundryArea: json['laundryArea'] as bool,
      internet: json['internet'] as bool,
      tv: json['tv'] as bool,
      furnished: json['furnished'] as bool,
      elevator: json['elevator'] as bool,
      gymnasium: json['gymnasium'] as bool,
      reception: json['reception'] as bool,
      supermarkets: json['supermarkets'] as bool,
    );

Map<String, dynamic> _$HouseLikingModelUpdateToJson(
        HouseLikingModelUpdate instance) =>
    <String, dynamic>{
      'city': instance.city,
      'stratum': instance.stratum,
      'roomsNumber': instance.roomsNumber,
      'bathroomsNumber': instance.bathroomsNumber,
      'laundryArea': instance.laundryArea,
      'internet': instance.internet,
      'tv': instance.tv,
      'furnished': instance.furnished,
      'elevator': instance.elevator,
      'gymnasium': instance.gymnasium,
      'reception': instance.reception,
      'supermarkets': instance.supermarkets,
    };
