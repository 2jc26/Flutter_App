import 'package:flutter/material.dart';
import '../services/firestore_service.dart.dart';
import '../widgets/drawer.dart';

class BackTest extends StatefulWidget {
  final FirestoreService firestoreService = FirestoreService();
  
  BackTest({super.key, required this.title});

  final String title;

  @override
  State<BackTest> createState() => _BackTestState();
}

class _BackTestState extends State<BackTest> {
  Map<String, dynamic>? appartments;

  void _getAppartments() async {
    final data = await widget.firestoreService.getDocument(FirestoreCollections.Houses, 'Test0');
    if (data != null) {
      setState(() {
        appartments = data;
        print(data);
      });
    } else {
      // Handle the case where the document doesn't exist
    }
  }

  @override
  void initState() {
    _getAppartments();
  }

  @override
  Widget build(BuildContext context) {
    if (appartments != null && appartments!.containsKey('Testjahd')) {
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
        body: Text(appartments!['Testjahd'].toString()),
      );
    }
    return Text('dasda');
  }
}