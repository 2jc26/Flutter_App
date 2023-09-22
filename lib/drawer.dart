import 'package:flutter/material.dart';


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
          const ListTile(
            title: Text("Discover"),
            // Agregar más elementos del Drawer según tus necesidades
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