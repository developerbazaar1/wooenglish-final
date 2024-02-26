import 'package:get/get.dart';

import '../controller/my_subcription_plan_controller.dart';



class MyPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySubscriptionController>(
          () => MySubscriptionController(),
    );
  }
}