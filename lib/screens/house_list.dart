import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/presenter/house_list_presenter.dart';
import 'package:giusseppe_flut/screens/appartment_filter.dart';
import 'package:giusseppe_flut/screens/house_detail.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import 'package:giusseppe_flut/widgets/information_card.dart';
import '../widgets/drawer.dart';

class HouseListView {
  void refreshHouseListView(List<HouseModelUpdate> housesList,
      List<HouseModelUpdate> housesLikingList) {}
}

class HouseList extends StatefulWidget {
  String userId;

  HouseList({super.key, required this.userId});

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> implements HouseListView {
  final HouseListPresenter houseListPresenter = HouseListPresenter();
  List<HouseModelUpdate>? _housesList;
  String? _userId;
  final TextEditingController _searchController = TextEditingController();
  List<HouseModelUpdate>? _filteredHousesList;
  List<HouseModelUpdate>? _housesLikingList;

  @override
  void refreshHouseListView(List<HouseModelUpdate> housesList,
      List<HouseModelUpdate> housesLikingList) {
    setState(() {
      _userId = widget.userId;
      _housesLikingList = housesLikingList;
      _housesList = housesList;
      _filteredHousesList =
      _housesList; // Initialize filtered list with all houses
    });
  }

  void _onSearchTextChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredHousesList =
            _housesList; // If search text is empty, show all houses
      } else {
        // Filter houses based on search text (you can customize this filtering logic)
        _filteredHousesList = _housesList
            ?.where((house) => house.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    houseListPresenter.backView = this;
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    if (_housesList!.isNotEmpty) {
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Houses that match your tastes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: _housesLikingList?.length,
                  itemBuilder: ((context, index) {
                    return InformationCard(
                      path: 'assets/images/house1.jpg',
                      stars: _housesLikingList![index].rating,
                      text: _housesLikingList![index].name,
                    );
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Houses that match your searchs",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: _housesLikingList?.length,
                  itemBuilder: ((context, index) {
                    return InformationCard(
                      path: 'assets/images/house1.jpg',
                      stars: _housesLikingList![index].rating,
                      text: _housesLikingList![index].name,
                    );
                  }),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "All the houses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SearchField(searchController: _searchController),
              IconButton(
                icon: Icon(Icons.filter_list), // Specify the icon you want to use
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppartmentFilter(userId: _userId!)),
                  );
                },
              ),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: _filteredHousesList?.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              HouseDetail(house: _housesLikingList![index]),
                        ));
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
