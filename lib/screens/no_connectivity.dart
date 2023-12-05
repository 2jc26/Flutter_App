import 'package:flutter/material.dart';
import 'package:giusseppe_flut/models/houseSearch/house_searching_model_update.dart';
import 'package:giusseppe_flut/presenter/house_list_presenter.dart';
import 'package:giusseppe_flut/widgets/custom_app_bar.dart';
import 'package:giusseppe_flut/widgets/drawer.dart';

class NoConnectivity extends StatelessWidget {
  final String? userId;
  final HouseSearchingModelUpdate? houseFilters;
  final HouseListPresenter presenter;
  
  const NoConnectivity({
    super.key,
    required this.presenter,
    required this.userId,
    required this.houseFilters
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
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
                onPressed: () => presenter.refreshData(userId, houseFilters),
                child: const Text("Retry"),
              ),
            ],
          ),
        )
      );
  }
}
