import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/presenter/house_presenter.dart';
import 'package:giusseppe_flut/repository/house_repository.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import 'package:giusseppe_flut/widgets/information_card.dart';
import '../widgets/drawer.dart';


class HouseListView {
  void refreshHouseListView(List<HouseModelUpdate> housesList, List<HouseModelUpdate> housesLikingList) {}
}

class HouseList extends StatefulWidget {
  HouseList({super.key});

  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> implements HouseListView{
  final HouseListPresenter houseListPresenter = HouseListPresenter();
  List<HouseModelUpdate>? _housesList;
  List<HouseModelUpdate>? _housesLikingList;

  @override
  void refreshHouseListView(List<HouseModelUpdate> housesList, List<HouseModelUpdate> housesLikingList) {
    setState(() {
      _housesLikingList = housesLikingList;
      print(_housesLikingList);
      _housesList = housesList;
      print(_housesList);
    });
  }

  @override
  void initState() {
    super.initState();
    houseListPresenter.backView = this;
  }

  @override
  Widget build(BuildContext context) {
    if (_housesList!.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E5EAA),
          title:  const Text(
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
                child: Text("Houses that match your tastes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              Container(
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
                child: Text("Houses that match your searchs", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              Container(
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
                child: Text("All the houses", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              const SearchField(),
              Container(
                height: 250,
                child: ListView.builder(
                  itemCount: _housesList?.length,
                  itemBuilder: ((context, index) {
                    return InformationCard(
                      path: 'assets/images/house1.jpg',
                      stars: _housesList![index].rating,
                      text: _housesList![index].name,
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