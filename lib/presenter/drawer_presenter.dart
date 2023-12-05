import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/repository/search_repository.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';

import '../enum/feature_enum.dart';
import '../models/house/house_model_update.dart';
import '../repository/features_repository.dart';
import '../repository/house_repository.dart';
import '../repository/user_repository.dart';
import '../screens/house_list.dart';
import '../storage/providers/id_provider.dart';
import '../widgets/drawer.dart';


class DrawerPresenter {
  late CustomDrawerView _backView;
  final UserRepository userRepository = UserRepository();
  final FeatureRepository featureRepository= FeatureRepository();
  final IdProvider idProvider = IdProvider();
  late String id= '';
  void setUserPreferences() {
    getImage();
    giveId();
  }

  Future<void> giveId() async {
    id= await idProvider.getId() ?? '';
    _backView.refreshId(id);
  }

  set backView(CustomDrawerView value) {
    _backView = value;
  }

  Future<void> getImage() async {
    try {
      var nuevo = await userRepository.getUserLocalFileLessArgs();
      if (nuevo!=null){
        _backView.refreshImage(nuevo!.image);
      }
    } catch (error) {
      rethrow;
    }
  }
  Future<void> getId() async {
    try {
      var nuevo = await userRepository.getUserLocalFileLessArgs();
      if (nuevo!=null){
        _backView.refreshImage(nuevo!.image);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addUse( Feature type) async {
    try {
      var nuevo = await featureRepository.createFeature(type);
    } catch (error) {
      rethrow;
    }
  }


}
