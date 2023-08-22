import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/user_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/firebase/firebase_login_method.dart';

class VerificationController extends AppController {
  final count = 0.obs;
  final absorbing = false.obs;
  final isVerifyButtonClicked = false.obs;
  String verificationId = "";
  final otpController = TextEditingController();
  String userId = Get.arguments[0] ?? "";
  String otp = Get.arguments[1] ?? "";
  String number = Get.arguments[2] ?? "";
  String email = Get.arguments[3] ?? "";
  String countryCode = Get.arguments[4] ?? "";
  Map<String, dynamic> bodyParamsForVerification = {};
  Map<String, dynamic> responseMapForVerification = {};
  UserData? getUserDataModel;
  Map<String, dynamic> bodyParamsForLogin = {};
  Map<String, dynamic> responseMapForLogin = {};
  final secondsRemaining = 30.obs;
  final enableResend = false.obs;
  late Timer timer;

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.verification;
    timerMethod();
    await sendOtpRequest();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void onClose() {
    super.onClose();
    dispose();
  }

  void increment() => count.value++;

  void timerMethod() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (secondsRemaining.value != 0) {
          secondsRemaining.value--;
        } else {
          enableResend.value = true;
        }
      },
    );
  }

  Future<bool> verificationApiCalling() async {
    if (email.isNotEmpty) {
      bodyParamsForVerification = {
        ApiKey.user_id: userId,
        ApiKey.otp: otp,
        ApiKey.isRequired: "1",
        ApiKey.email: email,
        ApiKey.countryCode: countryCode,
      };
    } else {
      bodyParamsForVerification = {
        ApiKey.user_id: userId,
        ApiKey.otp: otp,
        ApiKey.isRequired: "0",
        ApiKey.countryCode: countryCode,
      };
    }

    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointMatchOtp,
        bodyParams: bodyParamsForVerification);
    if (CM.responseCheckForPostMethod(response: response)) {
      getUserDataModel = UserData.fromJson(jsonDecode(response?.body ?? ""));
      await CM.insertDataIntoDataBase(userData: getUserDataModel);
      bodyParamsForVerification.clear();
      return true;
    } else {
      bodyParamsForVerification.clear();
      return false;
    }
  }

  Future<bool> loginApiCalling() async {
    bodyParamsForLogin = {
      ApiKey.mobile: number,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointLogin, bodyParams: bodyParamsForLogin);
    if (CM.responseCheckForPostMethod(response: response)) {
      responseMapForLogin = jsonDecode(response!.body);
      userId = responseMapForLogin[ApiKey.user_id];
      otp = responseMapForLogin[ApiKey.otp].toString();
      bodyParamsForLogin.clear();
      return true;
    } else {
      bodyParamsForLogin.clear();
      return false;
    }
  }

  Future<void> sendOtpRequest() async {
    await FirebaseMethod.instance.sendOtpRequest(
      number: "$countryCode $number",
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId = verificationId;
      },
    );
  }

  Future<bool> matchOtpRequest() async {
    return await FirebaseMethod.instance.verifyOtpRequest(
        verificationId: verificationId, smsCode: otpController.text);
  }

  Future<void> clickOnResendOtpButton() async {
    timer.cancel();
    secondsRemaining.value = 30;
    timerMethod();
    enableResend.value = false;
    CM.unFocsKeyBoard();
    absorbing.value = true;
    try {
      if (await loginApiCalling()) {
        await sendOtpRequest();
      }
    } catch (e) {
      absorbing.value = false;
      CM.error();
    }
    absorbing.value = false;
  }

  Future<void> clickOnVerifyButton() async {
    CM.unFocsKeyBoard();
    absorbing.value = true;
    isVerifyButtonClicked.value = true;
    if (otpController.text.isNotEmpty && otpController.text.length == 6) {
      try {
        if (await matchOtpRequest()) {
          if (await verificationApiCalling()) {
            await insertIntoDataBase();
            if (!await FirebaseMethod.instance.getDynamicLink()) {
              selectedViewIndex.value = 0;
              await Get.offAllNamed(Routes.NAVIGATOR);
            }
          }
        }
      } catch (e) {
        absorbing.value = false;
        CM.error();
      }
    } else if (otpController.text.isEmpty) {
      CM.showToast("Please enter Otp!");
    } else {
      CM.showToast("Please enter valid Otp!");
    }
    isVerifyButtonClicked.value = false;
    absorbing.value = false;
  }

  Future<bool> insertIntoDataBase() async {
    if (await DatabaseHelper.databaseHelperInstance.isDatabaseHaveData(
        db: DatabaseHelper.db, tableName: DatabaseConst.tableNameUserLogin)) {
      bool isInsert = await DatabaseHelper.databaseHelperInstance.insert(
        db: DatabaseHelper.db,
        tableName: DatabaseConst.tableNameUserLogin,
        data: {DatabaseConst.columIsLogIn: "1"},
      );
      return isInsert;
    }
    return false;
  }
}
