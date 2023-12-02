import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Importa geocoding para convertir direcciones en coordenadas

import "package:giusseppe_flut/widgets/drawer.dart";
import '../../models/user/query_filter_user.dart';
import '../../models/user/query_likes_user.dart';
import 'filter_users_other.dart';
import 'package:csc_picker/csc_picker.dart';

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
      // drawer: CustomDrawer(customDrawerContext: context),
      body: SingleChildScrollView( child:BodyLocation(
        cityController: cityController,
        neighborhoodController: neighborhoodController,
        markerLocation: markerLocation,
        updateMarkerLocation: (LatLng location) {
          setState(() {
            markerLocation = location;
          });
        },
      ),
    )
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
class BodyLocation extends StatefulWidget {
  FilterUsersOthers filterUsersOthers;
  RestorableTextEditingController cityController;
  RestorableTextEditingController neighborhoodController;
  LatLng markerLocation;
  Function(LatLng) updateMarkerLocation;

  BodyLocation({
    Key? key,
    required this.cityController,
    required this.neighborhoodController,
    required this.markerLocation,
    required this.updateMarkerLocation,
    FilterUsersOthers? filterUsersOthers,
  }) :
        filterUsersOthers = filterUsersOthers ?? FilterUsersOthers(),
        super(key: key);

  @override
  State<BodyLocation> createState() => _BodyLocation();
}

class _BodyLocation extends State<BodyLocation> {
  String localidadValue = "Seleccione una opción";
  String ciudadValue = "Bogotá";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //const SizedBox(height: 16),
        //Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          //children: [
            //RoundedButton(text: 'Location', onPressed: () {}),
            //const SizedBox(width: 10),
            //RoundedButton(text: 'Information', onPressed: () {}),
          //],
        //),
        const SizedBox(height: 20),
        CustomListField(
          hintText: 'Bogotá',
          selectedValue: ciudadValue,
          items: ['Bogotá'],
          onItemSelected: (String? value) {
            setState(() =>ciudadValue =value!);
          },
        ),
        const SizedBox(height: 20),
        CustomListField(
          hintText: 'Selecciona una opción',
          selectedValue: localidadValue,
          items: const ["Seleccione una opción","Usaquén", "Chapinero", "Santa Fe", "San Cristóbal", "Usme",
            "Tunjuelito", "Bosa", "Kennedy", "Fontibón", "Engativá", "Suba",
            "Barrios Unidos", "Teusaquillo", "Los Mártires", "Antonio Nariño",
            "Puente Aranda", "La Candelaria", "Rafael Uribe Uribe",
            "Ciudad Bolívar", "Sumapaz"],
          onItemSelected: (String? value) async {
            setState(() =>localidadValue =value!);
            if (localidadValue!="Seleccione una opción" && ciudadValue!="Seleccione una opción"){
              String query= "$localidadValue , $ciudadValue";
              final locations = await GeocodingPlatform.instance.locationFromAddress(query);
              if (locations.isNotEmpty) {
                final newLocation = LatLng(locations[0].latitude, locations[0].longitude);
                widget.updateMarkerLocation(newLocation);
              }
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
                target: widget.markerLocation,
                zoom: 11,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('selectedLocation'),
                  position: widget.markerLocation,
                ),
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            UserFilter().setCity(ciudadValue);
            UserFilter().setNeighborhood(localidadValue);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.filterUsersOthers,
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
class SelectionList extends StatefulWidget {
  final String hintText;
  String selectedValue; // Removed 'final'
  final List<String> items;
  final Function(String?) onItemSelected;

  SelectionList({
    Key? key,
    required this.hintText,
    required this.selectedValue,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  State<SelectionList> createState() => _SelectionList();
}

class _SelectionList extends State<SelectionList> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: DropdownButton<String>(
        value: widget.selectedValue,
        items: widget.items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: widget.onItemSelected,
        hint: Text(widget.hintText),
        isExpanded: true,
      ),
    );
  }
}


class CustomListField extends StatelessWidget {
  final String hintText;
  final String selectedValue;
  final List<String> items;
  final Function(String?) onItemSelected;

  const CustomListField({
    Key? key,
    required this.hintText,
    required this.selectedValue,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: DropdownButton<String>(
        value: selectedValue,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onItemSelected,
        hint: Text(hintText),
        isExpanded: true,
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




