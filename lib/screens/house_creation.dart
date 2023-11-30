import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giusseppe_flut/presenter/house_creation_presenter.dart';
import 'dart:io';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/widgets/image_selector.dart';

class HouseCreationView {
  void refreshHouseCreationView(List<String> descriptions) {}
}

class HouseCreation extends StatefulWidget {
  
  final String userId;

  const HouseCreation({super.key, required this.userId});

  @override
  _HouseCreationState createState() => _HouseCreationState();
}

class _HouseCreationState extends State<HouseCreation> implements HouseCreationView {

  late HouseCreationPresenter houseCreationPresenter;

  String? _userId;
  List<String> _descriptionsList = [];
  bool _help = false;

  TextEditingController housingNameController = TextEditingController();
  TextEditingController rentPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController appartmentAreaController = TextEditingController();
  TextEditingController roomsNumberController = TextEditingController();
  TextEditingController roomAreaController = TextEditingController();
  TextEditingController stratumController = TextEditingController();
  TextEditingController bathroomNumberController = TextEditingController();

  String housingType = 'House';
  String citySelectedComboBoxValue = 'Bogotá';
  String neighborhoodSelectedComboBoxValue = 'Suba';

  bool elevator = false;
  bool furnished = false;
  bool gymnasium = false;
  bool internet = false;
  bool laundryArea = false;
  bool pets = false;
  bool reception = false;
  bool smoke = false;
  bool supermarkets = false;
  bool tv = false;
  bool vape = false;

  // Control de las opciones de los comboBox
  List<String> cityComboBoxOptions = ['Bogotá'];
  List<String> neighborhoodComboBoxOptions = [
    "Usaquén",
    "Chapinero",
    "Santa Fe",
    "San Cristóbal",
    "Usme",
    "Tunjuelito",
    "Bosa",
    "Kennedy",
    "Fontibón",
    "Engativá",
    "Suba",
    "Barrios Unidos",
    "Teusaquillo",
    "Los Mártires",
    "Antonio Nariño",
    "Puente Aranda",
    "La Candelaria",
    "Rafael Uribe Uribe",
    "Ciudad Bolívar",
    "Sumapaz"
  ];

