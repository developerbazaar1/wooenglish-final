import 'package:get/get.dart';
import 'package:woo_english/app/modules/home/controllers/home_controller.dart';
import 'package:woo_english/app/modules/my_books/controllers/my_books_controller.dart';
import 'package:woo_english/app/modules/my_profile/controllers/my_profile_controller.dart';
import 'package:woo_english/app/modules/search_screen/controllers/search_screen_controller.dart';

import '../controllers/navigator_controller.dart';

class NavigatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigatorController>(
      () => NavigatorController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<SearchScreenController>(
          () => SearchScreenController(),
    );
    Get.lazyPut<MyBooksController>(
          () => MyBooksController(),
    );
    Get.lazyPut<MyProfileController>(
          () => MyProfileController(),
    );
  }
}
