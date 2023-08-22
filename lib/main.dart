import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/theme/theme_data/theme_data.dart';
import 'package:woo_english/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();

  late StreamSubscription streamSubscription;
  AppController().getNetworkConnectionType();
  streamSubscription = AppController().checkNetworkConnection();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {

  runApp(GetMaterialApp(
    title: "Application",
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
    theme: AppThemeData.themeDataLight(),
  ));
  });
}
