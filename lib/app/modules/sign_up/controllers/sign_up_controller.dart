import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_country_bottomsheet/common_country_bottomsheet.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/countries/countries_json_data.dart';
import 'package:woo_english/app/data/countries/get_countries_model.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class SignUpController extends AppController {
  final count = 0.obs;
  final absorbing = false.obs;
  final formKey = GlobalKey<FormState>();
  final isSignUpButtonClicked = false.obs;
  final nameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final emailAddressController = TextEditingController();
  final countryCodeController = TextEditingController();
  Map<String, dynamic> bodyParamsForRegistration = {};
  Map<String, dynamic> responseMapForRegistration = {};
  String otp = "";
  String userId = "";
  String countyCode = "";
  GetCountriesModel? getCountriesModel;

  @override
  void onInit() {
    super.onInit();
    screens = Screens.signUp;
    String countriesJson = jsonEncode(countryData);
    getCountriesModel = GetCountriesModel.fromJson(jsonDecode(countriesJson));
    countryCodeController.text = "+91";
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

  Future<bool> registrationApiCalling() async {
    bodyParamsForRegistration = {
      ApiKey.name: nameController.text,
      ApiKey.mobile: mobileNumberController.text,
      ApiKey.email: emailAddressController.text,
      ApiKey.deviceType: CM.getDeviceType(),
      ApiKey.countryCode: countyCode,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointRegistration,
        bodyParams: bodyParamsForRegistration);
    if (CM.responseCheckForPostMethod(response: response)) {
      responseMapForRegistration = jsonDecode(response!.body);
      userId = responseMapForRegistration[ApiKey.user_id];
      otp = responseMapForRegistration[ApiKey.otp].toString();
      bodyParamsForRegistration.clear();
      return true;
    } else {
      bodyParamsForRegistration.clear();
      return false;
    }
  }

  Future<void> clickOnSignUpButton() async {
    CM.unFocsKeyBoard();
    absorbing.value = true;
    isSignUpButtonClicked.value = true;
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
        if (await registrationApiCalling()) {
          Get.toNamed(Routes.VERIFICATION, arguments: [
            userId,
            otp,
            mobileNumberController.text.trim().toString(),
            emailAddressController.text.trim().toString(),
            countyCode
          ]);
        }
      } catch (e) {
        isSignUpButtonClicked.value = false;
        absorbing.value = false;
        CM.error();
      }
    }
    isSignUpButtonClicked.value = false;
    absorbing.value = false;
  }

  void clickOnSignInButton() {
    CM.unFocsKeyBoard();
    absorbing.value = true;
    Get.back();
    absorbing.value = false;
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
            countryCodeController.text =
                "${getCountriesModel!.country![index].idd!.root}${getCountriesModel!.country![index].idd!.suffixes![0]}";
          },
        );
      },
    );
  }
}
