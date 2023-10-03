import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/presenter/house_list_presenter.dart';
import 'package:giusseppe_flut/repository/house_repository.dart';
import 'package:giusseppe_flut/screens/house_detail.dart';
import 'package:giusseppe_flut/screens/login.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import 'package:giusseppe_flut/widgets/information_card.dart';
import '../widgets/drawer.dart';


class HouseListView {
  void refreshHouseListView(List<HouseModelUpdate> houseList) {}
}

class HouseList extends StatefulWidget {
  HouseList({super.key});

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> implements HouseListView {
  final HouseListPresenter houseListPresenter = HouseListPresenter();
  List<HouseModelUpdate>? _housesList;
  TextEditingController _searchController = TextEditingController();
  List<HouseModelUpdate>? _filteredHousesList;

  @override
  void initState() {
    super.initState();
    houseListPresenter.backView = this;
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void refreshHouseListView(List<HouseModelUpdate> housesList) {
    setState(() {
      _housesList = housesList;
      _filteredHousesList = _housesList; // Initialize filtered list with all houses
    });
  }

  void _onSearchTextChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredHousesList = _housesList; // If search text is empty, show all houses
      } else {
        // Filter houses based on search text (you can customize this filtering logic)
        _filteredHousesList = _housesList
            ?.where((house) =>
            house.name.toLowerCase().contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_housesList!.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E5EAA),
          title: const Text(
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
            SearchField(searchController: _searchController),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredHousesList?.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: InformationCard(
                      path: 'assets/images/house1.jpg',
                      stars: _filteredHousesList![index].rating,
                      text: _filteredHousesList![index].name,
                    ),
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