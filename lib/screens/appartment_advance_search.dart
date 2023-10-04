import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/presenter/house_search_presenter.dart';
import 'package:giusseppe_flut/screens/roomie_detail.dart';
import 'package:giusseppe_flut/widgets/drawer.dart';

class AppartmentAdvanceSearch extends StatefulWidget {
  const AppartmentAdvanceSearch({
    Key? key,
    required this.direction,
    required this.obPrice,
    required this.distance,
    required this.ratingVal,
    required this.userId,
  }) : super(key: key);

  final String title = 'Advance Filter';

  final String direction;
  final String obPrice;
  final String distance;
  final double ratingVal;
  final String userId;

  @override
  State<AppartmentAdvanceSearch> createState() =>
      _AppartmentAdvanceSearchState();
}

enum PropertyType { house, apartment }

class _AppartmentAdvanceSearchState extends State<AppartmentAdvanceSearch> {
  PropertyType _selectedPropertyType = PropertyType.house;
  TextEditingController cityController = TextEditingController();
  TextEditingController neighborhoodController = TextEditingController();
  TextEditingController stratumController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController roomsNumberontroller = TextEditingController();
  TextEditingController roomAreaController = TextEditingController();
  TextEditingController bathroomAreaController = TextEditingController();

  // Servicee
  bool _isLaundrySelected = false;
  bool _isInternetSelected = false;
  bool _isTvSelected = false;
  bool _isFoodSelected = false;
  bool _isFurnishedSelected = false;

  // Others
  bool _isElevatorSelected = false;
  bool _isGymSelected = false;
  bool _isReceptionSelected = false;
  bool _isSupermarketSelected = false;


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
              margin: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _inputField("City/Municipality", cityController),
                    const SizedBox(height: 20),
                    _inputField("Neighborhood", neighborhoodController),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16.0), // Add space between buttons
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedPropertyType = PropertyType.house;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle, // Square shape
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: const Color(0xFF2c595b), // Border color
                                    width: 2.0, // Border width
                                  ),
                                  color: _selectedPropertyType ==
                                          PropertyType.house
                                      ? const Color(
                                          0xFF2c595b) // Background color when selected
                                      : Colors
                                          .white, // Transparent background when not selected
                                ),
                                width: 24.0, // Adjust the size as needed
                                height: 24.0, // Adjust the size as needed
                                child: Center(
                                  child: _selectedPropertyType ==
                                          PropertyType.house
                                      ? const Icon(
                                          Icons.check,
                                          size: 16.0,
                                          color: Colors.white,
                                        ) // Display a checkmark when selected
                                      : null, // No icon when not selected
                                ),
                              ),
                            ),
                            const Text(
                              'House',
                              style: TextStyle(
                                color: Color(0xFF2c595b), // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0), // Add space between buttons
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedPropertyType =
                                      PropertyType.apartment;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle, // Square shape
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: const Color(0xFF2c595b), // Border color
                                    width: 2.0, // Border width
                                  ),
                                  color: _selectedPropertyType ==
                                          PropertyType.apartment
                                      ? const Color(
                                          0xFF2c595b) // Background color when selected
                                      : Colors
                                          .white, // Transparent background when not selected
                                ),
                                width: 24.0, // Adjust the size as needed
                                height: 24.0, // Adjust the size as needed
                                child: Center(
                                  child: _selectedPropertyType ==
                                          PropertyType.apartment
                                      ? const Icon(
                                          Icons.check,
                                          size: 16.0,
                                          color: Colors.white,
                                        ) // Display a checkmark when selected
                                      : null, // No icon when not selected
                                ),
                              ),
                            ),
                            const Text(
                              'Apartment',
                              style: TextStyle(
                                color: Color(0xFF2c595b), // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    _inputField("Stratum", stratumController, isNumber: true),
                    const SizedBox(height: 20),
                    _inputField("Area", areaController, isNumber: true),
                    const SizedBox(height: 20),
                    _inputField("Floor Number", floorNumberController, isNumber: true),
                    const SizedBox(height: 20),
                    _inputField("Rooms Number", roomsNumberontroller, isNumber: true),
                    const SizedBox(height: 20),
                    _inputField("Room Area", roomAreaController, isNumber: true),
                    const SizedBox(height: 20),
                    _inputField("Bathrooms Area", bathroomAreaController, isNumber: true),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              margin: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Services", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    createCustomCheckbox('Laundry Areas', _isLaundrySelected, () {
                      setState(() {
                        _isLaundrySelected = !_isLaundrySelected;
                      });
                    }),
                    createCustomCheckbox('Kitchen', _isInternetSelected, () {
                      setState(() {
                        _isInternetSelected = !_isInternetSelected;
                      });
                    }),
                    createCustomCheckbox('Bathroom', _isTvSelected, () {
                      setState(() {
                        _isTvSelected = !_isTvSelected;
                      });
                    }),
                    createCustomCheckbox('Food', _isFoodSelected, () {
                      setState(() {
                        _isFoodSelected = !_isFoodSelected;
                      });
                    }),
                    createCustomCheckbox('Furnished', _isFurnishedSelected, () {
                      setState(() {
                        _isFurnishedSelected = !_isFurnishedSelected;
                      });
                    }),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              margin: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Others", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    createCustomCheckbox('Elevator', _isElevatorSelected, () {
                      setState(() {
                        _isElevatorSelected = !_isElevatorSelected;
                      });
                    }),
                    createCustomCheckbox('Gym', _isGymSelected, () {
                      setState(() {
                        _isGymSelected = !_isGymSelected;
                      });
                    }),
                    createCustomCheckbox('Recption', _isReceptionSelected, () {
                      setState(() {
                        _isReceptionSelected = !_isReceptionSelected;
                      });
                    }),
                    createCustomCheckbox('Supermarkets', _isSupermarketSelected, () {
                      setState(() {
                        _isSupermarketSelected = !_isSupermarketSelected;
                      });
                    }),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loginButton(),
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

  Widget createCustomCheckbox(String label, bool isSelected, Function onTap) {
    return Row(
    children: [
      Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color(0xFF2c595b),
            width: 2.0,
          ),
          color: isSelected ? const Color(0xFF2c595b) : Colors.white,
        ),
        width: 24.0,
        height: 24.0,
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Center(
            child: isSelected
                ? const Icon(
                    Icons.check,
                    size: 16.0,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
      ),
      Text(
        label,
        style: const TextStyle(
          color: Color(0xFF2c595b),
        ),
      ),
    ],
  );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        
        HouseSearchingModelUpdate filter = HouseSearchingModelUpdate(
          city: cityController.text,
          neighborhood: neighborhoodController.text,
          address: widget.direction,
          housingType: _selectedPropertyType.toString(),
          rentPrice: widget.obPrice,
          stratum: int.parse(stratumController.text),
          area: double.parse(areaController.text),
          apartmentFloor: int.parse(floorNumberController.text),
          roomsNumber: int.parse(roomsNumberontroller.text),
          bathroomsNumber: int.parse(bathroomAreaController.text),
          laundryArea: _isLaundrySelected,
          internet: _isInternetSelected,
          tv: _isTvSelected,
          furnished: _isFurnishedSelected,
          elevator: _isElevatorSelected,
          gymnasium: _isGymSelected,
          reception: _isReceptionSelected,
          supermarkets: _isSupermarketSelected,
        );

        HouseSearchPresenter houseSearchPresenter = HouseSearchPresenter(widget.userId);
        houseSearchPresenter.updateHouseSearchingById(widget.userId,filter);
        houseSearchPresenter.updateHouseFilters(filter);

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



