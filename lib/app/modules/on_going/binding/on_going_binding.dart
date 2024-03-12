import 'package:get/get.dart';


import '../controllers/on_going_controller.dart';

class OnGoingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnGoingController>(
          () => OnGoingController(),
    );
  }
}
