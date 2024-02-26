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
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

class EBookController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  final responseCode = 0.obs;
  final isLastPage = false.obs;
  Map<String, dynamic> queryParametersForAllViewBooks = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Books> booksList = [];
  String limit = "10";
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.eBooks;
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        await getUserAllViewBooksApiCalling();
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
          screens == Screens.eBooks) {
        load++;
        await onInit();
      } else {
        load = 0;
      }
    });
  }

  Future<void> onRefresh() async {
    offset = 0;
    await onInit();
  }

  Future<bool> onLoadMore() async {
    offset = offset + 10;
    await getUserAllViewBooksApiCalling();
    increment();
    return true;
  }

  void increment() => count.value++;

  Future<void> getUserAllViewBooksApiCalling() async {
    queryParametersForAllViewBooks = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetUserViewBook,
        queryParameters: queryParametersForAllViewBooks);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForAllViewBooks.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (offset == 0) {
        booksList.clear();
      }
      if (getDataModel.value != null &&
          getDataModel.value?.books != null &&
          getDataModel.value!.books!.isNotEmpty) {
        getDataModel.value?.books?.forEach((element) {
          booksList.add(element);
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
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(MaterialPageRoute(
      builder: (context) => BookDetailView(
        isAudio: booksList[index].bookdetails?.isAudio,
        tag: tag,
        bookId: booksList[index].bookId.toString(),
        isLiked: getDataModel.value!.favorite!
            .contains(booksList[index].bookId.toString()),
        categoryId: booksList[index].bookdetails?.category,
      ),
    ));
    await Get.delete<BookDetailController>(tag: tag);
    offset = 0;
    await onInit();
    inAsyncCall.value = false;
  }

  void clickOnSoundButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnLikeButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }
}
