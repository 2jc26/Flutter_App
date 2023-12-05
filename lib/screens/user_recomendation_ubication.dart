import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/user/user_model.dart';
import '../presenter/user_presenter_location.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_app_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/information_card.dart';
import 'base_mvp/base_mvp_location.dart';

class LocationPermissionView extends StatefulWidget {
  @override
  _LocationPermissionViewState createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView> implements UserListViewLocation {
  double? latitude;
  double? longitude;
  List<UserModel> _userList = [];
  UserListPresenterLocation userListPresenter = UserListPresenterLocation();
  late bool serviceEnabled = true;
  late Position _currentPosition;
  String currectAddress ="";

  @override
  void initState() {
    super.initState();
    userListPresenter.backView = this;
    _getLocation();
  }
  _getLocation() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    var status = await Permission.location.status;

    if(status.isGranted){
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      setState(() {
        serviceEnabled = true;
      });
      userListPresenter.getNearUsers(latitude!, longitude!);
    }else if (status.isDenied){
      LocationPermission permission = await Geolocator.requestPermission();
      if(status.isGranted){
        setState(() {
          serviceEnabled = true;
        });
      }else{
        setState(() {
          serviceEnabled = false;
        });
      }
    } else if (await Permission.location.isPermanentlyDenied){
      LocationPermission permission = await Geolocator.requestPermission();
      if(status.isGranted){
        setState(() {
          serviceEnabled = true;
        });
      }else{
        setState(() {
          serviceEnabled = false;
        });
      }
      openAppSettings();
    }
    /*permission = await Geolocator.checkPermission();
*/

    /*if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          serviceEnabled = false;
        });
      } else  {
        setState(() {
          serviceEnabled = true;
        });
      }
    }
    else {
      serviceEnabled = true;
    }*/

  }

  @override
  void refreshUserListView(List<UserModel> userList) {
    setState(() {
      _userList = userList;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!serviceEnabled) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Por favor, acepta los permisos para utilizar la funcionalidad.'),
          ),
        );
      });
    }

    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(index: 2),
      // drawer: CustomDrawer(customDrawerContext: context),
      body: serviceEnabled
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Latitud: $latitude'),
            Text('Longitud: $longitude'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _userList.length,
                itemBuilder: ((context, index) {
                  return InformationCard(
                    path: 'assets/images/house1.jpg',
                    stars: _userList[index].stars,
                    text: _userList[index].full_name,
                  );
                }),
              ),
            ),
          ],
        ),
      )
          : Center(
        child: Text(
          'Necesitas permitir la ubicación para utilizar esta funcionalidad.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}