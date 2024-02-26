import 'package:get/get.dart';

import '../controllers/search_suggestion_list_controller.dart';

class SearchSuggestionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchSuggestionListController>(
      () => SearchSuggestionListController(),
    );
  }
}
