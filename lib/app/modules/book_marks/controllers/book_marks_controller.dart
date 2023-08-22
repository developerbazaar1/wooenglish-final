import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/modules/read_book/controllers/read_book_controller.dart';
import 'package:woo_english/app/modules/read_book/views/read_book_view.dart';

class BookMarksController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;
  int load = 0;
  Map<String, dynamic> queryParametersForBookMarks = {};
  final responseCode = 0.obs;
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Books> bookList = [];
  String limit = "10";
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.bookMark;
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        await getBookmarksApiCalling();
      } catch (e) {
        inAsyncCall.value = false;
      }
    }
    inAsyncCall.value = false;
    onReload();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod() &&
          load == 0 &&
          screens == Screens.bookMark) {
        load++;
        await onInit();
      } else {
        load == 0;
      }
    });
  }

  Future<void> onRefresh() async {
    offset = 0;
    await onInit();
  }

  Future<bool> onLoadMore() async {
    offset = offset + 10;
    await getBookmarksApiCalling();
    increment();
    return true;
  }

  void increment() => count.value++;

  Future<void> getBookmarksApiCalling() async {
    queryParametersForBookMarks = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetUserBookMarks,
        queryParameters: queryParametersForBookMarks);
    queryParametersForBookMarks.clear();
    responseCode.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (offset == 0) {
        bookList.clear();
      }
      if (getDataModel.value != null &&
          getDataModel.value?.books != null &&
          getDataModel.value!.books!.isNotEmpty) {
        getDataModel.value?.books?.forEach((element) {
          bookList.add(element);
        });
        isLastPage.value = false;
      } else {
        isLastPage.value = true;
      }
    }
  }

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(ReadBookController(), tag: tag);
    await Navigator.of(Get.context!).push(MaterialPageRoute(
      builder: (context) => ReadBookView(
        tag: tag,
        bookId: bookList[index].bookId.toString(),
        isBookmark: true,
        chapterId: bookList[index].chapterId,
      ),
    ));
    await Get.delete<ReadBookController>(tag: tag);
    offset = 0;
    await onInit();
    inAsyncCall.value = false;
  }
}
