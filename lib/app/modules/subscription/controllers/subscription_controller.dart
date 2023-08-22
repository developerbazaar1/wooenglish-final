import 'package:get/get.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/routes/app_pages.dart';

class SubscriptionController extends AppController {

  final count = 0.obs;
  final inAsyncCall=false.obs;
  final currentIndexOfIncludePlan = [-1,-1,-1,-1].obs;
  final currentIndexOfPlan=Rxn<int>();



  @override
  void onInit() {
    super.onInit();
    currentIndexOfPlan.value=-1;
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

  onReload(){
    connectivity.onConnectivityChanged.listen((event) async {
      if(await CM.internetConnectionCheckerMethod())
      {
        onInit();
      }
      else
      {

      }
    });
  }


  void increment() => count.value++;

  void clickOnBackButton() {
    inAsyncCall.value=true;
    Get.back();
    inAsyncCall.value=false;
  }

  void clickOnParticularPlan({required int index}) {
    inAsyncCall.value=true;
    if (currentIndexOfPlan.value == index) {
      currentIndexOfPlan.value = -1;
    } else {
      currentIndexOfPlan.value = index;
    }
    inAsyncCall.value=false;
  }

  void clickOnSubscriptionButton() {
    inAsyncCall.value=true;
    Get.toNamed(Routes.PAYMENT);
    inAsyncCall.value=false;
  }

}
