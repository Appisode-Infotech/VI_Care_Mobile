


import 'package:vicare/dashboard/model/duration_response_model.dart';

import '../../auth/model/register_response_model.dart';

class PrefModel {
  UserData? userData;
  Duration? selectedDuration;

  PrefModel({
    this.userData,
    this.selectedDuration,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
      userData: parsedJson["userData"] == null
          ? null
          : UserData.fromJson(parsedJson["userData"]),
      selectedDuration: parsedJson["selectedDuration"] == null
          ? null
          : Duration.fromJson(parsedJson["selectedDuration"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userData": userData?.toJson(),
      "selectedDuration": selectedDuration?.toJson(),
    };
  }
}
