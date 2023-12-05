import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:giusseppe_flut/screens/filter_users/filter_users_location.dart';
import 'package:giusseppe_flut/screens/base_mvp/views_abs.dart';
import 'package:giusseppe_flut/storage/storage_adapters/Objectbox/ObjectBox.dart';
import 'package:giusseppe_flut/widgets/info_card.dart';
import '../models/user/query_likes_user.dart';
import '../models/user/user_model.dart';
import '../presenter/user_presenter.dart';
import '../service/connectivity_manager_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/drawer.dart';
import 'InformationCardUser.dart';

class UserList extends StatefulWidget {
  UserPreferencesDTO? userPreferences;
  UserList({Key? key, this.userPreferences}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> implements UserListView {
  final UserListPresenter userListPresenter = UserListPresenter();
  List<UserModel> _userList = [];
  double average = 0.0;
  int _numberPage = 0;
  bool actual = false;
  InformationCardUser Function(BuildContext, int) _itemBuilder(
      List<UserModel> users) {
    return (BuildContext context, int index) => InformationCardUser(
          url: users![index].image,
          stars: users![index].stars,
          text: users![index].full_name,
        );
  }

  late StreamSubscription<bool> connectionSubscription;
  bool connectivity = ConnectivityManagerService().connectivity;

  _UserListState() {
    inicialize();
  }

  Future<void> inicialize() async {
    connectionSubscription =
        ConnectivityManagerService().connectionStatus.listen((isConnected) {
      connectivity = isConnected;
    });
  }

  @override
  void refreshUserListView(List<UserModel> userList, double average) {
    setState(() {
      _userList = userList;
      this.average = average;
    });
  }

  @override
  void refreshNumber(int number) {
    setState(() {
      _numberPage = number;
    });
  }

  @override
  void acutalized(bool value) {
    setState(() {
      actual = value;
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
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(index: 1),
      // drawer: CustomDrawer(customDrawerContext: context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Filtro',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 4.0,
                bottom: 15.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilterUsersLocations()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
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
          average != 0.0
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: Card(
                    color: Color(0xFFdae3e5),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const Text(
                            'Average stars of users:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${double.parse((average).toStringAsFixed(2))}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
                )
              : Container(),
          WidgetConditions(
              userListPresenter: userListPresenter,
              connectivity: connectivity,
              users: _userList),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: SizedBox(
                width: screenSize.width,
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _numberPage,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (actual == false) {
                          actual = true;
                          userListPresenter.setUserPreferences(skip: index * 5, limit: 5);
                        }
                      },
                      child: Container(
                        width: 50,
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          ),
        ],
      ),
    );
  }
}

class WidgetConditions extends StatefulWidget {
  final List<UserModel> users;
  final UserListPresenter userListPresenter;
  final bool connectivity;
  const WidgetConditions(
      {super.key,
      required this.users,
      required this.userListPresenter,
      required this.connectivity});

  @override
  _WidgetConditionsState createState() => _WidgetConditionsState();
}

class _WidgetConditionsState extends State<WidgetConditions> {
  @override
  Widget build(BuildContext context) {
    if (widget.users!.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemCount: widget.users?.length,
          itemBuilder: ((context, index) {
            return InfoCard(
              name: widget.users![index].full_name,
              rating: widget.users![index].stars,
              address: widget.users![index].city,
              imageUrl: widget.users![index].image,
              imageHeight: 300,
              imageWidth: 300,
              padding: 50,
            );
          }),
        ),
      );
    } else if (widget.users!.isEmpty && !widget.connectivity) {
      return const Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          "There is no internet connection",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      );
    } else if (widget.users!.isEmpty && widget.connectivity) {
      return Expanded(
        child: ListView.builder(
          itemCount: widget.users?.length,
          itemBuilder: ((context, index) {
            return InformationCardUser(
              url: widget.users![index].image,
              stars: widget.users![index].stars,
              text: widget.users![index].full_name,
            );
          }),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          "Something went Wrong",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      );
    }
    // TODO: Implementa la lógica de tu widget personalizado aquí
    return Container(
      // Coloca aquí los widgets que deseas mostrar en tu widget personalizado
      child: Text('Ejemplo de WidgetConditions'),
    );
  }
}

class NoUsersSearch extends StatelessWidget {
  const NoUsersSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          'Senehouse',
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
      drawer: CustomDrawer(customDrawerContext: context),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          "There are no users matching your search",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
