import "package:flutter/material.dart";
import "package:giusseppe_flut/screens/advance_search.dart";
import "package:giusseppe_flut/screens/roomie_detail.dart";
import "package:giusseppe_flut/widgets/drawer.dart";
import "package:giusseppe_flut/widgets/search_field.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class AdvanceSearch extends StatefulWidget {
  const AdvanceSearch({super.key});

  final String title = 'Senehouse';

  @override
  State<AdvanceSearch> createState() => _AdvanceSearchState();
}

enum PropertyType { apartment, house }

class _AdvanceSearchState extends State<AdvanceSearch> {
  double ratingVal = 0;
  PropertyType? selectedPropertyType;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController ocupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDAE3E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _inputField("City/municipality", nameController),
                  const SizedBox(height: 20),
                  _inputField("Neighborhood", passwordController),
                  const SizedBox(height: 20),
                  _inputField("Address", emailController),
                  const SizedBox(height: 20),
                  ListTile(
                    title: const Text('Apartment'),
                    leading: RadioListTile<PropertyType>(
                      value: PropertyType.apartment,
                      groupValue: selectedPropertyType,
                      onChanged: (value) {
                        setState(() {
                          selectedPropertyType = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('House'),
                    leading: RadioListTile<PropertyType>(
                      value: PropertyType.house,
                      groupValue: selectedPropertyType,
                      onChanged: (PropertyType? value) {
                        setState(() {
                          selectedPropertyType = value;
                        });
                      },
                    ),
                  ),
                  _inputField("Rent price", ageController),
                  const SizedBox(height: 20),
                  _inputField("Stratum", ocupationController),
                  const SizedBox(height: 20),
                  _inputField("Area", passwordController),
                  const SizedBox(height: 20),
                  _inputField("Rooms number", passwordController),
                  const SizedBox(height: 20),
                  _inputField("Room area", passwordController),
                  const SizedBox(height: 20),
                  _inputField("Bathrooms number", passwordController),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _searchButton(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
    );
    return TextField(
      style: const TextStyle(color: Color(0XFF2C595B)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF2C595B)),
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: isPassword,
    );
  }

  Widget _searchButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RoommateDetail()),
        );
        debugPrint("Name: ${nameController.text}");
        debugPrint("Password: ${passwordController.text}");
        debugPrint("Lastname: ${lastnameController.text}");
        debugPrint("E-mail: ${emailController.text}");
        debugPrint("Age: ${ageController.text}");
        debugPrint("Ocupation: ${ocupationController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color(0xFF2E5EAA),
        foregroundColor: const Color(0xFFF2F4F6),
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Search",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
