import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Importar Flutter Bloc
import 'package:giusseppe_flut/auth/auth_cubit.dart';
import 'package:giusseppe_flut/enum/feature_enum.dart';
import 'package:giusseppe_flut/screens/house_list.dart';
import 'package:giusseppe_flut/screens/profile.dart';
import 'package:giusseppe_flut/screens/user_list.dart';
import 'package:giusseppe_flut/screens/user_recomendation_ubication.dart';
import 'package:giusseppe_flut/storage/providers/nickname_provider.dart';

import '../presenter/drawer_presenter.dart';
import '../storage/storage_adapters/custom_cache_manager.dart';

class CustomDrawer extends StatefulWidget  {
  final BuildContext customDrawerContext;

  final NicknameProvider nicknameProvider = NicknameProvider();

  CustomDrawer({required this.customDrawerContext, Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> implements CustomDrawerView{
  String nickname = '';
  late String image='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRitBzr6MdKC58zMfEr9yP-CwxRhZ2_BKrJgQ';
  final DrawerPresenter drawerPresenter = DrawerPresenter();
  late String id = '';



  @override
  void initState() {
    super.initState();
    getNickName();
    drawerPresenter.backView = this;
    drawerPresenter.setUserPreferences();
  }

  getNickName() async {
    nickname = await widget.nicknameProvider.getNickname() ?? '';
    setState(() {});
  }

  void refreshImage(String image) {
    setState(() {
      this.image = image;
    });
  }

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
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: image,
                      cacheManager: CustomCacheManager().getCacheManager(),
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) {
                        return ColoredBox(
                          color: Colors.black,
                          child: Center(child: CircularProgressIndicator(value: progress.progress)),
                        );
                      },
                      errorWidget: (context, url, error) {
                        if (error is SocketException) {
                          return const Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 48.0,
                                  color: Colors.blue,
                                ),
                                Text(
                                  '¡Vaya! No tienes internet.',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 48.0,
                                  color: Colors.blue,
                                ),
                                Text(
                                  '¡Vaya! Algo salió mal al cargar la imagen',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
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
                  widget.customDrawerContext,
                  MaterialPageRoute(builder: (customDrawerContext) => profile()),
              );
            },
          ),
          ListTile(
            title: const Text("Publish"),
            onTap: () {
              // Puedes acceder al contexto personalizado widget.customDrawerContext aquí
            },
          ),
          ListTile(
            title: const Text("Houses"),
            onTap: () {
              drawerPresenter.addUse(Feature.filtroHabitaciones);
              Navigator.push(
                  widget.customDrawerContext,
                  MaterialPageRoute(builder: (customDrawerContext) => const HouseList(userId: '', houseFilters: null)),
              );
            },
          ),
          ListTile(
            title: const Text("Users"),
            onTap: () {
              drawerPresenter.addUse(Feature.filtroUsuario);
              Navigator.push(
                  widget.customDrawerContext,
                  MaterialPageRoute(builder: (customDrawerContext) => UserList()),
              );
            },
          ),
          ListTile(
            title: Text("Discover Near"),
            onTap: () {
              drawerPresenter.addUse(Feature.localizacionUsuario);
              Navigator.push(
                widget.customDrawerContext,
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
              widget.customDrawerContext.read<AuthCubit>().logOut();
            },
          ),
          // Puedes agregar más elementos del Drawer aquí
        ],
      ),
    );
  }

  @override
  void refreshId(String id) {
    this.id=id;
  }
}

class CustomDrawerView {
  void refreshImage(String image) {}

  void refreshId(String id) {}
}
