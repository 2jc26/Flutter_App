import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/models/user/user_model.dart';
import 'package:giusseppe_flut/presenter/principal_presenter.dart';
import 'package:giusseppe_flut/screens/house_detail.dart';
import 'package:giusseppe_flut/widgets/bottom_nav_bar.dart';
import 'package:giusseppe_flut/widgets/custom_app_bar.dart';
import 'package:giusseppe_flut/widgets/info_card.dart';

class PrincipalViewAbs {
  void refreshHousesPrincipalView(List<HouseModelUpdate> housesList) {}
  void refreshUsersPrincipalView(List<UserModel> userList) {}
  void refreshReviewsPrincipalView(List<ReviewModel> reviewList) {}
  void refreshNumber(int number) {}
}

class PrincipalView extends StatefulWidget {
  const PrincipalView(
      {super.key, required this.userId});

  final String userId;

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> implements PrincipalViewAbs {
  
  late PrincipalPresenter principalPresenter;

  String? _userId;
  int _number = 0;

  List<HouseModelUpdate>? _housesList;
  List<UserModel>? _userList;
  List<ReviewModel>? _reviewList;

  @override
  void refreshHousesPrincipalView(List<HouseModelUpdate> housesList) {
    setState(() {
      _housesList = housesList;
    });
  }

  @override
  void refreshUsersPrincipalView(List<UserModel> userList) {
    setState(() {
      _userList = userList;
    });
  }

  @override
  void refreshReviewsPrincipalView(List<ReviewModel> reviewList) {
    setState(() {
      _reviewList = reviewList;
    });
  }

  @override
  void refreshNumber(int number) {
    setState(() {
      _number = number;
    });
  }

  @override
  void initState() {
    _userId = widget.userId;

    principalPresenter = PrincipalPresenter(widget.userId);

    principalPresenter.backView = this;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:12.0, bottom:12.0),
              child: 
              SizedBox(
                width: double.infinity, // Make the container take up all available width
                child: Image.asset(
                  'assets/images/Banner.jpg', // Replace with your image URL
                  fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the entire container
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Top Apartaments:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFF2E5EAA),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 400,
                width: 300,
                child: 
                _housesList == null
                ? const Center(child: CircularProgressIndicator())
                : _housesList!.isEmpty
                    ? const Center(child: Text('No houses availables at the moment'))
                  : ListView.builder(
                  scrollDirection: Axis.horizontal,  // Configura el desplazamiento horizontal
                  itemCount: _housesList?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        principalPresenter.addVisitToHouse(_housesList![index].id);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HouseDetail(house: _housesList![index]),
                        ));
                      },
                      child: InfoCard(
                        name: _housesList![index].name,
                        rating: _housesList![index].rating,
                        address: _housesList![index].address,
                        imageUrl: _housesList![index].images[0],
                        imageWidth: 300,
                        imageHeight: 300,
                        padding: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            const Text(
              'Top Users:',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xFF2E5EAA),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 400,
                width: 300,
                child: 
                _userList == null
                ? const Center(child: CircularProgressIndicator())
                : _userList!.isEmpty
                    ? const Center(child: Text('No Users availables at the moment'))
                  : ListView.builder(
                  scrollDirection: Axis.horizontal,  // Configura el desplazamiento horizontal
                  itemCount: _userList?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => HouseDetail(house: _userList![index]),
                        // ));
                      },
                      child: InfoCard(
                        name: _userList![index].full_name,
                        rating: _userList![index].stars,
                        address: '${_userList![index].city}-${_userList![index].locality}',
                        imageUrl: _userList![index].image,
                        imageWidth: 300,
                        imageHeight: 300,
                        padding: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            const Text(
              'Reviews del usuario:',
              
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Color(0xFF2E5EAA),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

             _reviewList == null
                ? const Center(child: CircularProgressIndicator())
                : _reviewList!.isEmpty
                    ? const Center(child: Text('No comments'))
                    : ListView.builder(
                        shrinkWrap: true, // Use shrinkWrap to avoid the error
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _reviewList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            child: ListTile(
                              title: Text(index.toString()),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Rating: ${_reviewList![index].rating}'),
                                      
                                  Text(
                                      'Comment: ${_reviewList![index].comment}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: SizedBox(
                            width: screenSize.width,
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _number,
                              itemBuilder: (BuildContext context, int index) {
                                // Agrega un GestureDetector para permitir clics en cada elemento
                                return GestureDetector(
                                  onTap: () {
                                    principalPresenter.getAllReview(widget.userId, skip: index * 5, limit: 5);
                                  },
                                  child: Container(
                                    width: 50, // Ajusta el ancho del contenedor según tus necesidades
                                    margin: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue, // Color del borde del contenedor
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(), // Números del 1 al _number
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      )
          ]
        ),
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
    );
  }

}
