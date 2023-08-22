import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

class AppController extends GetxController {

  static final isConnect = false.obs;
  Screens screens=Screens.home;
  static String routes="";
  final Connectivity connectivity = Connectivity();


  Future<void> getNetworkConnectionType() async {
    try {
      ConnectivityResult connectivityResult;
      connectivityResult = await connectivity.checkConnectivity();
      return updateConnectionState(connectivityResult);

    } on PlatformException catch (e) {
      CM.error();
    }
  }

  StreamSubscription checkNetworkConnection() {
    final networkConnection = false.obs;
    return connectivity.onConnectivityChanged.listen((event) async {
      networkConnection.value = await CM.internetConnectionCheckerMethod();
      if (networkConnection.value) {
        isConnect.value = true;
      } else {
        isConnect.value = false;
        CM.showToast(
          "Check your internet connection!",
        );
      }
      return updateConnectionState(event);
    });

  }

  void updateConnectionState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        update();
        break;
      case ConnectivityResult.mobile:
        update();
        break;
      case ConnectivityResult.none:
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }


}
