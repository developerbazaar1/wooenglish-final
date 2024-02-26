import 'package:get/get.dart';

import '../controllers/my_books_controller.dart';

class MyBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyBooksController>(
      () => MyBooksController(),
    );
  }
}
