import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/user_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_country_bottomsheet/common_country_bottomsheet.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/countries/countries_json_data.dart';
import 'package:woo_english/app/data/countries/get_countries_model.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/firebase/firebase_login_method.dart';
import 'package:woo_english/firebase/firebase_user_model.dart';

import '../../../theme/constants/constants.dart';

class SignInController extends AppController {
  final count = 0.obs;
  final absorbing = false.obs;
  final formKey = GlobalKey<FormState>();
  final mobileNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  final isOtpButtonClicked = false.obs;
  Map<String, dynamic> bodyParamsForLogin = {};
  Map<String, dynamic> responseMapForLogin = {};
  String otp = "";
  String userId = "";
  String countyCode = "";
  UserData? getUserDataModel;
  FirebaseUser? firebaseUser;
  Map<String, dynamic> bodyParamsForSos = {};
  GetCountriesModel? getCountriesModel;
  final countyLogo = "".obs;


  @override
  void onInit() {
    screens = Screens.signIn;
    super.onInit();
    String countriesJson = jsonEncode(countryData);
    countryCodeController.text = "+91";

    getCountriesModel = GetCountriesModel.fromJson(jsonDecode(countriesJson));
    getCountriesModel?.country?.forEach((element) {
      if (element.idd!.suffixes!.isNotEmpty) {
        if ("${element.idd!.root}${element.idd!.suffixes![0]}" ==
            countryCodeController.text) {
          countyLogo.value = element.flags?.png ?? "";
        }
      } else {
        if ("${element.idd!.root}" == countryCodeController.text) {
          countyLogo.value = element.flags?.png ?? "";
        }
      }
    });
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

  Future<bool> loginApiCalling() async {
    bodyParamsForLogin = {
      ApiKey.mobile: mobileNumberController.text,
      ApiKey.countryCode: countyCode,
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

  Future<bool> sosApiCalling({required String provider}) async {
    bodyParamsForSos = {
      ApiKey.deviceType: CM.getDeviceType(),
      ApiKey.email: firebaseUser?.email ?? "",
      ApiKey.name: firebaseUser?.displayName ?? "",
      ApiKey.provider: provider,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointSsoLogin, bodyParams: bodyParamsForSos);
    if (CM.responseCheckForPostMethod(response: response)) {
      getUserDataModel = UserData.fromJson(jsonDecode(response?.body ?? ""));
      await CM.insertDataIntoDataBase(userData: getUserDataModel);
      bodyParamsForSos.clear();
      return true;
    } else {
      bodyParamsForSos.clear();
      return false;
    }
  }

  Future<void> clickOnGetOtpButton() async {
    selectedViewIndex.value = 0;
    CM.unFocsKeyBoard();
    absorbing.value = true;
    isOtpButtonClicked.value = true;
    if (countryCodeController.text.trim().toString().isNotEmpty) {
      if (!(countryCodeController.text.trim().toString()[0] == "+")) {
        countyCode = "+${countryCodeController.text.trim().toString()}";
      } else {
        countyCode = countryCodeController.text.trim().toString();
      }
    } else {
      countyCode = C.textDefaultCountryCode;
    }
    if (formKey.currentState!.validate()) {
      try {
        if (await loginApiCalling()) {
          Get.toNamed(Routes.VERIFICATION, arguments: [
            userId,
            otp,
            mobileNumberController.text,
            "",
            countyCode
          ]);
        }
      } catch (e) {
        isOtpButtonClicked.value = false;
        absorbing.value = false;
        CM.error();
      }
    }
    isOtpButtonClicked.value = false;
    absorbing.value = false;
  }

  void clickOnFacebookButton() {
    selectedViewIndex.value = 0;
    CM.unFocsKeyBoard();
    absorbing.value = true;
/*
    FirebaseMethod.instance.facebookSigningRequest();
*/
    absorbing.value = false;
  }

  Future<void> clickOnGoogleButton() async {
    selectedViewIndex.value = 0;
    CM.unFocsKeyBoard();
    absorbing.value = true;
    try {
      firebaseUser = await FirebaseMethod.instance.googleSignInRequest();
      if (firebaseUser != null) {
        if (await sosApiCalling(provider: ApiKey.google)) {
          await insertIntoDataBase();
          if (!await FirebaseMethod.instance.getDynamicLink()) {
            await Get.offAllNamed(Routes.NAVIGATOR);
          } else {
            absorbing.value = false;
            CM.error();
          }
        } else {
          absorbing.value = false;
          CM.error();
        }
      } else {
        absorbing.value = false;
        CM.error();
      }
    } catch (e) {
      absorbing.value = false;
      CM.error();
    }
  }

  void clickOnSignUpButton() {
    CM.unFocsKeyBoard();
    absorbing.value = true;
    Get.toNamed(Routes.SIGN_UP);
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

  void clickOnCountryCode() {
    showModalBottomSheet(
      context: Get.context!,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.px),
          topRight: Radius.circular(25.px),
        ),
      ),
      backgroundColor: Col.scaffoldBackgroundColor,
      builder: (context) {
        return CB(
          getCountriesModel: getCountriesModel,
          indexValue: (index) {
            Get.back();
            if (getCountriesModel!.country![index].idd!.suffixes!.isNotEmpty) {
              countryCodeController.text =
              "${getCountriesModel!.country![index].idd!.root}${getCountriesModel!.country![index].idd!.suffixes![0]}";
            } else {
              countryCodeController.text =
              "${getCountriesModel!.country![index].idd!.root}";
            }
            countyLogo.value = getCountriesModel!.country![index].flags?.png ?? "";  },
        );
      },
    );
  }
}
