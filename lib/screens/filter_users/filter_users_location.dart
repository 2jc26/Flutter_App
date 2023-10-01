import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:giusseppe_flut/widgets/drawer.dart";

class FilterUsersLocations extends StatelessWidget {
  const FilterUsersLocations({super.key});

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
      body: const BodyLocation(),
    );
  }
}
class BodyLocation extends StatelessWidget {
  const BodyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(text: 'Location', onPressed: () {  },),
            const SizedBox(width: 10),
            RoundedButton(text: 'Information', onPressed: () {  },),
          ],
        ),
        const SizedBox(height: 16),
        const CustomTextField(hintText: 'City/Municipality',),
        const SizedBox(height: 20),
        const CustomTextField(hintText: 'Neighborhood',),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0), // Ajusta el radio según tu preferencia
          child: const SizedBox(
            height: 400,
            width: 350,
            child: GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: LatLng(4.6097, -74.0817),
                zoom: 11,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {

          },
          child: Text('Continuar'),
        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
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





