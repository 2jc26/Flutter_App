// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:giusseppe_flut/app_navigator.dart';

// import 'package:giusseppe_flut/auth/auth_repository.dart';
// import 'package:giusseppe_flut/service/connectivity_manager_service.dart';

// // Firebase
// import 'package:firebase_core/firebase_core.dart';
// import 'package:giusseppe_flut/session_cubit.dart';
// import 'package:giusseppe_flut/storage/storage_adapters/Objectbox/ObjectBox.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   var objectbox = await ObjectBoxDao.initialize();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   // Set the preferred orientation to portrait
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   ConnectivityManagerService().initialize();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       restorationScopeId: "root",
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: const ColorScheme(
//           primary: Color(0xFF2e5eaa),
//           secondary: Colors.white,
//           surface: Color(0xFFdae3e5),
//           background: Color(0xFFdae3e5),
//           error: Color(0xFFB00020),
//           onPrimary: Color(0xFF2c595b),
//           onSecondary: Color(0xFF2c595b),
//           onSurface: Color(0xFF2c595b),
//           onBackground: Color(0xFF2c595b),
//           onError: Colors.red,
//           brightness: Brightness.light,
//           tertiary: Color(0xFFEDF9B9)
//         ),
//       ),

//       home: RepositoryProvider(
//         create: (context) => AuthRepository(),
//         child:
//         BlocProvider(
//           create: (context) => SessionCubit(authRepo: context.read<AuthRepository>()),
//           child: AppNavigator(),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class ReviewCard {
  final String name;
  final int rating;
  final String comment;

  ReviewCard({required this.name, required this.rating, required this.comment});
}

class ReviewsList extends StatelessWidget {
  final List<ReviewCard> reviews;

  ReviewsList({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            title: Text(reviews[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Calificación: ${reviews[index].rating}'),
                Text('Comentario: ${reviews[index].comment}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ReviewsList(
        reviews: [
          ReviewCard(
            name: 'Cliente 1',
            rating: 5,
            comment: '¡Muy buen servicio!',
          ),
          ReviewCard(
            name: 'Cliente 2',
            rating: 4,
            comment: 'Buena experiencia en general.',
          ),
          // Agrega más reseñas según sea necesario
        ],
      ),
    ),
  ));
}
