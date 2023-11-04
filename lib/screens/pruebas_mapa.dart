import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb; // Importa esta línea para manejar el entorno web.
import "../widgets/drawer.dart";
import '../storage/storage_adapters/custom_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

final storageRef = FirebaseStorage.instance.ref();

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng initialLocation = const LatLng(37.422131, -122.084801);
  String imageName = '0.jpg';
  final custom=CustomCacheManager().getCacheManager();
  Future<Uint8List?> getImage(String imageName) async {
    final ref = storageRef.child('images_profile/Female/$imageName');
    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await ref.getData(oneMegabyte);
      return data;
    } on FirebaseException catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          "Search Roommate",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          //const SizedBox(
            //height: 300,
            //width: 300,
            //child: GoogleMap(
              //mapType: MapType.hybrid,
              //initialCameraPosition: CameraPosition(
               // target: LatLng(37.422131, -122.084801), // Cambia esto a las coordenadas deseadas
               // zoom: 3,
              //),
            //),
          //),
          CachedNetworkImage(
          imageUrl: 'https://cloudinary-marketing-res.cloudinary.com/images/w_1000,c_scale/v1679921049/Image_URL_header/Image_URL_header-png?_i=AA',
          cacheManager: custom,

          ),
          /*FutureBuilder<Uint8List?>(
            future: getImage(imageName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Image.memory(
                    snapshot.data!, // Datos de la imagen
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  );
                }
              } else {
                return CircularProgressIndicator(); // Muestra un indicador de carga mientras se descarga la imagen.
              }
            },
          ),*/
        ],
      ),
    );
  }
}
