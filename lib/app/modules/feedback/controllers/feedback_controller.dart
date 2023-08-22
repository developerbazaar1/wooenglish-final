import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:http/http.dart' as http;

import '../../navigator/controllers/navigator_controller.dart';
class FeedbackController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  Map<String, dynamic> bodyParamsForFeedbackApi = {};
  TextEditingController writeSomethingController = TextEditingController();

  @override
  void onInit() {
    screens = Screens.feedBack;
    super.onInit();
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

  Future<bool> feedBackApiCalling() async {
    bodyParamsForFeedbackApi = {
      ApiKey.msg: writeSomethingController.text,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointFeedback,
        bodyParams: bodyParamsForFeedbackApi);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForFeedbackApi.clear();
      return true;
    } else {
      bodyParamsForFeedbackApi.clear();
      return false;
    }
  }

  void clickOnBackButton() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnSubmitButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    if (writeSomethingController.text.isNotEmpty) {
      await feedBackApiCalling();
      writeSomethingController.text="";
    } else {
      CM.showToast("Please write something!");
    }
    inAsyncCall.value = false;
  }
}
