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
  void initState() {
    _userId = widget.userId;

    principalPresenter = PrincipalPresenter(widget.userId);

    principalPresenter.backView = this;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,  // Configura el desplazamiento horizontal
                  itemCount: _userList?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
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
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: SizedBox(
            //     height: 400,
            //     width: 300,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,  // Configura el desplazamiento horizontal
            //       itemCount: _housesList?.length,
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () {
            //             Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) => HouseDetail(house: _housesList![index]),
            //             ));
            //           },
            //           child: InfoCard(
            //             name: _userList![index].full_name,
            //             rating: _userList![index].stars,
            //             address: '${_userList![index].city}-${_userList![index].locality}',
            //             imageUrl: _userList![index].image,
            //             imageWidth: 300,
            //             imageHeight: 300,
            //             padding: 20,
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ]
        ),
      ),
      bottomNavigationBar: const BottomNavBar(index: 0),
    );
  }

}
