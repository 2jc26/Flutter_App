import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:giusseppe_flut/screens/appartment_advance_search.dart";
import "package:giusseppe_flut/screens/roomie_detail.dart";
import "package:giusseppe_flut/widgets/drawer.dart";
import "package:giusseppe_flut/widgets/search_field.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";


class AppartmentFilter extends StatefulWidget {
  const AppartmentFilter({super.key});

  final String title = 'Senehouse';


  @override
  State<AppartmentFilter> createState() => _AppartmentFilterState();
}

class _AppartmentFilterState extends State<AppartmentFilter> {
  double ratingVal = 0;
  TextEditingController objectivePriceController = TextEditingController();
  TextEditingController directionController = TextEditingController();
  TextEditingController distanceController = TextEditingController();

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
              child: const Column(
                children: [
                  Text(
                    "Search your new Home",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2E5EAA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SearchField(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Objective Price",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2E5EAA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    _inputField("\$ 500.000 to \$ 5.000.000", objectivePriceController, isNumber: true),
                    const SizedBox(height: 5.0),
                    const Text (
                      "Enter your location",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2E5EAA),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    _inputField("Enter the temptative adress", directionController),
                    const SizedBox(height: 5.0),
                    const SizedBox(
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
                    const SizedBox(height: 5.0),
                    const Text(
                      "Maximum radius in meters from your selected location",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2E5EAA),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _inputField("Enter distance", distanceController, isNumber: true),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF2E5EAA), // Border color
                            width: 2.0, // Border width
                          ),
                          borderRadius:
                              BorderRadius.circular(8.0), // Border radius
                        ),
                        child: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                                "Rating Score",
                                style: TextStyle(
                                  color: Color(0xFF2E5EAA),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            RatingBar.builder(
                              minRating: 1,
                              itemSize: 30,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Color(0xFFEDF9B9),
                              ),
                              unratedColor: const Color(0xFF2E5EAA),
                              onRatingUpdate: (rating) => setState(() {
                                ratingVal = rating;
                              }),
                            ),
                          ],
                        )
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppartmentAdvanceSearch(
                                direction: directionController.text,
                                obPrice: objectivePriceController.text,
                                distance: distanceController.text,
                                ratingVal: ratingVal,
                              ),
                            ),
                          );
                        },
                        child: const Column(
                          children: [
                            Text(
                              "Advance Search",
                              style: TextStyle(
                                color: Color(0xFF2E5EAA),
                              ),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Color(0xFF2E5EAA),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      {isNumber = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
    );
    if (isNumber) {
      return TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: const TextStyle(color: Color(0XFF2C595B)),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF2C595B)),
          enabledBorder: border,
          focusedBorder: border,
          filled: true,
          fillColor: Colors.white,
        )
      );
    } else {
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
      );
    }
  }

  Widget _searchButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoommateDetail()),
        );
        debugPrint("Objective Price: ${objectivePriceController.text}");
        debugPrint("Direction: ${directionController.text}");
        debugPrint("Distance: ${distanceController.text}");
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
