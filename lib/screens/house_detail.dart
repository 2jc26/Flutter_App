import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:giusseppe_flut/presenter/house_detail_presenter.dart';
import 'package:giusseppe_flut/screens/review_list.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/widgets/cache_network_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/house/house_model_update.dart';

class HouseDetailView {
  void refreshHouseDetailView(HouseModelUpdate house) {}
}

class HouseDetail extends StatefulWidget {
  const HouseDetail({Key? key, required this.house}) : super(key: key);

  final HouseModelUpdate house;

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> implements HouseDetailView {
  HouseModelUpdate? _house;
  String? _mainImg;
  final HouseDetailPresenter houseDetailPresenter = HouseDetailPresenter();

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
    _mainImg = widget.house.images[0];
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
        // drawer: CustomDrawer(customDrawerContext: context),
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
                child: ChNetworkImage(
                    url: _mainImg!,
                    height: 180,
                    width: double.infinity,
                    cacheheight: 150,
                    cachewidth: 350),
              ),
            ),
            const SizedBox(height: 5),
            // Horizontal Scrollable Row of Images with padding
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Set the width to screen width
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _house!.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          EdgeInsets padding =
                              const EdgeInsets.only(left: 10.0);

                          if (index == _house!.images.length - 1) {
                            padding = padding.copyWith(right: 40.0);
                          }
                          if (index == 0) {
                            padding = padding.copyWith(left: 0);
                          }
                          

                          return Padding(
                            padding: padding,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _mainImg = _house!.images[index];
                                  });
                                },
                                child: SmallImage(url: _house!.images[index],)
                            )
                          );
                        },
                      ),
                    ),
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
              flex: 2,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return DescriptionCard(house: _house);
                    } else if (index == 1) {
                      if (ConnectivityManagerService().connectivity == true) {
                        return LocationCard(
                            house: _house, newMarker: newMarker);
                      } else {
                        return Text(
                          _house!.address,
                          style: const TextStyle(
                            fontSize: 10, // Adjust font size as needed
                            color: Colors.white,
                          ),
                        );
                      }
                    } else {
                      return AmenitiesCard(house: _house);
                    }
                  }),
            ),
            Flexible(
              flex: 1,
              child: Row(
              children: [
                Button(title: 'Reviews', houseId: widget.house.id),
                const Button(title: "I'm Interested"),
              ],
            ),
            ),
          ],
        ),
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

class BigImage extends StatelessWidget {
  const BigImage({super.key, required this.getImageURL});

  final Future<Uint8List?> Function() getImageURL;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: getImageURL(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la imagen.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        } else {
          return Text('No image available'); // Mostrar algo si no hay imagen.
        }
      },
    );
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
      child: Theme(
        // Use Theme widget to set the iconTheme property
        data: ThemeData(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 0, 0), // Change this to your desired color
          ),
        ),
        child: ExpansionTile(
        title: Text(  
          'Description',
          style: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .tertiary, // Set the text color here
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: Text(
              _house!.description,
              style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .secondary, // Set the text color here
                  fontSize: 16.0),
            ),
          )
        ],
      ),
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
      child: Theme(
        // Use Theme widget to set the iconTheme property
        data: ThemeData(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 0, 0), // Change this to your desired color
          ),
        ),
        child: ExpansionTile(
        title: Text(
          'Included Amenities',
          style: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .tertiary, // Set the text color here
          ),
        ),
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: FeatureTable(
                house: _house!,
              )),
        ],
        )
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
    if (ConnectivityManagerService().connectivity == true) {
      return Card(
        color: Theme.of(context).colorScheme.primary,
        child: Theme(
        // Use Theme widget to set the iconTheme property
        data: ThemeData(
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 255, 0, 0), // Change this to your desired color
          ),
        ),
        child: ExpansionTile(
          title: Text(
            'Location',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .tertiary, // Set the text color here
            ),
          ),
          children: <Widget>[
            SizedBox(
                width: 250,
                height: 250,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        _house!.latitude,
                        _house!
                            .longitude), // Cambia esto a las coordenadas deseadas
                    zoom: 14,
                  ),
                  markers: {newMarker},
                )),
          ],
        )
        ),
      );
    } else {
      return Card(
        color: Theme.of(context).colorScheme.primary,
        child: ExpansionTile(
          title: Text(
            'Location',
            style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .tertiary, // Set the text color here
            ),
          ),
          children: <Widget>[
            Text(_house!.address,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary, // Set the text color here
            ),)
          ],
        ),
      );
    }
  }
}

class Button extends StatelessWidget {
  const Button({super.key, required this.title, this.houseId});

  final String title;

  final String? houseId;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: 56.0, // Set the desired height for your button
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 160.0,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (title == "I'm Interested") {
                    Navigator.of(context).pop();
                  } else if (title == "Reviews") {
                    if (ConnectivityManagerService().connectivity == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewList(
                                  houseId: houseId ?? '',
                                  userId: 'Mpat7dK8qrOtuyl0cynM')));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:
                                const Text("There is no Internet Connection"),
                            content: const Text(
                                'This function only works with an internet connection. Please try again later.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Cerrar'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary, // Set the button color here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the border radius as needed
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .background, // Set the text color here
                      fontSize: 16.0),
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
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Adjust the width as needed
      height: 100, // Adjust the height as needed
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary, // Color of the border
          width: 4.0,
        ),
        borderRadius:
            BorderRadius.circular(12.0), // Radius of the border corners
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: ChNetworkImage(
                                    url: url,
                                    height: 100,
                                    width: 100,
                                    cacheheight: 100,
                                    cachewidth: 100),
      ),
    );
  }
}

class FeatureTable extends StatelessWidget {
  final HouseModelUpdate house;

  final List<String> caracs = [
    "apartmentFloor",
    "housingType",
    "rentPrice",
    "stratum",
    "area",
    "roomsNumber",
    "roomArea",
    "bathroomsNumber",
    "laundryArea",
    "internet",
    "tv",
    "furnished",
    "elevator",
    "gymnasium",
    "reception",
    "supermarkets"
  ];
  final List<String> texts = [
    "Apartment Floor",
    "housing Type",
    "Rent Price",
    "Stratum",
    "Area",
    "Rooms Number",
    "Room Area",
    "Bathrooms Number",
    "Laundry Area",
    "Internet",
    "TV",
    "Furnished",
    "Elevator",
    "Gymnasium",
    "Reception",
    "Supermarkets"
  ];

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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Text(
                  caracValue!,
                  style: TextStyle(
                    color: Colors.white,
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
        color: Colors.white,
      ),
      children: tableRows,
    );
  }
}
