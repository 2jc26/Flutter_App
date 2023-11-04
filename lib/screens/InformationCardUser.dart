import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../storage/storage_adapters/custom_cache_manager.dart';

class InformationCardUser extends StatelessWidget {
  const  InformationCardUser({super.key, required this.url, required this.stars, required this.text});

  final String url;
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
            CachedNetworkImage(
              imageUrl: url,
              cacheManager: CustomCacheManager().getCacheManager(),
              height:150,
              fit: BoxFit.cover,
              width: 350,
              memCacheWidth: 350,
              memCacheHeight: 150,
              progressIndicatorBuilder: (context, url,progress) {
                return ColoredBox(
                    color: Colors.black,
                    child:Center(child: CircularProgressIndicator(value: progress.progress))
                );
              },
              errorWidget: (context,url,error){
                if (error is SocketException) {
                  return const Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Column(
                              children: [
                                Icon(
                                  Icons.error,
                                  size: 48.0,
                                  color: Colors.blue,
                                ),
                                Text(
                                  '¡Vaya! No tienes internet.',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16.0,),
                                ),
                              ],
                            )
                          );
                } else {
                  return const Padding(
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.error,
                            size: 48.0,
                            color: Colors.blue,
                          ),
                          Text(
                            '¡Vaya!Algo salió mal al cargar la imagen',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,),
                          ),
                        ],
                      )
                  );
                }
              }
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