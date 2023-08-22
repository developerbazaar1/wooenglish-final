import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/routes/app_pages.dart';

class PaymentController extends GetxController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final formKey=GlobalKey<FormState>();
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardExpiryDateController = TextEditingController();
  final cardCvvCodeController = TextEditingController();

  @override
  void onInit() {
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

  void clickOnBackButton() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  void clickOnVisaLogo() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnPayPalLogo() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnMasterLogo() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnPaymentButton() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    if(formKey.currentState!.validate())
      {
        Get.toNamed(Routes.CONGRATULATION);
      }
    inAsyncCall.value = false;
  }
}
