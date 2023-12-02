import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/review/review_model.dart';
import 'package:giusseppe_flut/models/user/user_model.dart';

class PrincipalView_Abs {
  void refreshPrincipalView(
      List<HouseModelUpdate> housesList,
      List<UserModel> userList,
      List<ReviewModel> reviewList) {}
}

class PrincipalView extends StatefulWidget {
  const PrincipalView(
      {super.key, required this.userId});

  final String userId;

  @override
  State<PrincipalView> createState() => _PrincipalViewState();
}

class _PrincipalViewState extends State<PrincipalView> implements PrincipalView_Abs {
  
  late PrincipalPresenter principalPresenter;

  String? _userId;

  List<HouseModelUpdate>? _housesList;
  List<UserModel>? _userList;
  List<ReviewModel>? _reviewList;

  @override
  void refreshPrincipalView(
      List<HouseModelUpdate> housesList,
      List<UserModel> userList,
      List<ReviewModel> reviewList) {
    setState(() {
      _housesList = housesList;
      _userList = userList;
      _reviewList = reviewList;
    });
  }

  @override
  void initState() {
    // TODO: reemplazar por el id del usuario logueado del cache/local storage
    _userId = widget.userId;

    principalPresenter = PrincipalPresenter(widget.userId);

    principalPresenter.backView = this;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Principal'),
      ),
      body: _buildBody(),
    );
  }

}
