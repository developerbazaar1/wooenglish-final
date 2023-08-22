import 'package:get/get.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';

class CongratulationController extends GetxController {
  final count = 0.obs;
  final inAsyncCall=false.obs;

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

  void clickOnBackToHomeButton() {
    selectedViewIndex.value=0;
    inAsyncCall.value=true;
    Get.offAllNamed(Routes.NAVIGATOR);
    inAsyncCall.value=false;
  }

}
