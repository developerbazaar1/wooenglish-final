// @dart=2.12
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/theme/theme_data/theme_data.dart';
import 'package:woo_english/firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/constants/constants.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool initializeNotification=false;

Future<void> main() async {

  Stripe.publishableKey = C.stripePublicKey;

  print(C.stripePublicKey);

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  MobileAds.instance.initialize();


  late StreamSubscription streamSubscription;
  AppController().getNetworkConnectionType();
  streamSubscription = AppController().checkNetworkConnection();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await DatabaseHelper.databaseHelperInstance.openDB();

       runApp(GetMaterialApp(

      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppThemeData.themeDataLight(),
    ));
  });
}
