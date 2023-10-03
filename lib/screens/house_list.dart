import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/house/house_model_update.dart';
import 'package:giusseppe_flut/presenter/house_presenter.dart';
import 'package:giusseppe_flut/repository/house_repository.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import 'package:giusseppe_flut/widgets/information_card.dart';
import '../widgets/drawer.dart';


class HouseListView {
  void refreshHouseListView(List<HouseModelUpdate> houseList) {}
}

class HouseList extends StatefulWidget {

  String userId = '';

  HouseList({super.key, required this.userId});


  @override
  State<HouseList> createState() => _HouseListState();
}

class _HouseListState extends State<HouseList> implements HouseListView{
  final HouseListPresenter userListPresenter = HouseListPresenter();
  List<HouseModelUpdate>? _housesList;
  String? _userId;

  @override
  void refreshHouseListView(List<HouseModelUpdate> housesList) {
    setState(() {
      print(widget.userId);
      _userId = widget.userId;
      _housesList = housesList;
    });
  }

  @override
  void initState() {
    super.initState();
    userListPresenter.backView = this;
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