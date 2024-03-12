// @dart=2.12
import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/theme/theme_data/theme_data.dart';
import 'package:woo_english/firebase/firebase_messaging.dart';
import 'package:woo_english/firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/constants/constants.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool initializeNotification = false;

Future<void> main() async {
  Stripe.publishableKey = C.stripePublicKey;

  print(C.stripePublicKey);

  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  await Firebase.initializeApp(


    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  Future<Directory?>? _tempDirectory;
  Future<Directory?>? _appSupportDirectory;
  Future<Directory?>? _appLibraryDirectory;
  Future<Directory?>? _appDocumentsDirectory;
  Future<Directory?>? _appCacheDirectory;
  Future<Directory?>? _externalDocumentsDirectory;
  Future<List<Directory>?>? _externalStorageDirectories;
  Future<List<Directory>?>? _externalCacheDirectories;
  Future<Directory?>? _downloadsDirectory;

  late StreamSubscription streamSubscription;
  AppController().getNetworkConnectionType();
  streamSubscription = AppController().checkNetworkConnection();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await DatabaseHelper.databaseHelperInstance.openDB();
    clearAppDataOnInstall();

    runApp(GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppThemeData.themeDataLight(),
    ));
  });
}

Future<void> clearAppDataOnInstall() async {
  Future<Directory?>? _tempDirectory;
  Future<Directory?>? _appSupportDirectory;
  Future<Directory?>? _appLibraryDirectory;
  Future<Directory?>? _appDocumentsDirectory;
  Future<Directory?>? _appCacheDirectory;
  Future<Directory?>? _externalDocumentsDirectory;
  Future<List<Directory>?>? _externalStorageDirectories;
  Future<List<Directory>?>? _externalCacheDirectories;
  Future<Directory?>? _downloadsDirectory;
  try {
    // Get the application documents directory
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Replace 'your_folder_name' with the actual folder name where your data is stored
    String folderPath = appDocDir.path;
    _tempDirectory = getTemporaryDirectory();
    _appSupportDirectory = getApplicationSupportDirectory();

    _appCacheDirectory = getApplicationCacheDirectory();
    _externalDocumentsDirectory = getExternalStorageDirectory();
    _externalCacheDirectories = getExternalCacheDirectories();
    _downloadsDirectory = getDownloadsDirectory();

    // Check if the folder exists
    if (await Directory(folderPath).exists()) {
      // Delete the folder and its content
      await Directory(folderPath).delete(recursive: true);
    }

    // Add additional code to clear other data if necessary
  } catch (e) {
    print('Error clearing app data: $e');
  }
}
