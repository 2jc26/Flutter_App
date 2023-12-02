import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/house_list.dart';
import 'package:giusseppe_flut/screens/user_list.dart';
import 'package:giusseppe_flut/screens/user_recomendation_ubication.dart';

class BottomNavBar extends StatefulWidget {
  final int index;

  const BottomNavBar({super.key, required this.index});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    setState(() {
      _currentIndex = widget.index;
    });
    super.initState();
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
        // Navigator.push(
        //   context, // Usar el contexto personalizado
        //   MaterialPageRoute(builder: (context) => const Home()),
        // );
        break;
      case 1:
        Navigator.push(
          context, // Usar el contexto personalizado
          MaterialPageRoute(builder: (context) => UserList()),
        );
        break;
      case 2:
        Navigator.push(
          context, // Usar el contexto personalizado
          MaterialPageRoute(builder: (context) => LocationPermissionView()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HouseList(userId: '', houseFilters: null)),
        );
        break;
      case 4:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (customDrawerContext) => profile()),
        // );
        break;
    }

  }
}