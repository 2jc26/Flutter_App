class AuthCredentials {
  final String username;
  final String? password;
  final String? fullname;
  final int? age;
  final String? phone;
  final String? genero;
  final String? city;
  final String? locality;
  final String userId;

  AuthCredentials({
    required this.username, 
    this.password,
    this.fullname,
    this.age,
    this.phone,
    this.genero,
    this.city,
    this.locality,
    this.userId = '',
  });
} 