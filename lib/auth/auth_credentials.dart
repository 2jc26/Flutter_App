class AuthCredentials {
  final String username;
  final String? password;
  final String userId;

  AuthCredentials({
    required this.username, 
    this.password,
    this.userId = '',
  });
} 