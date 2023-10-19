import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/presenter/house_list_presenter.dart';
import 'package:giusseppe_flut/screens/appartment_filter.dart';
import 'package:giusseppe_flut/screens/house_detail.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import 'package:giusseppe_flut/widgets/information_card.dart';
import '../widgets/drawer.dart';

class HouseListView {
  void refreshHouseListView(List<HouseModelUpdate> housesList, List<HouseModelUpdate> housesLikingList, List<HouseModelUpdate> housesSearchingList) {}
}

class HouseList extends StatefulWidget {

  const HouseList({super.key, required this.userId, required this.houseFilters});

  final String userId;
  final HouseSearchingModelUpdate? houseFilters;

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> implements HouseListView {
  late HouseListPresenter houseListPresenter;
  
  String? _userId;

  final TextEditingController _searchController = TextEditingController();
  
  List<HouseModelUpdate>? _housesList;
  List<HouseModelUpdate>? _filteredHousesList;
  List<HouseModelUpdate>? _housesLikingList;
  List<HouseModelUpdate>? _housesSearchingList;

  @override
  void refreshHouseListView(List<HouseModelUpdate> housesList, List<HouseModelUpdate> housesLikingList, List<HouseModelUpdate> housesSearchingList) {
    setState(() {
      _housesLikingList = housesLikingList;
      _housesList = housesList;
      _housesSearchingList = housesSearchingList;
      if(housesSearchingList.isEmpty) {
        _filteredHousesList = _housesList;
      } else {
        _filteredHousesList = _housesSearchingList;
      }
    });
  }

  void _onSearchTextChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        if(_housesSearchingList!.isEmpty) {
          _filteredHousesList = _housesList;
        } else {
          _filteredHousesList = _housesSearchingList;
        }
      } else {
        // Filter houses based on search text
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
    _userId = widget.userId;
    houseListPresenter = HouseListPresenter(widget.userId,widget.houseFilters);
    houseListPresenter.backView = this;
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    if (_housesList!.isNotEmpty && _userId != null) {
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
              if (_housesSearchingList!.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Houses that match your tastes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              if (_housesSearchingList!.isEmpty)
              HouseSection(houseList: _housesLikingList),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Houses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SearchField(searchController: _searchController),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppartmentFilter(userId: _userId!)),
                  );
                },
              ),
              HouseSection(houseList: _filteredHousesList),
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

class HouseSection extends StatelessWidget {
  const HouseSection({
    super.key,
    required List<HouseModelUpdate>? houseList,
  }) : _houseList = houseList;

  final List<HouseModelUpdate>? _houseList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: _houseList?.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    HouseDetail(house: _houseList![index]),
              ));
            },
            child: InformationCard(
              path: 'assets/images/house1.jpg',
              stars: _houseList![index].rating,
              text: _houseList![index].name,
            ),
          );
        }),
      ),
    );
  }
}