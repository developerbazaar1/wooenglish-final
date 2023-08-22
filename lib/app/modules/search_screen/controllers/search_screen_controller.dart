import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/book_list/controllers/book_list_controller.dart';
import 'package:woo_english/app/modules/book_list/views/book_list_view.dart';
import 'package:woo_english/app/routes/app_pages.dart';

class SearchScreenController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load=0;
  final responseCode = 0.obs;
  Map<String, dynamic> queryParametersForNewReleaseBook = {};
  final getDataNewReleaseBook = Rxn<GetDashBoardBooksModel>();
  List<Books> bookList = [];

  final responseCodeForCategory = 0.obs;
  final getDataForCategory = Rxn<GetDashBoardBooksModel>();
  List<Filters> categoryList = [];

  @override
  Future<void> onInit() async {
    super.onInit();
    if(await CM.internetConnectionCheckerMethod())
      {
        inAsyncCall.value = true;
        try{
          await getNewReleaseBookDataApiCalling();
          await getCategoryApiCalling();
        }catch (e) {
          inAsyncCall.value = false;
        }
        inAsyncCall.value = false;
      }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> onRefresh() async {
    await onInit();
  }

  void increment() => count.value++;

  Future<void> getNewReleaseBookDataApiCalling() async {
    queryParametersForNewReleaseBook = {
      ApiKey.topBooks:"1",
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetNewReleaseBooks,
        queryParameters: queryParametersForNewReleaseBook);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForNewReleaseBook.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataNewReleaseBook.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataNewReleaseBook.value?.books != null) {
        bookList = getDataNewReleaseBook.value?.books ?? [];
      }
    }
  }

  Future<void> getCategoryApiCalling() async {
    http.Response? response = await HttpMethod.instance
        .getRequest(url: UriConstant.endPointGetCategory);
    responseCodeForCategory.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataForCategory.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataForCategory.value?.category != null) {
        categoryList.clear();
        getDataForCategory.value?.category?.forEach((element) {
          categoryList.add(element);
        });
      }
    }
  }

  Future<void> clickOnSearch() async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.SEARCH_SUGGESTION_LIST);
    await onInit();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = false;
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookDetailView(
          tag: tag,
          bookId: bookList[index].id.toString(),
          isLiked: getDataNewReleaseBook.value?.favorite
              ?.contains(bookList[index].id.toString()),
          categoryId: bookList[index].category,
        ),
      ),
    );
    await Get.delete<BookDetailController>(tag: tag);
    await onInit();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBrowsText({required int index}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookListController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookListView(tag: tag, title: categoryList[index].name,categoryId:categoryList[index].id.toString()),
      ),
    );
    await Get.delete<BookListController>(tag: tag);
    await onInit();
    inAsyncCall.value = false;
  }

}
