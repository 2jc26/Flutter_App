import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/house_list.dart';
import 'package:giusseppe_flut/screens/user_list.dart';
import 'package:giusseppe_flut/screens/user_recomendation_ubication.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("Paco Martinez"),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Publish"),
            onTap: () {

            },
          ),
          ListTile(
            title: const Text("Houses"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HouseList(userId: '',)),
              );
            },
          ),
          ListTile(
            title: const Text("Users"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserList()),
              );
            },
          ),
          ListTile(
            title: Text("Discover Near"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationPermissionView()),
              );
            },
          ),
          const ListTile(
            title: Text("Settings"),
            // Agregar más elementos del Drawer según tus necesidades
          ),
          const ListTile(
            title: Text("Help"),
            // Agregar más elementos del Drawer según tus necesidades
          ),
          // Puedes agregar más elementos del Drawer aquí
        ],
      ),
    );
  }
}