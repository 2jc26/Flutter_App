import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giusseppe_flut/presenter/user_presenter.dart';
import 'package:giusseppe_flut/screens/views_abs.dart';
import '../models/user/user_model_update.dart';
import '../services/firestore_service.dart.dart';
import '../widgets/drawer.dart';
import '../repository/user_repository_prueba.dart';


class BackTest extends StatefulWidget {
  
  BackTest({super.key, required this.title});
  final String title;

  @override
  State<BackTest> createState() => _BackTestState();
}

class _BackTestState extends State<BackTest> implements UserListView{
  final UserListPresenter userListPresenter = UserListPresenter();
  Map<String, dynamic>? appartments;
  List<UserModelUpdate>? _usersList;

  @override
  void refreshUserListView(List<UserModelUpdate> usersList) {
    setState(() {
      _usersList = usersList;
    });
  }

  @override
  void initState() {
    super.initState();
    userListPresenter.backView = this;

  }

  @override
  Widget build(BuildContext context) {

    if (_usersList!.isNotEmpty) {
      return Text(_usersList?[0].name ?? 'Nombre no disponible');
    }
    return Text('Nombre no disponible');
  }

}