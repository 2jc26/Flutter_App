import 'package:flutter/cupertino.dart';

class UserPreferencesDTO {
  bool? petPreference;
  String? introvertedPreference;
  String? cleaningFrequency;
  bool? vapePreference;
  bool? smokePreference;
  bool? workFromHomePreference;
  int? sleepTime;
  String? externalPeopleFrequency;
  String? city;
  String? neighborhood;

  UserPreferencesDTO({
    this.city,
    this.neighborhood,
    this.petPreference,
    this.introvertedPreference,
    this.cleaningFrequency,
    this.vapePreference,
    this.smokePreference,
    this.workFromHomePreference,
    this.sleepTime,
    this.externalPeopleFrequency,
  });
}