import 'package:flutter/material.dart';

class MyScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                color: const Color(0xff7c94b6),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://fs-prod-cdn.nintendo-europe.com/media/images/10_share_images/portals_3/2x1_SuperMarioHub.jpg'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  width: 10,
                ),
                borderRadius: BorderRadius.circular(12),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Text('Box 1', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Text('Box 2', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Text('Box 3', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Text('Box 1', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Text('Box 2', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Text('Box 3', textAlign: TextAlign.center),
                        ),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7), // Color de la sombre
                                spreadRadius: 5, // Extension de la sombre
                                blurRadius: 7, // Desensitises de la sombre
                                offset: const Offset(0, 3), // Despoilment de la sombre
                              ),
                            ],
                          ),
                          child: const Text('Box 1', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Text('Box 2', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Text('Box 3', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Text('Box 1', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Text('Box 2', textAlign: TextAlign.center),
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Text('Box 3', textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}