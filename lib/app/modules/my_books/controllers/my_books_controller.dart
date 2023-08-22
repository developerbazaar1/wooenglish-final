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

class MyBooksController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final responseCode = 0.obs;
  ScrollController scrollController = ScrollController();

  final isLastPage = false.obs;
  Map<String, dynamic> queryParametersForFavoriteBooks = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Books> booksList = [];
  String limit = "10";
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    inAsyncCall.value = true;
    if(await CM.internetConnectionCheckerMethod()) {
     try{
       await getUserFavoriteBooksApiCalling();
     }catch (e) {

       inAsyncCall.value = false;
     }
    }
    inAsyncCall.value = false;
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
    offset = 0;
    await onInit();
  }

  Future<bool> onLoadMore() async {
    offset = offset + 10;
    await getUserFavoriteBooksApiCalling();
    increment();
    return true;
  }

  void increment() => count.value++;

  Future<void> getUserFavoriteBooksApiCalling() async {
    queryParametersForFavoriteBooks = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
      ApiKey.isDashboard: "0",
    };

    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetFavoriteBooks,
        queryParameters: queryParametersForFavoriteBooks);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForFavoriteBooks.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value = GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));

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

  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(MaterialPageRoute(
      builder: (context) => BookDetailView(
        tag: tag,
        bookId: booksList[index].bookId.toString(),
        isLiked: true,
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
