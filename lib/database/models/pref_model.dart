


import '../../auth/model/register_response_model.dart';

class PrefModel {
  UserData? userData;

  PrefModel({
    this.userData,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
      userData: parsedJson["userData"] == null
          ? null
          : UserData.fromJson(parsedJson["userData"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userData": userData?.toJson(),
    };
  }
}
