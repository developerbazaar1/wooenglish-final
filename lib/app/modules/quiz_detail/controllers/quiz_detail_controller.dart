import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

import '../../feedback/views/feedback_view.dart';

class QuizDetailController extends AppController {
  final count = 0.obs;
  int intValue = 1;
  int load = 0;
  final isLiked=false.obs;
  final isLastPage = false.obs;
  final inAsyncCall = false.obs;
  Books? quiz;
  final responseCode = 0.obs;
  Map<String, dynamic> queryParametersForGetQuizDetailApi = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Books> quizList = [];
  String limit = "10";
  String quizId = "";
  String bookId = "";
  int offset = 0;

  Map<String, dynamic> bodyParamsForBookLikeUnlike = {};



  @override
  void onInit() {
    super.onInit();
    screens = Screens.quizDetail;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> myOnInit() async {
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      await getQuizDetailApiCalling();
    }
    inAsyncCall.value = false;
  }

  Future<bool> onLoadMore() async {
    offset=offset+10;
    await getQuizDetailApiCalling();
    increment();

    return true;
  }

  Future<void> onRefresh() async {
    await myOnInit();
  }

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod() &&
          load == 0 &&
          screens == Screens.quizDetail) {
        load++;
        await myOnInit();
      } else {
        load = 0;
      }
    });
  }

  Future<void> getQuizDetailApiCalling() async {
    queryParametersForGetQuizDetailApi = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
      ApiKey.quizId: quizId,
    };

    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointUserQuizBookWise,
        queryParameters: queryParametersForGetQuizDetailApi);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForGetQuizDetailApi.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value = GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (offset == 0) {
        quizList.clear();
      }
      if (getDataModel.value != null &&
          getDataModel.value?.quiz != null &&
          getDataModel.value!.quiz!.isNotEmpty) {
        getDataModel.value?.quiz?.forEach((element) {
          quizList.add(element);
        });
        isLastPage.value = false;
      } else {
        isLastPage.value = true;
      }
    }
  }

/*
  Future<bool> bookLikeUnlikeApiCalling() async {
    bodyParamsForBookLikeUnlike = {
      ApiKey.bookId: bookId,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointAddUserFavorite,
        bodyParams: bodyParamsForBookLikeUnlike);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForBookLikeUnlike.clear();
      return true;
    } else {
      bodyParamsForBookLikeUnlike.clear();
      return false;
    }
  }
*/


  void clickOnBackButton() {
    Get.back();
  }

  Future<void> clickOnInfoButton() async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(FeedbackController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => FeedbackView(
          tag: tag,),
      ),
    );
    await Get.delete<FeedbackController>(tag: tag);
    screens = Screens.readAndListen;
    inAsyncCall.value = false;
  }

  /*Future<void> clickOnLikeButton() async {
    inAsyncCall.value=true;
    if(await bookLikeUnlikeApiCalling()) {
      isLiked.value=!isLiked.value;
    }
    inAsyncCall.value=false;
  }*/

  void clickOnShareButton() {}
}
