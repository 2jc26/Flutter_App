class AppartmentModel {
  String path;
  int stars;
  String text;

  AppartmentModel({
    required this.path,
    required this.stars,
    required this.text,
  });

  static List<AppartmentModel> getAppartments() {
    return [
      AppartmentModel(
        path: 'assets/images/house1.jpg',
        stars: 5,
        text: 'Teusaquillo\n2 Bathrooms',
      ),
      AppartmentModel(
        path: 'assets/images/house1.jpg',
        stars: 4,
        text: 'Chapinero\n1 Bathroom',
      ),
      AppartmentModel(
        path: 'assets/images/house1.jpg',
        stars: 3,
        text: 'Chapinero\n1 Bathroom',
      ),
      AppartmentModel(
        path: 'assets/images/house1.jpg',
        stars: 2,
        text: 'Teusaquillo\n2 Bathrooms',
      ),
    ];
  }
}