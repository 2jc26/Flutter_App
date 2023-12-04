import 'package:flutter/foundation.dart';

import '../../enum/feature_enum.dart';
import '../../service/backend_service.dart';
import 'package:intl/intl.dart';
class FeatureDaoFireStore{

  @override
  Future<void> addUse(Feature type) async {
    try {
      String tipo = type
          .toString()
          .split('.')
          .last;
      DateTime now = DateTime.now();
      int milliseconds = now.millisecondsSinceEpoch;
      BackendService().post("features/post", {"type": tipo, "date": milliseconds});
    } catch (error) {
      if (kDebugMode) {
        print("Error creation feature: $error");
      }
      rethrow;
    }
  }
}