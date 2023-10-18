import 'package:flutter/material.dart';
import 'package:giusseppe_flut/screens/house_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/house/house_model_update.dart';
import '../widgets/rating_rectangle.dart';
import '../widgets/drawer.dart';

class HouseDetailView {
  void refreshHouseDetailView(HouseModelUpdate house) {}
}


class HouseDetail extends StatefulWidget {
  HouseDetail({Key? key, required this.house}) : super(key: key);

  final HouseModelUpdate house;
  
  @override
  State<HouseDetail> createState() => _HouseDetailState();
}


class _HouseDetailState extends State<HouseDetail> implements HouseDetailView {
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
    _house = widget.house;
  }

  @override
  Widget build(BuildContext context) {

    Marker newMarker = Marker(
      markerId: const MarkerId('uniqueMarkerId'),
      position: LatLng(_house!.latitude, _house!.longitude),
    );

    if (_house != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E5EAA),
          title: const Text(
            'Senehouse',
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
                _house!.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Square Big Image
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 6.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: Image.asset(
                      width: double.infinity,
                      'assets/images/house1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ),
            const  SizedBox(height: 5),
            // Horizontal Scrollable Row of Images with padding
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SmallImage(),
                    SizedBox(width: 20),
                    SmallImage(),
                    SizedBox(width: 20),
                    SmallImage(),
                    SizedBox(width: 20),
                    SmallImage(),
                    SizedBox(width: 20),
                    SmallImage(),
                    SizedBox(width: 20),
                    SmallImage(),
                    SizedBox(width: 20),
                    SmallImage(),
                  ],
                ),
              ),
            ),
            // Details text
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                itemCount: 3,
                itemBuilder: (context, index) {
                  if ( index == 0) {
                    return DescriptionCard(house: _house);
                  } else if ( index == 1) {
                    return LocationCard(house: _house, newMarker: newMarker);
                  } else if ( index == 2) {
                    return AmenitiesCard(house: _house);
                  }
                }
              ),
            ),
          ],
        ),
        // Botón Abajo
        bottomNavigationBar: Button(),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({
    super.key,
    required HouseModelUpdate? house,
  }) : _house = house;

  final HouseModelUpdate? _house;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ExpansionTile(
        title: Text(
          'Description',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary, // Set the text color here
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: Text(_house!.description,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary, // Set the text color here
                fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AmenitiesCard extends StatelessWidget {
  const AmenitiesCard({
    super.key,
    required HouseModelUpdate? house,
  }) : _house = house;

  final HouseModelUpdate? _house;

  @override
  Widget build(BuildContext context) {
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
            child: FeatureTable(house: _house!,)
          ),
        ],
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required HouseModelUpdate? house,
    required this.newMarker,
  }) : _house = house;

  final HouseModelUpdate? _house;
  final Marker newMarker;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ExpansionTile(
        title: Text('Location',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary, // Set the text color here
          ),
        ),
        children: <Widget>[
          SizedBox(
            width: 250,
            height: 250,
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(_house!.latitude, _house!.longitude), // Cambia esto a las coordenadas deseadas
                zoom: 18,
              ),
              markers: {newMarker},
            )
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 56.0, // Set the desired height for your button
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300.0,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary, // Set the button color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                  ),
                ),
                child: Text("I'm Interested",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background, // Set the text color here
                      fontSize: 16.0
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmallImage extends StatelessWidget {
  const SmallImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class FeatureTable extends StatelessWidget {
  final HouseModelUpdate house;
  
  final List<String> caracs = ["apartmentFloor","housingType","rentPrice","stratum","area","roomsNumber","roomArea","bathroomsNumber","laundryArea","internet","tv","furnished","elevator","gymnasium","reception","supermarkets"];
  final List<String> texts = ["Apartment Floor","housing Type","Rent Price","Stratum","Area","Rooms Number","Room Area","Bathrooms Number","Laundry Area","Internet","TV","Furnished","Elevator","Gymnasium","Reception","Supermarkets"];


  FeatureTable({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];

    Map<String, String> caracValues = {
    "apartmentFloor": house.apartmentFloor.toString(),
    "housingType": house.housingType.toString(),
    "rentPrice": house.rentPrice.toString(),
    "stratum": house.stratum.toString(),
    "area": house.area.toString(),
    "roomsNumber": house.roomsNumber.toString(),
    "roomArea": house.roomArea.toString(),
    "bathroomsNumber": house.bathroomsNumber.toString(),
    "laundryArea": house.laundryArea.toString(),
    "internet": house.internet.toString(),
    "tv": house.tv.toString(),
    "furnished": house.furnished.toString(),
    "elevator": house.elevator.toString(),
    "gymnasium": house.gymnasium.toString(),
    "reception": house.reception.toString(),
    "supermarkets": house.supermarkets.toString(),
  };

  // Iterate through the caracs list and add rows to the tableRows list
  for (int i = 0; i < caracs.length; i++) {
    var caracName = caracs[i];
    var caracValue = caracValues[caracName];
    caracName = texts[i];
    if (caracValue == "true") {
      caracValue = "Yes";
    } else if (caracValue == "false") {
      caracValue = "No";
    }
    tableRows.add(
      TableRow(
        children: [
          TableCell(
            child: Center(
              child: Text(
                caracName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          TableCell(
             child: Center(
               child: Text(
                caracValue!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

    return Table(
      border: TableBorder.all(
        color: Theme.of(context).colorScheme.tertiary,
      ),
      children: tableRows,
    );
  }
}