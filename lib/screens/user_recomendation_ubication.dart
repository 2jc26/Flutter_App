import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:giusseppe_flut/screens/views_abs.dart';

import '../models/user/user_model_update.dart';
import '../presenter/user_presenter_location.dart';
import '../widgets/information_card.dart';

class LocationPermissionView extends StatefulWidget {
  @override
  _LocationPermissionViewState createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView> implements UserListView{
  double? latitude ;
  double? longitude ;
  List<UserModelUpdate>? _userList=[];
  UserListPresenterLocation userListPresenter = UserListPresenterLocation();

  @override
  void initState() {
    super.initState();
    userListPresenter.backView = this;
    _getLocation();
  }

  _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    /*serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Mostrar un diálogo o mensaje indicando que los servicios de ubicación están desactivados.
      return;
    }*/

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Mostrar un diálogo o mensaje indicando que los permisos de ubicación están denegados.
        return;
      }
    }

    /*if (permission == LocationPermission.deniedForever) {
      // Mostrar un diálogo o mensaje indicando que los permisos de ubicación están denegados permanentemente.
      return;
    }*/

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
    userListPresenter.getNearUsers(latitude! ,longitude!);
  }
  @override
  void refreshUserListView(List<UserModelUpdate> userList) {
    setState(() {
      _userList = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubicación y Coordenadas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Latitud: $latitude'),
            Text('Longitud: $longitude'),
            SizedBox(height: 20),
            //ElevatedButton(
            //  onPressed: ,
            //  child: Text('Obtener Ubicación'),
            //),
            Expanded(
              child: ListView.builder(
                itemCount: _userList?.length,
                itemBuilder: ((context, index) {
                  return InformationCard(
                    path: 'assets/images/house1.jpg',
                    stars: _userList![index].stars,
                    text: _userList![index].name,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}