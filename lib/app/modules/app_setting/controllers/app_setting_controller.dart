import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

class AppSettingController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  final notificationValue = false.obs;
  final modeValue = false.obs;
  final applicationUpdateValue = false.obs;
  Map<String, dynamic> queryParametersForNotificationOnOff = {};
  Map<String, dynamic> queryParametersForAppUpdateOnOff = {};
  Map<String, dynamic> queryParametersForDarkModeOnOff = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.appSettings;

    inAsyncCall.value = true;
    notificationValue.value = await DatabaseHelper.databaseHelperInstance
            .getParticularData(key: DatabaseConst.columnNotificationOnOff) ==
        "1";
    applicationUpdateValue.value = await DatabaseHelper.databaseHelperInstance
            .getParticularData(key: DatabaseConst.columnAppUpdateOnOff) ==
        "1";
    modeValue.value = await DatabaseHelper.databaseHelperInstance
            .getParticularData(key: DatabaseConst.columnMode) ==
        "1";
    inAsyncCall.value = false;
    onReload();
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

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod() &&
          load == 0 &&
          screens == Screens.appSettings) {
        load++;
        await onInit();
      } else {
        load = 0;
      }
    });
  }

  Future<void> onRefresh() async {
    await onInit();
  }

  Future<bool> notificationOnOffApiCalling() async {
    if (await CM.internetConnectionCheckerMethod()) {
      queryParametersForNotificationOnOff = {
        ApiKey.notification: notificationValue.value ? "0" : "1",
      };
      http.Response? response = await HttpMethod.instance.getRequestForParams(
          queryParameters: queryParametersForNotificationOnOff,
          baseUriForParams: UriConstant.baseUriForParams,
          endPointUri: UriConstant.endPointNotificationOnOff);
      if (CM.responseCheckForPostMethod(response: response)) {
        queryParametersForNotificationOnOff.clear();
        return true;
      } else {
        queryParametersForNotificationOnOff.clear();
        return false;
      }
    } else {
      CM.noInternet();
      return false;
    }
  }

  Future<bool> appUpdateOnOffApiCalling() async {
    if (await CM.internetConnectionCheckerMethod()) {
      queryParametersForAppUpdateOnOff = {
        ApiKey.appUpdate: applicationUpdateValue.value ? "0" : "1",
      };
      http.Response? response = await HttpMethod.instance.getRequestForParams(
          baseUriForParams: UriConstant.baseUriForParams,
          endPointUri: UriConstant.endPointAppUpdateOnOff,
          queryParameters: queryParametersForAppUpdateOnOff);
      if (CM.responseCheckForPostMethod(response: response)) {
        queryParametersForAppUpdateOnOff.clear();
        return true;
      } else {
        queryParametersForAppUpdateOnOff.clear();
        return false;
      }
    } else {
      queryParametersForAppUpdateOnOff.clear();
      return false;
    }
  }

  Future<bool> darkModeOnOffApiCalling() async {
    if (await CM.internetConnectionCheckerMethod()) {
      queryParametersForDarkModeOnOff = {
        ApiKey.mode: modeValue.value ? "0" : "1",
      };
      http.Response? response = await HttpMethod.instance.getRequestForParams(
          baseUriForParams: UriConstant.baseUriForParams,
          endPointUri: UriConstant.endPointDarkModeOnOff,
          queryParameters: queryParametersForDarkModeOnOff);
      if (CM.responseCheckForPostMethod(response: response)) {
        queryParametersForDarkModeOnOff.clear();
        return true;
      } else {
        queryParametersForDarkModeOnOff.clear();
        return false;
      }
    } else {
      queryParametersForDarkModeOnOff.clear();
      return false;
    }
  }

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> notificationOnChange({required bool value}) async {
    inAsyncCall.value = true;
    try{
      if (await notificationOnOffApiCalling()) {
        DatabaseHelper.databaseHelperInstance.updateParticularData(
            key: DatabaseConst.columnNotificationOnOff,
            val: notificationValue.value ? "0" : "1");
        notificationValue.value = value;
      }
    }catch (e) {
      CM.error();
      inAsyncCall.value = false;
    }

    inAsyncCall.value = false;
  }

  Future<void> modeOnChange({required bool value}) async {
    inAsyncCall.value = true;
    try {
      if (await darkModeOnOffApiCalling()) {
        DatabaseHelper.databaseHelperInstance.updateParticularData(
            key: DatabaseConst.columnMode, val: modeValue.value ? "0" : "1");
        modeValue.value = value;
      }
    } catch (e) {
      CM.error();
      inAsyncCall.value = false;
    }
    inAsyncCall.value = false;

  }

  Future<void> applicationUpdateOnChange({required bool value}) async {
    inAsyncCall.value = true;
   try{
     if (await notificationOnOffApiCalling()) {
       DatabaseHelper.databaseHelperInstance.updateParticularData(
           key: DatabaseConst.columnAppUpdateOnOff,
           val: applicationUpdateValue.value ? "0" : "1");

       applicationUpdateValue.value = value;
     }
   }catch (e) {
     CM.error();
     inAsyncCall.value = false;
   }
    inAsyncCall.value = false;
  }
}
