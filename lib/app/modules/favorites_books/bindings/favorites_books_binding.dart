import 'package:get/get.dart';

import '../controllers/favorites_books_controller.dart';

class FavoritesBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoritesBooksController>(
      () => FavoritesBooksController(),
    );
  }
}
