class AuthRepository {
  Future<void> login(String username, String password) async {
    print('attemping to login');
    await Future.delayed(const Duration(seconds: 3));
    print('login successful');
    // throw Exception('Login Failure');
  }
}