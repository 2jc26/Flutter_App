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
  UserPreferencesDTO.fromTexts({
    String? petText,
    String? introvertedText,
    String? cleaningText,
    String? vapeText,
    String? smokeText,
    String? workFromHomeText,
    String? sleepTimeText,
    String? externalPeopleText,
    String? city,
    String? neighborhood,
  }) {
    petPreference = petText == "yes" ? true : (petText == "no" ? false : null);
    introvertedPreference = introvertedText;
    cleaningFrequency = cleaningText;
    vapePreference = vapeText == "yes" ? true : (vapeText == "no" ? false : null);
    smokePreference = smokeText == "yes" ? true : (smokeText == "no" ? false : null);
    workFromHomePreference = workFromHomeText == "yes" ? true : (workFromHomeText == "no" ? false : null);
    sleepTime = int.tryParse(sleepTimeText!) ?? 0;
    externalPeopleFrequency = externalPeopleText;
  }
}