
import '../../auth/model/register_response_model.dart';
import '../../dashboard/model/offline_test_model.dart';

class PrefModel {
  UserData? userData;
  List<OfflineTestModel>? offlineSavedTests;

  PrefModel({
    this.userData,
    this.offlineSavedTests,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
      userData: parsedJson["userData"] == null
          ? null
          : UserData.fromJson(parsedJson["userData"]),
      offlineSavedTests: parsedJson["offlineSavedTests"] == null ? [] : List<OfflineTestModel>.from(parsedJson["offlineSavedTests"].map((x) => OfflineTestModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userData": userData?.toJson(),
      "offlineSavedTests": offlineSavedTests == null ? [] : List<dynamic>.from(offlineSavedTests!.map((x) => x.toJson())),
    };
  }
}
