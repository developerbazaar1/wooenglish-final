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

class ReviewsController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  final responseCode = 0.obs;
  final isLastPage = false.obs;
  Map<String, dynamic> queryParametersForUserReviews = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Reviews> reviewList = [];
  String limit = "10";
  int offset = 0;

  Map<String, dynamic> queryParametersForDeleteReview = {};

  @override
  Future<void> onInit() async {
    screens = Screens.reviews;
    super.onInit();
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        await getUserBookReviewsApiCalling();
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
          screens == Screens.reviews) {
        load++;
        await onInit();
      } else {
        load = 0;
      }
    });
  }

  void increment() => count.value++;

  Future<void> onRefresh() async {
    offset = 0;
    await onInit();
  }

  Future<bool> onLoadMore() async {
    offset = offset + 10;
    await getUserBookReviewsApiCalling();
    increment();
    return true;
  }

  Future<void> getUserBookReviewsApiCalling() async {
    queryParametersForUserReviews = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetUserReview,
        queryParameters: queryParametersForUserReviews);
    queryParametersForUserReviews.clear();
    responseCode.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (offset == 0) {
        reviewList.clear();
      }
      if (getDataModel.value != null &&
          getDataModel.value?.reviews != null &&
          getDataModel.value!.reviews!.isNotEmpty) {
        getDataModel.value?.reviews?.forEach((element) {
          reviewList.add(element);
        });
        isLastPage.value = false;
      } else {
        isLastPage.value = true;
      }
    }
  }

  Future<void> deleteBookReviewsApiCalling({required int index}) async {
    queryParametersForDeleteReview = {
      ApiKey.reviewId: reviewList[index].id.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointDeleteUserReview,
        queryParameters: queryParametersForDeleteReview);
    queryParametersForDeleteReview.clear();
    responseCode.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      reviewList.removeAt(index);
    }
  }

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnDeleteButton({required int index}) async {
    inAsyncCall.value = true;
    await deleteBookReviewsApiCalling(index: index);
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(MaterialPageRoute(
      builder: (context) => BookDetailView(
        tag: tag,
        bookId: reviewList[index].bookId.toString(),
        isLiked: getDataModel.value!.favorite!
            .contains(reviewList[index].bookId.toString()),
        categoryId: reviewList[index].bookdetails?.category,
      ),
    ));
    await Get.delete<BookDetailController>(tag: tag);
    offset = 0;
    await onInit();
    inAsyncCall.value = false;
  }
}
