import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/repository/house_repository.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import 'package:giusseppe_flut/widgets/information_card.dart';
import '../widgets/drawer.dart';

class HouseList extends StatefulWidget {
  HouseList({super.key});
  
  final HouseRepository houseRepository = HouseRepository();

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> {
  List<HouseModelUpdate>? houses;

  void _getHouses() async {
    final data = await widget.houseRepository.getAllHouses();

    setState(() {
      houses = data;
    });
    
  }

  @override
  void initState() {
    _getHouses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (houses != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E5EAA),
          title:  const Text(
            'Houses',
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
          children: [
            const SearchField(),
            Expanded(
              child: ListView.builder(
                itemCount: houses?.length,
                itemBuilder: ((context, index) {
                  return InformationCard(
                    path: 'assets/images/house1.jpg',
                    stars: 5,
                    text: houses![index].name,
                  );
                }),
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