import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/views_abs.dart';
import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../presenter/user_presenter.dart';
import './roomie_detail.dart';
import '../models/user_model.dart';
import '../widgets/information_card.dart';
import '../widgets/drawer.dart';

class UserList extends StatefulWidget {
  final UserPreferencesDTO? userPreferences;

  const UserList({super.key, required this.title, this.userPreferences});

  final String title;

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> implements UserListView{
  final UserListPresenter userListPresenter = UserListPresenter();
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
    userListPresenter.backView = this;
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
        title: Text(
          widget.title,
          style: const TextStyle(
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0,),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RoommateDetail()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                ),
                child: const Icon(
                  Icons.filter_alt_outlined, 
                  size: 36.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
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
