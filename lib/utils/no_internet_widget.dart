import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'app_buttons.dart';
import 'app_locale.dart';

class NoInternetWidget extends StatefulWidget {
  const NoInternetWidget({super.key});

  @override
  State<NoInternetWidget> createState() => _NoInternetWidgetState();
}

class _NoInternetWidgetState extends State<NoInternetWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        List<ConnectivityResult> connectivityResults =
            await Connectivity().checkConnectivity();
        bool isConnected = connectivityResults.any((result) =>
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi);
        if (isConnected) {
          return true;
        } else {
          showErrorToast(context, "No Internet Connection! Retry failed");
          return false;
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                "No Internet",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Please check your internet\n connection and try again.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
              ),
              ElevatedButton(
                onPressed: () async {
                  List<ConnectivityResult> connectivityResults =
                      await Connectivity().checkConnectivity();
                  bool isConnected = connectivityResults.any((result) =>
                      result == ConnectivityResult.mobile ||
                      result == ConnectivityResult.wifi);
                  if (isConnected) {
                    Navigator.pop(context);
                  } else {
                    showErrorToast(
                        context, "No Internet Connection! Retry failed");
                  }
                },
                child: const Text("Retry"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
