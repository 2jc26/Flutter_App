import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../storage/storage_adapters/custom_cache_manager.dart';

class NetworkImage extends StatelessWidget {
  
  const NetworkImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        cacheManager: CustomCacheManager().getCacheManager(),
        height: 150,
        fit: BoxFit.cover,
        width: 350,
        memCacheWidth: 350,
        memCacheHeight: 150,
        progressIndicatorBuilder: (context, url, progress) {
          return ColoredBox(
              color: Colors.black,
              child: Center(
                  child: CircularProgressIndicator(value: progress.progress)));
        },
        errorWidget: (context, url, error) {
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
                      'Oh no! There is no internet.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ));
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
                      'Oh no! Something went wrong.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ));
          }
        });
  }
}
