import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:giusseppe_flut/widgets/search_field.dart';
import '../models/appartment_model.dart';
import '../services/firestore_service.dart.dart';
import '../widgets/card.dart';
import '../widgets/drawer.dart';

class AppartmentList extends StatefulWidget {
  final FirestoreService firestoreService = FirestoreService();
  
  AppartmentList({super.key, required this.title});

  final String title;

  @override
  State<AppartmentList> createState() => _AppartmentListState();
}

class _AppartmentListState extends State<AppartmentList> {
  List<DocumentSnapshot> appartments = [];

  void _getAppartments() async {
    final apartments = await widget.firestoreService.getAllDocuments(FirestoreCollections.Houses);

    setState(() {
      appartments = apartments;

      print(apartments);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    _getAppartments();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: Text(
          widget.title,
          style: const TextStyle(
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
          // Wrap the ListView.builder with an Expanded widget
          Expanded(
            child: ListView.builder(
              itemCount: appartments.length,
              itemBuilder: ((context, index) {
                // return InformationCard(
                //   path: appartments[index].path,
                //   stars: appartments[index].stars,
                //   text: appartments[index].text,
                // );
              }),
            ),
          ),
        ],
      ),
    );
  }
}