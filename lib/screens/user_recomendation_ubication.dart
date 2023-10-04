import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/views_abs.dart';
import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../presenter/user_presenter.dart';
import '../presenter/user_presenter_location.dart';
import './roomie_detail.dart';
import '../models/user_model.dart';
import '../widgets/information_card.dart';
import '../widgets/drawer.dart';

class UserListLocation extends StatefulWidget {
  UserPreferencesDTO? userPreferences;

  UserListLocation({Key? key, this.userPreferences}) : super(key: key);

  @override
  _UserListLocationState createState() => _UserListLocationState();
}

class _UserListLocationState extends State<UserListLocation> implements UserListView{

  final UserListPresenterLocation userListPresenterLocation = UserListPresenterLocation();
  List<UserModelUpdate>? _userList;
  List<UserModel> Users = [];

  @override
  void refreshUserListView(List<UserModelUpdate> userList) {
    setState(() {
      _userList = userList;
    });
  }

  @override
  void initState() {
    super.initState();
    userListPresenterLocation.setUserPreferences(widget.userPreferences);
    userListPresenterLocation.backView = this;
  }
  void _getUsers() {
    Users = UserModel.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    _getUsers();
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
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _userList?.length,
              itemBuilder: ((context, index) {
                return InformationCard(
                  path: 'assets/images/house1.jpg',
                  stars: 5,
                  text: _userList![index].name,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}