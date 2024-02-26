import 'package:get/get.dart';

import '../controllers/finished_books_controller.dart';

class FinishedBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinishedBooksController>(
      () => FinishedBooksController(),
    );
  }
}
