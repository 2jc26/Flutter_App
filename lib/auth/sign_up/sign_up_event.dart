abstract class SignUpEvent {

}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});

}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});

}

class SignUpFullNameChanged extends SignUpEvent {
  final String fullname;

  SignUpFullNameChanged({required this.fullname});

}

class SignUpAgeChanged extends SignUpEvent {
  final int age;

  SignUpAgeChanged({required this.age});

}

class SignUpPhoneChanged extends SignUpEvent {
  final String phone;

  SignUpPhoneChanged({required this.phone});

}

class SignUpGeneroChanged extends SignUpEvent {
  final String genero;

  SignUpGeneroChanged({required this.genero});

}

class SignUpCityChanged extends SignUpEvent {
  final String city;

  SignUpCityChanged({required this.city});

}

class SignUpLocalityChanged extends SignUpEvent {
  final String locality;

  SignUpLocalityChanged({required this.locality});

}

class SignUpSubmitted extends SignUpEvent {

}

class LogOut extends SignUpEvent {

  LogOut();

}