import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/pruebas_mapa.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/house/house_model_update.dart';
import '../presenter/house_detail_presenter.dart';
import '../widgets/rating_rectangle.dart';
import '../widgets/drawer.dart';

class HouseDetailView {
  void refreshHouseDetailView(HouseModelUpdate houseDetail) {}
}


class HouseDetail extends StatefulWidget {
  HouseDetail({super.key});

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}


class _HouseDetailState extends State<HouseDetail> implements HouseDetailView {
  final HouseDetailPresenter houseDetailPresenter = HouseDetailPresenter();
  HouseModelUpdate? _house;

    @override
  void refreshHouseDetailView(HouseModelUpdate house) {
    setState(() {
      _house = house;
    });
  }

  @override
  void initState() {
    super.initState();
    houseDetailPresenter.backView = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          'House Detail',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text at the top
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Top Text',
              style: TextStyle(
                fontSize: 20, // Adjust font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Square Big Image
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                    width: 6.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.asset(
                    width: double.infinity,
                    'assets/images/house1.jpg', // Replace with your image asset path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          ),
          SizedBox(height: 5), // Add spacing between the image and the scrollable images
          // Horizontal Scrollable Row of Images with padding
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20), // Padding inside the scroll
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // First Image (larger)
                  Container(
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        'assets/images/house1.jpg', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Add spacing between images
                  // Smaller Images
                  Container(
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        'assets/images/house1.jpg', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Add spacing between images
                  // Smaller Images
                  Container(
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        'assets/images/house1.jpg', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), // Add spacing between images
                  SizedBox(width: 20), // Add spacing between images
                  // Smaller Images
                  Container(
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        'assets/images/house1.jpg', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Add spacing between images
                  // Smaller Images
                  Container(
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        'assets/images/house1.jpg', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Add spacing between images
                  // Smaller Images
                  Container(
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        'assets/images/house1.jpg', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20), // Add spacing between images
                  // Smaller Images
                  Container(
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary, // Color of the border
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0), // Radius of the border corners
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        'assets/images/house1.jpg', // Replace with your image asset path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Add more smaller images as needed
                ],
              ),
            ),
          ),
          // Details text
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              'Details',
              style: TextStyle(
                fontSize: 18, // Adjust font size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Expansions
          Flexible(
            flex: 1,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                if ( index == 0) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: ExpansionTile(
                      title: Text('Location',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary, // Set the text color here
                        ),
                      ),
                      children: <Widget>[
                        Container(
                            width: 250,
                            height: 250,
                            child: GoogleMap(mapType: MapType.hybrid,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(37.422131, -122.084801), // Cambia esto a las coordenadas deseadas
                                  zoom: 3,))
                        )
                      ],
                    ),
                  );
                } else if ( index == 1) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: ExpansionTile(
                      title: Text('Included Amenities',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary, // Set the text color here
                        ),
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          child: Table(
                            border: TableBorder.all(
                              color: Theme.of(context).colorScheme.tertiary,
                            ), // Add borders to the table cells
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Center(child: Text('Amenity 1',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary, // Set the text color here
                                      ),
                                    ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(child: Text('Amenity 1',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary, // Set the text color here
                                      ),
                                    ),),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Center(child: Text('Amenity 2',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary, // Set the text color here
                                      ),
                                    ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(child: Text('Amenity 2',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary, // Set the text color here
                                      ),
                                    ),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if ( index == 2) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: ExpansionTile(
                      title: Text('Renter',
                      style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, // Set the text color here
                ),
                ),
                      expandedAlignment: Alignment.topLeft,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          child: Row(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 100.0,
                                  height: 100.0, // Set both width and height to make it a square
                                  child: Image.asset(
                                    'assets/images/house1.jpg', // Replace with your image asset
                                    fit: BoxFit.cover, // Ensure the image covers the square area
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.0), // Add spacing between the image and text
                              Expanded(
                                child: Text('Additional Text fdhsajfhaksjhfksahfkshafkjhaskfhkasjhfkjsahfkjhaskfhkajsf',
                                  style: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary, // Set the text color here
                                      fontSize: 16.0
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if ( index == 3) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: ExpansionTile(
                      title: Text('Contract Terms',
                      style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, // Set the text color here
                ),
                ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                          child: Text('Additional Text fdhsajfhaksjhfksahfkshafkjhaskfhkasjhfkjsahfkjhaskfhkajsf',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary, // Set the text color here
                              fontSize: 16.0
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else if ( index == 4) {
                  return Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: ExpansionTile(
                      title: Text('Ratings',
                      style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, // Set the text color here
                ),
                ),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RatingRectangle(
                              imageUrl: 'assets/images/house1.jpg', // Replace with your image asset
                              rating: 4.5, // Replace with your rating
                            ),
                            RatingRectangle(
                              imageUrl: 'assets/images/house1.jpg', // Replace with your image asset
                              rating: 3.0, // Replace with your rating
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }
            ),
          ),
        ],
      ),
      // Botón Abajo
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0, // Set the desired height for your button
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300.0,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button tap here
                  },
                  child: Text("I'm Interested",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.background, // Set the text color here
                        fontSize: 16.0
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary, // Set the button color here
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}