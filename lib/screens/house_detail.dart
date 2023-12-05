import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:giusseppe_flut/presenter/house_detail_presenter.dart';
import 'package:giusseppe_flut/screens/review_list.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/widgets/cache_network_image.dart';
import 'package:giusseppe_flut/widgets/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
  final HouseDetailPresenter houseDetailPresenter = HouseDetailPresenter();

  // Images
  PageController _pageController = PageController();
  int _currentPage = 0;

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
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    Marker newMarker = Marker(
      markerId: const MarkerId('uniqueMarkerId'),
      position: LatLng(_house!.latitude, _house!.longitude),
    );

    if (_house != null) {
      return Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: _house!.name),
              SizedBox(
                height: 200, // Set the fixed height
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _house!.images.length,
                        itemBuilder: (context, index) {
                          return ChNetworkImage(
                            url: _house!.images[index],
                            height: 200,
                            width: screenWidth, // Set width to screen width
                            cacheheight: 200,
                            cachewidth: screenWidth.toInt(),
                          );
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: DotsIndicator(
                        dotsCount: _house!.images.length,
                        position: _currentPage,
                        decorator: const DotsDecorator(
                          activeColor: Colors.blue,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SectionTitle(title: "Description"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(_house!.description),
                    ),
                  ),
                ),
              ),
              const SectionTitle(title: "Location"),
              Visibility(
                visible: ConnectivityManagerService().connectivity == true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    child: SizedBox(
                      height: 200,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_house!.latitude, _house!.longitude),
                          zoom: 15,
                        ),
                        markers: {newMarker},
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: ConnectivityManagerService().connectivity == false,
                child: const Center(
                  child: Text(
                    "No map - No internet connection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _house!.address,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SectionTitle(title: "Included Amenities"),
              FeatureTable(house: _house!),
              Row(
                children: [
                  Button(title: 'Reviews', houseId: widget.house.id),
                  const Button(title: "I'm Interested"),
                ]
              )
            ],
          ),
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

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required String title,
  }) : _title = title;

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        _title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF2e5eaa)
        ),
        textAlign: TextAlign.left,
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
                  style: const TextStyle(
                    color: Color(0xFF2c595b),
                  ),
                ),
              ),
            ),
            TableCell(
              child: Center(
                child: Text(
                  caracValue!,
                  style: const TextStyle(
                    color: Color(0xFF2c595b),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: Table(
        border: TableBorder.all(
          color: Color(0xFF2c595b),
        ),
        children: tableRows,
      ),
    );
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
                child: Text(
                  title,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}