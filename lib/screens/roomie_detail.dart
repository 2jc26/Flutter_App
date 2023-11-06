import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../widgets/drawer.dart';

class RoommateDetail extends StatelessWidget {
  const RoommateDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDAE3E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          "Search Roommate",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      // drawer: CustomDrawer(customDrawerContext: context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 32.0,
                  bottom: 16.0,
                ),
                child: Text(
                  'Juan Manuel Rodriguez Ardila',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF2C595B),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 30,
                ),
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://fs-prod-cdn.nintendo-europe.com/media/images/10_share_images/portals_3/2x1_SuperMarioHub.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    width: 8,
                    color: const Color(0xFF2C595B),
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 32.0,
                  bottom: 16.0,
                  right: 10,
                  left: 10,
                ),
                child: Text(
                  'Attributes',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Attribute(attribute: 'Comparison',),
                          Spacer(),
                          Attribute(attribute: 'Dog owner',),
                          Spacer(),
                          Attribute(attribute: 'Cocina bien',),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Attribute(attribute: 'Amable',),
                          Spacer(),
                          Attribute(attribute: 'Limpio',),
                          Spacer(),
                          Attribute(attribute: 'Estudiante',),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 16.0,
                  right: 10,
                  left: 10,
                ),
                child: Text(
                  'Badges',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Badge(),
                          Spacer(),
                          Badge(),
                          Spacer(),
                          Badge(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Badge(),
                          Spacer(),
                          Badge(),
                          Spacer(),
                          Badge(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 16.0,
                  right: 10,
                  left: 10,
                ),
                child: Text(
                  'Ratings',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              const RatingsSection(),
              const RatingsSection(),
              const RatingsSection(),
              const RatingsSection(),
              const NavigatorS(),
            ],
          ),
        ),
      ),
    );
  }
}
class RatingsSection extends StatelessWidget {
  const RatingsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 600,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF2c595b),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '5',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Row(
              children: [
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class Badge extends StatelessWidget {
  const Badge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFdae3e5),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Example',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Icon(
            Icons.star,
            size: 40,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class Attribute extends StatelessWidget {
  final String attribute;

  const Attribute({Key? key, required this.attribute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFF2c595b),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 5),
              color: Color(0xFFA7A9AF),
              inset: false,
              blurStyle: BlurStyle.normal,
            ),
          ]),
      child: Text(
        attribute,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
class NavigatorS extends StatelessWidget {
  const NavigatorS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 600,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF2c595b),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '5',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: const Text(
                      "DIOS",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  )
              )
            ),
          ],
        ),
      ),
    );
  }
}

