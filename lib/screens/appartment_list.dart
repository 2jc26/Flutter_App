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
        backgroundColor: Color(0xFF2E5EAA),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
        ),
      ),
      drawer: const CustomDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            _SearchField(),
            _Card(),
            _Card(),
            _Card(),
            _Card()
          ]
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Card(
        color: const Color(0xFF2C595B),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/house1.jpg',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            Row(
              children: [
                // Left side with star icons and location icon
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return const Icon(
                            Icons.star,
                            color: Color(0xFFEDF9B9),
                            size: 24,
                          );
                        }),
                      ),
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFFEDF9B9),
                        size: 24,
                      ),
                    ],
                  ),
                ),
                // Right side with text
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Teusaquillo\n2 Bathrooms',
                          style: TextStyle(
                              fontSize: 16, color: Color(0xFFDAE3E5)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
      height: 30,
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0,
        )
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(5),
            hintText: 'Search',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(
                'assets/icons/magnifying-glass.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(255, 156, 156, 156), BlendMode.srcIn),
              ),
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
                      padding: const EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        'assets/icons/microphone.svg',
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                            Color.fromARGB(255, 156, 156, 156),
                            BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
