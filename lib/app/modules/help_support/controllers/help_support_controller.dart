import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

class HelpSupportController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  Map<String, dynamic> bodyParamsForHelpAndSupport = {};
  TextEditingController writeSomethingController = TextEditingController();

  @override
  void onInit() {
    screens = Screens.favoriteBooks;
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

  Future<bool> helpAndSupportApiCalling() async {
    bodyParamsForHelpAndSupport = {
      ApiKey.msg: writeSomethingController.text,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointHelpAndSupport,
        bodyParams: bodyParamsForHelpAndSupport);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForHelpAndSupport.clear();
      return true;
    } else {
      bodyParamsForHelpAndSupport.clear();
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
    if (writeSomethingController.text.trim().isNotEmpty) {
       try{
         await helpAndSupportApiCalling();
         writeSomethingController.text="";
       }catch (e) {
         CM.error();
         inAsyncCall.value = false;
       }
    } else {
      CM.showToast("Please write something!");
    }
    inAsyncCall.value = false;
  }
}
