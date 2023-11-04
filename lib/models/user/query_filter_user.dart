class UserFilter {

  static final UserFilter _instance = UserFilter._internal();

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

  factory UserFilter() {
    return _instance;
  }

  UserFilter._internal() {

  }

  bool? getPetPreference() {
    return petPreference;
  }

  String? getIntrovertedPreference() {
    return introvertedPreference;
  }

  String? getCleaningFrequency() {
    return cleaningFrequency;
  }

  bool? getVapePreference() {
    return vapePreference;
  }

  bool? getSmokePreference() {
    return smokePreference;
  }

  bool? getWorkFromHomePreference() {
    return workFromHomePreference;
  }

  int? getSleepTime() {
    return sleepTime;
  }

  String? getExternalPeopleFrequency() {
    return externalPeopleFrequency;
  }

  String? getCity() {
    return city;
  }

  String? getNeighborhood() {
    return neighborhood;
  }

  void setPetPreference(String? preference) {
    if (preference == "Yes"){
      petPreference=true;
    } else if (preference=="No"){
      petPreference=false;
    }
    else {
      petPreference=null;
    }
  }

  void setIntrovertedPreference(String? preference) {
    if (preference!.isEmpty) {
      introvertedPreference = null;
    } else {
      introvertedPreference = preference;
    }
  }

  void setCleaningFrequency(String? frequency) {
    if (frequency!.isEmpty || frequency == "No aplica") {
      cleaningFrequency = null;
    } else {
      cleaningFrequency = frequency;
    }
  }

  void setVapePreference(String? preference) {
    if (preference=="Yes"){
      vapePreference = true;
    } else if (preference=="No"){
      vapePreference = false;
    }
    else {
      vapePreference = null;
    }
  }

  void setSmokePreference(String? preference) {
    if (preference=="Yes"){
      smokePreference = true;
    } else if (preference=="No"){
      smokePreference = false;
    }
    else {
      smokePreference = null;
    }

  }

  void setWorkFromHomePreference(String? preference) {
    if (preference=="Yes"){
      workFromHomePreference = true;
    } else if (preference=="No"){
      workFromHomePreference = false;
    } else {
      workFromHomePreference = null;
    }

  }

  void setSleepTime(String? time) {
    if (time!.isEmpty || time=='No aplica'){
      sleepTime = null;
    }
    else{
      int? parts = int.tryParse(time.split(":")[0]);
      sleepTime = parts;
    }
  }

  void setExternalPeopleFrequency(String? frequency) {
    externalPeopleFrequency = frequency;
    if ( frequency!.isEmpty || frequency=='No aplica') {
      externalPeopleFrequency = null;
    } else {
      externalPeopleFrequency = frequency;
    }
  }

  void setCity(String? cityName) {
    if (cityName!="Seleccione una opción"){
      city = cityName;
    }
    else{
      city = null;
    }

  }

  void setNeighborhood(String? neighborhoodName) {
    if (neighborhoodName=="Seleccione una opción"){
      neighborhood = null;
    }
    else {
      neighborhood = neighborhoodName;
    }
  }

}