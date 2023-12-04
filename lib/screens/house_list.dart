import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/presenter/house_list_presenter.dart';
import 'package:giusseppe_flut/screens/appartment_filter.dart';
import 'package:giusseppe_flut/screens/house_creation.dart';
import 'package:giusseppe_flut/screens/house_detail.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';
import 'package:giusseppe_flut/screens/no_connectivity.dart';
import 'package:giusseppe_flut/widgets/bottom_nav_bar.dart';
import 'package:giusseppe_flut/widgets/custom_app_bar.dart';
import 'package:giusseppe_flut/widgets/info_card.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';

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
    // TODO: reemplazar por el id del usuario logueado del cache/local storage
    _userId = widget.userId;

    _houseFilters = widget.houseFilters;

    houseListPresenter = HouseListPresenter(widget.userId, widget.houseFilters);

    houseListPresenter.backView = this;
    
    _searchController.addListener(_onSearchTextChanged);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
    super.initState();
  }

  Future<void> _refresh() async {
    houseListPresenter.refreshData(_userId, null);
  }

  // Images
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    
    int dotsCount = _housesLikingList!.length;

    if(dotsCount == 0) {
      dotsCount = 1;
    }

    if ((_housesList!.isNotEmpty && _houseFilters == null) || (_housesSearchingList!.isNotEmpty && _houseFilters != null)) {
      return Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: const BottomNavBar(index: 3),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: [
                      if (_houseFilters == null && _housesLikingList!.isNotEmpty)
                        const SizedBox(height: 10),
                      Visibility(
                        visible: _houseFilters == null && _housesLikingList!.isNotEmpty,
                        child: const Text(
                          "Liking Houses",
                          style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        )
                      ),
                      Visibility(
                        visible: _houseFilters == null && _housesLikingList!.isNotEmpty && _housesLikingList!.isNotEmpty,
                        child: SizedBox(
                          height: 370, // Set the fixed height
                          child: Stack(
                            children: [
                            PageView.builder(
                                controller: _pageController,
                                itemCount: _housesLikingList!.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      houseListPresenter.addVisitToHouse(_housesLikingList![index].id);
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => HouseDetail(house: _housesLikingList![index]),
                                      ));
                                    },
                                    child: InfoCard(
                                      name: _housesLikingList![index].name,
                                      rating: _housesLikingList![index].rating,
                                      address: _housesLikingList![index].address,
                                      imageUrl: _housesLikingList![index].images[0],
                                      imageWidth: 300,
                                      imageHeight: 300,
                                      padding: 40,
                                    ),
                                  );
                                },
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: DotsIndicator(
                                  dotsCount: dotsCount,
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
                      ),
                      const SizedBox(height: 10),
                      HouseSection(
                          userId: _userId,
                          title: 'All Houses',
                          housesList: _filteredHousesList,
                          flex: 650,
                          filter: true,
                          searchController: _searchController,
                          houseListPresenter: houseListPresenter,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
            ]
          )
        ),
      );
    } else {
      if(ConnectivityManagerService().connectivity) {
        if(_housesList!.isEmpty && _houseFilters == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const NoHousesSearch();
        }
      } else {
        return NoConnectivity(presenter: houseListPresenter, userId:_userId, houseFilters: _houseFilters);
      }
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
      appBar: CustomAppBar(),
      bottomNavigationBar: const BottomNavBar(index: 3),
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

class HouseSection extends StatelessWidget {
  const HouseSection({
    super.key,
    required String title,
    required String? userId,
    required List<HouseModelUpdate>? housesList,
    required double flex,
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
  final double _flex;
  final bool _filter;
  final TextEditingController _searchController;
  final HouseListPresenter _houseListPresenter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _flex,
      child: Column(
        children: [
          Text(
            _title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Visibility(
            visible: _title == 'All Houses',
            child: SearchField(searchController: _searchController)),
          Visibility(
            visible: _title == 'All Houses',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Create New'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseCreation(userId: _userId!)),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Visibility(
                  visible: _filter,
                  child: ElevatedButton(
                    child: const Text('Filter'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppartmentFilter(userId: _userId!)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
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
            _houseListPresenter.addVisitToHouse(_houseList![index].id);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HouseDetail(house: _houseList![index]),
            ));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InfoCard(
              name: _houseList![index].name,
              rating: _houseList![index].rating,
              address: _houseList![index].address,
              imageUrl: _houseList![index].images[0],
              imageWidth: 300,
              imageHeight: 300,
              padding: 40,
            ),
          )
        );
      }),
    );
  }
}
