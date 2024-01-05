import 'package:get/get.dart';

import '../controllers/video_book_controller.dart';

class VideoBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoBookController>(
      () => VideoBookController(),
    );
  }
}
