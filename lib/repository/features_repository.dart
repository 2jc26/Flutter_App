import '../enum/feature_enum.dart';
import '../service/connectivity_manager_service.dart';
import '../service_adapter/features/service_adapter_features.dart';


class FeatureRepository {
  FeatureDaoFireStore featureDaoFireStore = FeatureDaoFireStore();
  bool connectivity = ConnectivityManagerService().connectivity;

  Future<void> createFeature( Feature type) async {
    try {
      if(connectivity) {
        featureDaoFireStore.addUse(type);
      } else {
        print("No se logro");
      }
    } catch (error) {
      rethrow;
    }
  }

}