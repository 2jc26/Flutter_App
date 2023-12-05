import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:giusseppe_flut/widgets/cache_network_image.dart';

class InfoCard extends StatelessWidget {
  final String name;
  final double rating;
  final String address;
  final String imageUrl;
  final double imageWidth;
  final double imageHeight;
  final double padding;

  const InfoCard({
    super.key, 
    required this.name,
    required this.rating,
    required this.address,
    required this.imageUrl,
    required this.imageWidth,
    required this.imageHeight,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        width: imageWidth,
        height: imageHeight+60,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: ChNetworkImage(
                    url: imageUrl,
                    height: imageHeight,
                    width: imageWidth,
                    cacheheight: imageHeight.toInt(),
                    cachewidth: imageWidth.toInt(),
                ),
              ),
            ),
            // Información
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre y Calificación
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          '$rating',
                          style: const TextStyle(fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const Icon(Icons.star, color: Colors.black),
                      ],
                    ),
                  ],
                ),
                // Dirección
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 4.0),
                    Text(
                      address,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}