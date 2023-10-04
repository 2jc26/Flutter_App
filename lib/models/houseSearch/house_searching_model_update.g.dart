// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_searching_model_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseSearchingModelUpdate _$HouseSearchingModelUpdateFromJson(
        Map<String, dynamic> json) =>
    HouseSearchingModelUpdate(
      city: json['city'] as String,
      neighborhood: json['neighborhood'] as String,
      address: json['address'] as String,
      housingType: json['housingType'] as String,
      rentPrice: json['rentPrice'] as String,
      stratum: json['stratum'] as int,
      area: (json['area'] as num).toDouble(),
      apartmentFloor: json['apartmentFloor'] as int,
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

Map<String, dynamic> _$HouseSearchingModelUpdateToJson(
        HouseSearchingModelUpdate instance) =>
    <String, dynamic>{
      'city': instance.city,
      'neighborhood': instance.neighborhood,
      'address': instance.address,
      'housingType': instance.housingType,
      'rentPrice': instance.rentPrice,
      'stratum': instance.stratum,
      'area': instance.area,
      'apartmentFloor': instance.apartmentFloor,
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
