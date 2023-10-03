import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Importa geocoding para convertir direcciones en coordenadas

import "package:giusseppe_flut/widgets/drawer.dart";
import '../../models/user/query_likes_user.dart';
import '../back_test.dart';
import 'filter_users_other.dart';

class FilterUsersLocations extends StatefulWidget {

  FilterUsersLocations({super.key});

  @override
  _FilterUsersLocationsState createState() => _FilterUsersLocationsState();

}

class _FilterUsersLocationsState extends State<FilterUsersLocations> with RestorationMixin{


  RestorableTextEditingController cityController = RestorableTextEditingController();
  RestorableTextEditingController neighborhoodController = RestorableTextEditingController();
  LatLng markerLocation = LatLng(4.6097, -74.0817);


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
      body: BodyLocation(
        cityController: cityController,
        neighborhoodController: neighborhoodController,
        markerLocation: markerLocation,
        updateMarkerLocation: (LatLng location) {
          setState(() {
            markerLocation = location;
          });
        },
      ),
    );
  }

  @override
  String? get restorationId => "filter_users_location";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(cityController, "city");
    registerForRestoration(neighborhoodController, "neighborhood");
  }
}

class BodyLocation extends StatelessWidget {
  final UserPreferencesDTO userPrefs = UserPreferencesDTO();
  final FilterUsersOthers filterUsersOthers;
  final RestorableTextEditingController cityController;
  final RestorableTextEditingController neighborhoodController;
  final LatLng markerLocation;
  final Function(LatLng) updateMarkerLocation;

  BodyLocation({
    super.key,
    required this.cityController,
    required this.neighborhoodController,
    required this.markerLocation,
    required this.updateMarkerLocation,
    FilterUsersOthers? filterUsersOthers,
  }) : filterUsersOthers = filterUsersOthers ?? FilterUsersOthers(userPreferences: UserPreferencesDTO());

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedButton(text: 'Location', onPressed: () {}),
              const SizedBox(width: 10),
              RoundedButton(text: 'Information', onPressed: () {}),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hintText: 'City/Municipality',
            controller: cityController.value,
            onTextChanged: (text) async {
              final locations = await GeocodingPlatform.instance.locationFromAddress(text);
              if (locations.isNotEmpty) {
                final newLocation = LatLng(locations[0].latitude, locations[0].longitude);
                updateMarkerLocation(newLocation);
              }
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: 'Neighborhood',
            controller: neighborhoodController.value,
            onTextChanged: (text) async {
              final locations = await GeocodingPlatform.instance.locationFromAddress(text);
              if (locations.isNotEmpty) {
                final newLocation = LatLng(locations[0].latitude, locations[0].longitude);
                updateMarkerLocation(newLocation);
              }
            },
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: SizedBox(
              height: 400,
              width: 350,
              child: GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: markerLocation,
                  zoom: 11,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('selectedLocation'),
                    position: markerLocation,
                  ),
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String city=cityController.value.text ;
              String neighborhood = neighborhoodController.value.text;
              if (city!=''){
                userPrefs.city=city;
              }
              if (neighborhood!=''){
                userPrefs.neighborhood=neighborhood;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => filterUsersOthers,
                ),
              );
            },
            child: Text('Continuar'),
          ),
        ],
      );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String) onTextChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: controller,
        onChanged: onTextChanged,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  RoundedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF2c595b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }
}




