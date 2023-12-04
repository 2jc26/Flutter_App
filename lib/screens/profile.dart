
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/user/user_model.dart';
import '../repository/user_repository.dart';
import '../service/connectivity_manager_service.dart';
import '../storage/providers/id_provider.dart';
import '../storage/providers/nickname_provider.dart';
import '../storage/providers/password_provider.dart';
import '../storage/storage_adapters/custom_cache_manager.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/custom_app_bar.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final custom = CustomCacheManager().getCacheManager();
  late StreamSubscription<bool> connectionSubscription;
  final UserRepository userRepository = UserRepository();
  UserModel? user;
  @override
  void initState() {
    super.initState();
    doit();
  }

  void doit() async {
    var nuevo = await userRepository.getUserLocalFileLessArgs();
    setState(() {
      user = nuevo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(index: 1),
      // drawer: CustomDrawer(customDrawerContext: context),
      body: Column(
        children: [
          const SizedBox(height: 20),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: user != null
                ? CachedNetworkImage(
              imageUrl: user!.image,
              cacheManager: custom,
              width: 50,
              height: 100,
            )
                : const SizedBox(
              width: 50,
              height: 100,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Spacer(flex: 1,),

              Text(user?.full_name ?? '',style:
              const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,)),
              const Spacer(flex: 1,),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 100),
              const Text("Rol",style:
              TextStyle(fontSize: 17,
                fontWeight: FontWeight.bold,)),
              const Spacer(flex: 1),
              Text(user?.rol ?? '',style:
              const TextStyle(fontSize: 17,
              )),
              const SizedBox(width: 100),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 100),
              const Text("Rating",style:
              TextStyle(fontSize: 17,
                fontWeight: FontWeight.bold,)),
              const Spacer(flex: 1),
              Text(user?.stars.toString() ?? '',style:
              const TextStyle(fontSize: 17,)),
              const SizedBox(width: 100),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Spacer(flex: 3),
              Text("Personal information",style:
              const TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,)),
              Spacer(flex: 10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFF2e5eaa)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Email" ,style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 1),
                          Text(user?.email ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Password",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 1),
                          Text(user?.password ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("City",style:
                          const TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.city ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Locality",style:
                          const TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.locality ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Age",style:
                          const TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.age.toString() ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Gender",style:
                          const TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.gender ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Phone",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.phone.toString() ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Personality",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.personality ?? ''),
                          const SizedBox(width: 50),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Row(
            children: [
              Spacer(flex: 2),
              Text("Preferences",style:
              TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,)),
              Spacer(flex: 10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Color(0xFF2e5eaa)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 50),
                            const Text("Bring people",style:
                            TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold,)),
                            const Spacer(flex: 2),
                            Text(user?.bring_people ?? ''),
                            const SizedBox(width: 50),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Clean the room",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.clean ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Sleep time",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.sleep.toString() ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Likes pets",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.likes_pets.toString() ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Smoke",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.smoke.toString() ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 50),
                          const Text("Vape",style:
                          TextStyle(fontSize: 16,
                            fontWeight: FontWeight.bold,)),
                          const Spacer(flex: 2),
                          Text(user?.vape.toString() ?? ''),
                          const SizedBox(width: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}