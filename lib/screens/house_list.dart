import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/presenter/house_list_presenter.dart';
import 'package:giusseppe_flut/screens/InformationCardUser.dart';
import 'package:giusseppe_flut/screens/appartment_filter.dart';
import 'package:giusseppe_flut/screens/house_detail.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import '../widgets/drawer.dart';

class HouseListView {
  void refreshHouseListView(
      List<HouseModelUpdate> housesList,
      List<HouseModelUpdate> housesLikingList,
      List<HouseModelUpdate> housesSearchingList) {}
}

class HouseList extends StatefulWidget {
  const HouseList(
      {super.key, required this.userId, required this.houseFilters});

  final String userId;
  final HouseSearchingModelUpdate? houseFilters;

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> implements HouseListView {
  late HouseListPresenter houseListPresenter;

  String? _userId;

  final TextEditingController _searchController = TextEditingController();

  HouseSearchingModelUpdate? _houseFilters;
  List<HouseModelUpdate>? _housesList;
  List<HouseModelUpdate>? _filteredHousesList;
  List<HouseModelUpdate>? _housesLikingList;
  List<HouseModelUpdate>? _housesSearchingList;

  @override
  void refreshHouseListView(
      List<HouseModelUpdate> housesList,
      List<HouseModelUpdate> housesLikingList,
      List<HouseModelUpdate> housesSearchingList) {
    setState(() {
      _housesLikingList = housesLikingList;
      _housesList = housesList;
      _housesSearchingList = housesSearchingList;
      if (_houseFilters == null) {
        _filteredHousesList = _housesList;
      } else {
        _filteredHousesList = _housesSearchingList;
      }
    });
  }

  void _onSearchTextChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        if (_housesSearchingList!.isEmpty) {
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
    _houseFilters = widget.houseFilters;
    houseListPresenter = HouseListPresenter(widget.userId, widget.houseFilters);
    houseListPresenter.backView = this;
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  Widget build(BuildContext context) {
    if ((_housesList!.isNotEmpty && _houseFilters == null) ||
        (_housesSearchingList!.isNotEmpty && _houseFilters != null)) {
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
          children: [
            if (_houseFilters == null && _housesLikingList!.isNotEmpty)
              const SizedBox(height: 10),
            if (_houseFilters == null && _housesLikingList!.isNotEmpty)
              HouseSection(
                  userId: _userId,
                  title: 'Liking Houses',
                  housesList: _housesLikingList,
                  flex: 1,
                  filter: false,
                  searchController: _searchController,
                  houseListPresenter: houseListPresenter),
            const SizedBox(height: 10),
            HouseSection(
                userId: _userId,
                title: 'All Houses',
                housesList: _filteredHousesList,
                flex: 2,
                filter: true,
                searchController: _searchController,
                houseListPresenter: houseListPresenter),
            const SizedBox(height: 10),
          ],
        ),
      );
    } else if (_housesList!.isEmpty && _houseFilters == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return const NoHousesSearch();
    }
  }

  void openHouseDetail(HouseModelUpdate house) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HouseDetail(house: house),
      )
    );
  }
}

class NoHousesSearch extends StatelessWidget {
  const NoHousesSearch({
    super.key,
  });

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
      drawer: const CustomDrawer(),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          "There are no houses matching your search",
          style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required String? userId,
    required TextEditingController searchController,
  })  : _userId = userId,
        _searchController = searchController;

  final String? _userId;
  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(searchController: _searchController),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AppartmentFilter(userId: _userId!)),
            );
          },
        ),
      ],
    );
  }
}

class HouseSection extends StatelessWidget {
  const HouseSection({
    super.key,
    required String title,
    required String? userId,
    required List<HouseModelUpdate>? housesList,
    required int flex,
    required bool filter,
    required TextEditingController searchController,
    required HouseListPresenter houseListPresenter,
  })  : _userId = userId,
        _title = title,
        _housesList = housesList,
        _flex = flex,
        _filter = filter,
        _searchController = searchController,
        _houseListPresenter = houseListPresenter;
  final String? _userId;
  final String _title;
  final List<HouseModelUpdate>? _housesList;
  final int _flex;
  final bool _filter;
  final TextEditingController _searchController;
  final HouseListPresenter _houseListPresenter;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: _flex,
      fit: FlexFit.tight,
      child: Column(
        children: [
          Text(
            _title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          if (_filter)
            FilterButton(userId: _userId!, searchController: _searchController),
          Expanded(
            child: HouseElements(houseList: _housesList, houseListPresenter: _houseListPresenter),
          ),
        ],
      ),
    );
  }
}

class HouseElements extends StatelessWidget {
  const HouseElements({
    super.key,
    required List<HouseModelUpdate>? houseList,
    required HouseListPresenter houseListPresenter
  }) : _houseList = houseList, _houseListPresenter = houseListPresenter;

  final List<HouseModelUpdate>? _houseList;
  final HouseListPresenter _houseListPresenter;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _houseList?.length,
      itemBuilder: ((context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HouseDetail(house: _houseList![index]),
            ));
          },
          child: const Text("Hello World!"),
          /*child: InformationCardUser(
            getImageURL: () => _houseListPresenter.getImage(_houseList![index].images[0]), // Pasa una función que obtiene la imagen.
            stars: _houseList![index].rating,
            text: _houseList![index].name,
          ),*/
        );
      }),
    );
  }
}
