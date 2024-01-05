import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:http/http.dart' as http;

class OnBoardingController extends AppController {
  final count = 0.obs;
  int load = 0;
  PageController pageController = PageController();
  final selectedIndex = 0.obs;
  final inAsyncCall = false.obs;
  final responseCode = 0.obs;
  GetDashBoardBooksModel? getDashBoardBooksModel;
  List<Pages> pages = [];

  List<String> imageList = [
    C.imageOnBoardingOne,
    C.imageOnBoardingTwo,
    C.imageOnBoardingThree
  ];
  List<String> titleTextList = [
    C.textOnBoardingOneTitle,
    C.textOnBoardingTwoTitle,
    C.textOnBoardingThreeTitle
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        await getInFoPageApiCalling();
      } catch (e) {
        inAsyncCall.value = false;
      }
    }
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

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod() && load == 0) {
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

  void increment() => count.value++;

  Future<void> getInFoPageApiCalling() async {
    http.Response? response = await HttpMethod.instance.getRequest(
      url: UriConstant.endPointGetInfoPages,
    );
    responseCode.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      getDashBoardBooksModel =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDashBoardBooksModel != null &&
          getDashBoardBooksModel?.pages != null &&
          getDashBoardBooksModel!.pages!.isNotEmpty) {
        pages = getDashBoardBooksModel?.pages ?? [];
      }
    }
  }

  Future<void> clickOnNextButton() async {
    {
      if (selectedIndex.value != 2) {
        pageController.jumpToPage(selectedIndex.value + 1);
      } else {
        await Get.offAllNamed(Routes.SIGN_IN);
      }
    }
  }

  Future<void> clickOnSkipButton() async {
    await Get.offAllNamed(Routes.SIGN_IN);
  }
}
