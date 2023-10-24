import 'dart:typed_data';

import 'package:flutter/material.dart';

class InformationCardUser extends StatelessWidget {
  const InformationCardUser({super.key, required this.getImageURL, required this.stars, required this.text});

  final Future<Uint8List?> Function() getImageURL;
  final int stars;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Card(
        color: const Color(0xFF2C595B),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            FutureBuilder<Uint8List?>(
              future: getImageURL(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Muestra un indicador de carga mientras se carga la imagen.
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  );
                } else {
                  return Text('No image available'); // Mostrar algo si no hay imagen.
                }
              },
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
                          if (index >= stars) {
                            return const Icon(
                              Icons.star_border,
                              color: Color.fromARGB(255, 48, 48, 48),
                              size: 24,
                            );
                          } else {
                            return const Icon(
                              Icons.star,
                              color: Color(0xFFEDF9B9),
                              size: 24,
                            );
                          }
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: const TextStyle(
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