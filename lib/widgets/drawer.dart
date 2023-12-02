import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Importar Flutter Bloc
import 'package:giusseppe_flut/auth/auth_cubit.dart';
import 'package:giusseppe_flut/screens/house_list.dart';
import 'package:giusseppe_flut/screens/profile.dart';
import 'package:giusseppe_flut/screens/user_list.dart';
import 'package:giusseppe_flut/screens/user_recomendation_ubication.dart';
import 'package:giusseppe_flut/storage/providers/nickname_provider.dart';

class CustomDrawer extends StatelessWidget {
  final BuildContext customDrawerContext;

  final NicknameProvider nicknameProvider = NicknameProvider();

  String nickname = '';

  CustomDrawer({required this.customDrawerContext, Key? key}) : super(key: key);

  getNickName() async {
    nickname = await nicknameProvider.getNickname() ?? '';
  }
  
  @override
  Widget build(BuildContext context) {
    getNickName();
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
                  Text(nickname),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Profile"),
            onTap: () {
              Navigator.push(
                customDrawerContext,
                MaterialPageRoute(builder: (customDrawerContext) => profile()),
              );
            },
          ),
          ListTile(
            title: const Text("Publish"),
            onTap: () {
              // Puedes acceder al contexto personalizado customDrawerContext aquí
            },
          ),
          ListTile(
            title: const Text("Houses"),
            onTap: () {
              Navigator.push(
                customDrawerContext, // Usar el contexto personalizado
                MaterialPageRoute(builder: (customDrawerContext) => const HouseList(userId: '', houseFilters: null)),
              );
            },
          ),
          ListTile(
            title: const Text("Users"),
            onTap: () {
              Navigator.push(
                customDrawerContext, // Usar el contexto personalizado
                MaterialPageRoute(builder: (customDrawerContext) => UserList()),
              );
            },
          ),
          ListTile(
            title: Text("Discover Near"),
            onTap: () {
              Navigator.push(
                customDrawerContext, // Usar el contexto personalizado
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
          ListTile(
            title: Text("Log Out"),
            onTap: () {
              // Agregar lógica para cerrar sesión aquí
              customDrawerContext.read<AuthCubit>().logOut();
            },
          ),
          // Puedes agregar más elementos del Drawer aquí
        ],
      ),
    );
  }
}
