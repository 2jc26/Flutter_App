import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/views_abs.dart';
import '../models/user/query_likes_user.dart';
import '../models/user/user_model_update.dart';
import '../presenter/user_presenter.dart';
import './roomie_detail.dart';
import '../widgets/drawer.dart';

class UserList extends StatefulWidget {
  UserPreferencesDTO? userPreferences;

  UserList({Key? key, this.userPreferences}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> implements UserListView{

  final UserListPresenter userListPresenter = UserListPresenter();
  List<UserModelUpdate>? _userList;

  @override
  void refreshUserListView(List<UserModelUpdate> userList) {
    setState(() {
      _userList = userList;
    });
  }

  @override
  void initState() {
    super.initState();
    userListPresenter.setUserPreferences(widget.userPreferences);
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
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: Users.length,
          //     itemBuilder: ((context, index) {
          //       return InformationCard(
          //         path: Users[index].path,
          //         stars: Users[index].stars,
          //         text: Users[index].name,
          //       );
          //     }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
