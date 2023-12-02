import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1); // Adjust the height

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: const Text(
            'Senehouse',
            style: TextStyle(
              color: Color(0xFF2C595B),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF2C595B),
          ),
          centerTitle: true,
        ),
        const Divider(
          height: 1, // Adjust the height of the line
          color: Colors.grey, // Set the color of the line
        ),
      ],
    );
  }
}