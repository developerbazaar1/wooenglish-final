import 'dart:io';
// @dart=2.9
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/firebase/firebase_login_method.dart';
String token = "";
String isUserLogin = "";
var isUserSubscribed ;
var popupvalue;
var isAudioPlaying;
class SplashController extends GetxController {
  final count = 0.obs;




  @override
  Future<void> onInit() async {
    super.onInit();

    isUserLogin = await DatabaseHelper.databaseHelperInstance.getParticularData(
        key: DatabaseConst.columIsLogIn,
        tableName: DatabaseConst.tableNameUserLogin);

    token = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnToken);
    await Future.delayed(const Duration(seconds: 2));
    await manageSession();



  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  void increment() => count.value++;

  Future<void> manageSession() async {
    if (isUserLogin.isEmpty) {
      await Get.offAllNamed(Routes.ON_BOARDING);
    } else {
      if (token.isNotEmpty) {
        if(!await FirebaseMethod.instance.getDynamicLink()) {
          await Get.offAllNamed(Routes.NAVIGATOR);
        }
      } else {
        await Get.offNamed(Routes.SIGN_IN);
      }
    }
  }
}
