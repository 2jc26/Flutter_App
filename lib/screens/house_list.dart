import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/presenter/house_list_presenter.dart';
import 'package:giusseppe_flut/repository/house_repository.dart';
import 'package:giusseppe_flut/screens/house_detail.dart';
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

class _HouseListState extends State<HouseList> implements HouseListView{
  final HouseListPresenter houseListPresenter = HouseListPresenter();
  List<HouseModelUpdate>? _housesList;

  @override
  void refreshHouseListView(List<HouseModelUpdate> housesList) {
    setState(() {
      _housesList = housesList;
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
                itemCount: _housesList?.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HouseDetail(id: _housesList![index].id)),
                      );
                    },
                    child: InformationCard(
                      path: 'assets/images/house1.jpg',
                      stars: _housesList![index].rating,
                      text: _housesList![index].name,
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