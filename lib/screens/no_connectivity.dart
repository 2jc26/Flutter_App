import 'package:flutter/material.dart';
import 'package:giusseppe_flut/widgets/drawer.dart';

class NoConnectivity extends StatelessWidget {
  const NoConnectivity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2E5EAA),
          title: const Text(
            'Senehouse',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        drawer: CustomDrawer(customDrawerContext: context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.signal_wifi_off,
                size: 50,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              const Text(
                "You can't do this without connectivity",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => (),
                child: const Text("Retry"),
              ),
            ],
          ),
        ));
  }
}
