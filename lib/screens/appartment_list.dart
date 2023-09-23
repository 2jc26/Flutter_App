import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../drawer.dart';

class AppartmentList extends StatefulWidget {
  const AppartmentList({super.key, required this.title});

  final String title;

  @override
  State<AppartmentList> createState() => _AppartmentListState();
}

class _AppartmentListState extends State<AppartmentList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          textAlign: TextAlign.justify,
        ),
      ),
      drawer: const CustomDrawer(),
      body: const Column(
        children: [
          _SearchField()
        ]
      ),
    );
  }

}

class _SearchField extends StatelessWidget {
  const _SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          )
        ]
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Search',
          prefixIcon: Padding(
            padding: const EdgeInsets.all(20),
            child: SvgPicture.asset('assets/icons/magnifying-glass.svg', width: 20, height: 20, colorFilter: ColorFilter.mode(Color.fromARGB(255, 156, 156, 156), BlendMode.srcIn),),
          ),
          suffixIcon: Container(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const VerticalDivider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SvgPicture.asset('assets/icons/microphone.svg', width: 20, height: 20, colorFilter: ColorFilter.mode(Color.fromARGB(255, 156, 156, 156), BlendMode.srcIn),),
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
          )
        ),
      ),
    );
  }
}