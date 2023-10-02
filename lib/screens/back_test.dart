import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/user/user_model_update.dart';
import '../services/firestore_service.dart.dart';
import '../widgets/drawer.dart';
import '../repository/user_repository.dart';


class BackTest extends StatefulWidget {

  final FirestoreService firestoreService = FirestoreService();
  BackTest({super.key, required this.title});

  final UserRepository userRepository= UserRepository();
  final String title;

  @override
  State<BackTest> createState() => _BackTestState();
}

class _BackTestState extends State<BackTest> {
  Map<String, dynamic>? appartments;
  List<UserModelUpdate>? usersList;
  void _getAllUsers() async {
    try {
      final users = await widget.userRepository.getAllUsers();
      if (users!=null){
        setState(() {
          usersList=users;
        });
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  void initState() {
    _getAllUsers();
  }

  @override
  Widget build(BuildContext context) {

    if (usersList != null) {
      return Text(usersList?[0].name ?? 'Nombre no disponible');
    }
    return Text('dasda');
  }
}