
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

import "../widgets/drawer.dart";

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
  LatLng initialLocation = const LatLng(37.422131, -122.084801);

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
      body:  const SizedBox(
        height: 300,
        width: 300,// Ajusta el tamaño del mapa según tus necesidades
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(37.422131, -122.084801), // Cambia esto a las coordenadas deseadas
            zoom: 3,
          ),
        ),
      ),
    );
  }
}
