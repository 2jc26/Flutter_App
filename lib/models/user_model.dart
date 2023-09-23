class UserModel {
  String name;
  String path;
  int stars;

  UserModel({
    required this.name,
    required this.path,
    required this.stars,
  });

  static List<UserModel> getUsers() {
    return [
      UserModel(
        name: 'Juan Manuel Rodrigez',
        path: 'assets/images/user1.jpg',
        stars: 3,
      ),
      UserModel(
        name: 'María José Cordoba',
        path: 'assets/images/user2.jpg',
        stars: 5,
      ),
      UserModel(
        name: 'Juan Manuel Rodrigez',
        path: 'assets/images/user1.jpg',
        stars: 1,
      ),
      UserModel(
        name: 'María José Cordoba',
        path: 'assets/images/user2.jpg',
        stars: 2,
      ),
    ];
  }
}