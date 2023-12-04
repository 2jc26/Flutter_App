import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/house_list.dart';
import 'package:giusseppe_flut/screens/user_list.dart';
import 'package:giusseppe_flut/screens/user_recomendation_ubication.dart';

import '../enum/feature_enum.dart';
import '../presenter/drawer_presenter.dart';
import '../screens/principal.dart';
import '../screens/profile.dart';
import '../storage/providers/id_provider.dart';
import 'drawer.dart';

class BottomNavBar extends StatefulWidget {
  final int index;


  const BottomNavBar({super.key, required this.index});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> implements CustomDrawerView {
  int _currentIndex = 0;
  final DrawerPresenter drawerPresenter = DrawerPresenter();
  final IdProvider idProvider = IdProvider();
  late String id='';

  @override
  void initState() {
    setState(()  {
      _currentIndex = widget.index;
    });
  }

  Future<String> giveId() async {
    id= await idProvider.getId() ?? '';
    return id;
  }
  @override
  void refreshId(String id) {
    this.id=id;
  }



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: (int index) {
        _onTap(index);
      },
      items: [
        _buildNavItem(Icons.home, 'Home', 0),
        _buildNavItem(Icons.people, 'Roomies', 1),
        _buildNavItem(Icons.public, 'Near', 2),
        _buildNavItem(Icons.vpn_key, 'Houses', 3),
        _buildNavItem(Icons.circle, 'Profile', 4),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {

    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );

  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        giveId().then((userId) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PrincipalView(userId: userId)),
          );
        });
        break;
      case 1:
        drawerPresenter.addUse(Feature.filtroUsuario);
        Navigator.push(
          context, // Usar el contexto personalizado
          MaterialPageRoute(builder: (context) => UserList()),
        );
        break;
      case 2:
        drawerPresenter.addUse(Feature.localizacionUsuario);
        Navigator.push(
          context, // Usar el contexto personalizado
          MaterialPageRoute(builder: (context) => LocationPermissionView()),
        );
        break;
      case 3:
        giveId().then((userId) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HouseList(userId: userId, houseFilters: null)),
          );
        });
        break;
      case 4:
        Navigator.push(
           context,
           MaterialPageRoute(builder: (customDrawerContext) => profile()),
         );
        break;
    }

  }

  @override
  void refreshImage(String image) {
    // TODO: implement refreshImage
  }


}