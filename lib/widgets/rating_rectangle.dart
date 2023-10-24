import 'package:flutter/material.dart';

class RatingRectangle extends StatelessWidget {
  final String imageUrl;
  final double rating;

  RatingRectangle({
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.tertiary),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < 5; i++)
                Icon(
                  i < rating.floor() ? Icons.star : Icons.star_border,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
            ],
          ),
        ],
      ),
    );
  }
}