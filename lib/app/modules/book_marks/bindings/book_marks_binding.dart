import 'package:get/get.dart';

import '../controllers/book_marks_controller.dart';

class BookMarksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookMarksController>(
      () => BookMarksController(),
    );
  }
}