  void createApartment() {
    if(ConnectivityManagerService().connectivity == true){
      houseCreationPresenter.createHouse(_userId!,housingNameController.text, housingType, rentPriceController.text, descriptionController.text, citySelectedComboBoxValue, neighborhoodSelectedComboBoxValue, addressController.text, floorController.text, appartmentAreaController.text, roomsNumberController.text, roomAreaController.text, bathroomNumberController.text, stratumController.text, elevator, furnished, gymnasium, internet, laundryArea, pets, reception, smoke, supermarkets, tv, vape, _images);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Appartment created successfully"),
            content: const Text("The appartment is now visibile to other users of the app"),
            actions: [
              MaterialButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Creation without connection"),
            content: const Text("Are you sure you want to create the appartment wh¡ithout connection?"),
            actions: [
              MaterialButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  houseCreationPresenter.createHouse(_userId!,housingNameController.text, housingType, rentPriceController.text, descriptionController.text, citySelectedComboBoxValue, neighborhoodSelectedComboBoxValue, addressController.text, floorController.text, appartmentAreaController.text, roomsNumberController.text, roomAreaController.text, bathroomNumberController.text, stratumController.text, elevator, furnished, gymnasium, internet, laundryArea, pets, reception, smoke, supermarkets, tv, vape, _images);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Postponed load"),
                        content: const Text("The next time you open the app with connection, the apartment will be created"),
                        actions: [
                          MaterialButton(
                            child: const Text("Ok"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  final List<File> _images = [];

  @override
  void initState() {

    _userId = widget.userId;
    _help = false;
    _descriptionsList = [];
    houseCreationPresenter = HouseCreationPresenter();

    houseCreationPresenter.backView = this;

    super.initState();
  }

  void _showDescriptionHelpModal() {
    setState(() {
      _help = !_help;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // General Information
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'General Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _inputField("Housing Name", housingNameController, 30,
                          isNumber: false),
                      const SizedBox(height: 16),
                      const Text('Housing Type:'),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 'House',
                                groupValue: housingType,
                                onChanged: (value) {
                                  setState(() {
                                    housingType = value as String;
                                  });
                                },
                              ),
                              const Text('House'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 'Apartment',
                                groupValue: housingType,
                                onChanged: (value) {
                                  setState(() {
                                    housingType = value as String;
                                  });
                                },
                              ),
                              const Text('Apartment'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _inputField("Rent Price", rentPriceController, 7,
                          isNumber: true),
                      const SizedBox(height: 20),
                      _inputField("Description", descriptionController, 100,
                          isNumber: false),
                      Visibility(
                        visible: _descriptionsList.isNotEmpty,
                        child: GestureDetector(
                          onTap: () {
                            _showDescriptionHelpModal();
                          },
                          child: Row(
                              children: [
                                Icon(Icons.help, color: Theme.of(context).colorScheme.primary),
                                Text(
                                  "What's a good description?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                        ),
                      ),
                      Visibility(
                        visible: _help,
                        child: SizedBox(
                          width: 280,
                          height: 150,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                _descriptionsList.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 220,
                                    height: 100,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(_descriptionsList[index]),
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //Location
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text('City:'),
                          const SizedBox(width: 20),
                          DropdownButton<String>(
                            value: citySelectedComboBoxValue,
                            onChanged: (value) {
                              setState(() {
                                citySelectedComboBoxValue = value!;
                              });
                            },
                            items: cityComboBoxOptions.map((option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Neighborhood:'),
                          const SizedBox(width: 20),
                          DropdownButton<String>(
                            value: neighborhoodSelectedComboBoxValue,
                            onChanged: (value) {
                              setState(() {
                                neighborhoodSelectedComboBoxValue = value!;
                              });
                            },
                            items: neighborhoodComboBoxOptions.map((option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _inputField("Address", addressController, 30,
                          isNumber: false),
                    ],
                  ),
                ),
              ),
              // Characteristics
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Characteristics',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _inputField("Stratum", stratumController, 1,
                          isNumber: true),
                      const SizedBox(height: 20),
                      _inputField("Appartment Floor", floorController, 2,
                          isNumber: true),
                      const SizedBox(height: 20),
                      _inputField(
                          "Appartment Area", appartmentAreaController, 3,
                          isNumber: true),
                      const SizedBox(height: 20),
                      _inputField("Rooms Number", roomsNumberController, 1,
                          isNumber: true),
                      const SizedBox(height: 20),
                      _inputField("Rooms Area", roomAreaController, 2,
                          isNumber: true),
                      const SizedBox(height: 20),
                      _inputField("Bathrooms Number", bathroomNumberController, 1,
                          isNumber: true),
                    ],
                  ),
                ),
              ),
              // Services
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: elevator,
                            onChanged: (value) {
                              setState(() {
                                elevator = value!;
                              });
                            },
                          ),
                          const Text('Elevator'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: furnished,
                            onChanged: (value) {
                              setState(() {
                                furnished = value!;
                              });
                            },
                          ),
                          const Text('Furnished'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: gymnasium,
                            onChanged: (value) {
                              setState(() {
                                gymnasium = value!;
                              });
                            },
                          ),
                          const Text('Gymnasium'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: internet,
                            onChanged: (value) {
                              setState(() {
                                internet = value!;
                              });
                            },
                          ),
                          const Text('Internet'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: laundryArea,
                            onChanged: (value) {
                              setState(() {
                                laundryArea = value!;
                              });
                            },
                          ),
                          const Text('Laundry Area'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: pets,
                            onChanged: (value) {
                              setState(() {
                                pets = value!;
                              });
                            },
                          ),
                          const Text('Allow Pets'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: reception,
                            onChanged: (value) {
                              setState(() {
                                reception = value!;
                              });
                            },
                          ),
                          const Text('Reception'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: smoke,
                            onChanged: (value) {
                              setState(() {
                                smoke = value!;
                              });
                            },
                          ),
                          const Text('Allow Smoke'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: vape,
                            onChanged: (value) {
                              setState(() {
                                vape = value!;
                              });
                            },
                          ),
                          const Text('Allow Vape'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: supermarkets,
                            onChanged: (value) {
                              setState(() {
                                supermarkets = value!;
                              });
                            },
                          ),
                          const Text('Supermarkets'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Checkbox(
                            value: tv,
                            onChanged: (value) {
                              setState(() {
                                tv = value!;
                              });
                            },
                          ),
                          const Text('TV'),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              // Images
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Images',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ImageSelector(images: _images),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Create Button
              ElevatedButton(
                onPressed: createApartment,
                child: const Text('Publish'),
              ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
  
  @override
  void refreshHouseCreationView(List<String> descriptions) {
    setState(() {
      _descriptionsList = descriptions;
    });
  }
}

Widget _inputField(String hintText, TextEditingController controller, int len,
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
      ),
      maxLength: len,
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
      maxLength: len,
    );
  }
}
