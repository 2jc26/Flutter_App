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
class UserModelUpdate {
  String username;
  String password;
  String name;
  int id;
  int age;
  bool bring_people;
  int sleep;
  int phone;
  String role;
  bool vape;
  String personality;
  String likes_pet;
  String clean;
  String week;
  String smoke;
  String gender;
  // Image
  UserModelUpdate({
    required this.username,
    required this.password,
    required this.name,
    required this.id,
    required this.age,
    required this.bring_people,
    required this.sleep,
    required this.phone,
    required this.role,
    required this.vape,
    required this.personality,
    required this.likes_pet,
    required this.clean,
    required this.week,
    required this.smoke,
    required this.gender,
  });
}
class LikesModel{

  int id;
  bool likes_pet;
  String personality;
  int sleep;
  bool bring_people;
  String clean;
  String smoke;

  LikesModel({
    required this.id,
    required this.likes_pet,
    required this.personality,
    required this.sleep,
    required this.bring_people,
    required this.clean,
    required this.smoke,
  });
}

class UserLikingsLinkModel{

  String username;
  int liking_id;

  UserLikingsLinkModel({
    required this.username,
    required this.liking_id,
  });
}
