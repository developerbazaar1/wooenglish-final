import 'package:get/get.dart';

import '../controllers/author_list_controller.dart';

class AuthorListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorListController>(
      () => AuthorListController(),
    );
  }
}
