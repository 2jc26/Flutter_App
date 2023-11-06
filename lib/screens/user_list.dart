import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:giusseppe_flut/screens/filter_users/filter_users_location.dart';
import 'package:giusseppe_flut/screens/base_mvp/views_abs.dart';
import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../presenter/user_presenter.dart';
import '../widgets/drawer.dart';
import 'InformationCardUser.dart';

class UserList extends StatefulWidget {
  UserPreferencesDTO? userPreferences;

  UserList({Key? key, this.userPreferences}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();

}

class _UserListState extends State<UserList> implements UserListView{

  final UserListPresenter userListPresenter = UserListPresenter();
  List<UserModelUpdate>? _userList;
  double average= 0.0;

  @override
  void refreshUserListView(List<UserModelUpdate> userList, double average) {
    setState(() {
      _userList = userList;
      this.average = average;
    });
  }

  @override
  void initState() {
    super.initState();
    userListPresenter.setUserPreferences();
    userListPresenter.backView = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          "Senehouse",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      // drawer: CustomDrawer(customDrawerContext: context),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0,),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterUsersLocations()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Icon(
                  Icons.filter_alt_outlined,
                  size: 36.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
            Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 15), child:
            Card(
              color: const Color(0xFF2C595B),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child:
              Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                  Column(
                    children: [
                      const Text('Average stars of users:',
                        style:
                        TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Color(0xFFDAE3E5)
                        ),
                      ),

                      Text(
                        '${double.parse((average).toStringAsFixed(2))}',
                        style:
                        const TextStyle(
                            fontWeight: FontWeight.bold,
                            color:Color(0xFFDAE3E5)
                        ),
                      ),
                      RatingBarIndicator(
                        rating: average,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Color(0xFFEDF9B9),
                        ),
                        itemCount: 5,
                        itemSize: 24,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _userList?.length,
              itemBuilder: ((context, index) {
                return InformationCardUser(
                  url: _userList![index].image,
                  stars: _userList![index].stars,
                  text: _userList![index].full_name,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
