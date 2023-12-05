import 'package:flutter/material.dart';
import 'package:giusseppe_flut/service/connectivity_manager_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 1); // Adjust the height

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<bool>(
          stream: ConnectivityManagerService().connectionStatus,
          initialData: ConnectivityManagerService().connectivity,
          builder: (context, snapshot) {
            bool isConnected = snapshot.data ?? false;
            return AppBar(
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
              actions: [
                Visibility(
                  visible: !isConnected,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wifi_off,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'NoWiFi',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const Divider(
          height: 1, // Adjust the height of the line
          color: Colors.grey, // Set the color of the line
        ),
      ],
    );
  }
}