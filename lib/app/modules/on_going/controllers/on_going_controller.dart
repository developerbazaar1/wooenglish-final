import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import '../../../api/api_constant/api_constant.dart';
import '../../../api/api_model/get_dashboard_data_model.dart';
import '../../../api/http_methods/http_methods.dart';
import '../../../app_controller/app_controller.dart';
import '../../../common/common_method/common_method.dart';
import '../../book_detail/controllers/book_detail_controller.dart';
import '../../book_detail/views/book_detail_view.dart';

class OnGoingController extends AppController{
  @override

  final inAsyncCall=false.obs;
  final responseCode = 0.obs;
  final isLastPage = false.obs;
  Map<String, dynamic> queryParametersForAllViewBooks = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Books> booksList = [];
  String limit = "10";
  int offset = 0;
  final count = 0.obs;


  Future<void> onInit() async{
    // TODO: implement onInit
    super.onInit();
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        await getUserAllViewBooksApiCalling();
      } catch (e) {
        inAsyncCall.value = false;
      }
    }
  }
  Future<void> onRefresh() async {
    await onInit();
  }
  void increment() => count.value++;
  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = true;
    print("this is ${booksList[index].bookdetails!.showbookto.toString()}");
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(MaterialPageRoute(
      builder: (context) => BookDetailView(
        showbookto: booksList[index].bookdetails!.showbookto.toString(),
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

  Future<bool> onLoadMore() async {
    offset = offset + 10;
    await getUserAllViewBooksApiCalling();
    increment();
     return true;
  }


  Future<void> getUserAllViewBooksApiCalling() async {
    queryParametersForAllViewBooks = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetUserOngoingBooks,
        queryParameters: queryParametersForAllViewBooks);
    responseCode.value = response?.statusCode ?? 0;

    queryParametersForAllViewBooks.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      print("this is ongoing response ${jsonDecode(response!.body??'')}");

      getDataModel.value = GetDashBoardBooksModel.fromJson(jsonDecode(response.body));


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

  void clickOnSoundButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }
  void clickOnLikeButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

}