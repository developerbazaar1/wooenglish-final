import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/modules/quiz_detail/controllers/quiz_detail_controller.dart';
import 'package:woo_english/app/modules/quiz_detail/views/quiz_detail_view.dart';

class QuizzesController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  final responseCode = 0.obs;
  final isLastPage = false.obs;
  Map<String, dynamic> queryParametersForUserQuizApi = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Books> quizList = [];
  String limit = "10";
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.quizzes;
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      try{
        await getUserQuizApiCalling();
      }catch(e){
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
          screens == Screens.quizzes) {
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
    await getUserQuizApiCalling();
    increment();
    return true;
  }

  void increment() => count.value++;

  Future<void> getUserQuizApiCalling() async {
    queryParametersForUserQuizApi = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetUserQuiz,
        queryParameters: queryParametersForUserQuizApi);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForUserQuizApi.clear();
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

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(QuizDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => QuizDetailView(
            tag: tag,
            quizId: quizList[index].id.toString(),
            isLiked: getDataModel.value?.favorite?.contains(quizList[index].bookId.toString())??false,
            bookId: quizList[index].bookId.toString(),
            quiz:quizList[index] ),
      ),
    );
    await Get.delete<QuizDetailController>(tag: tag);
    offset = 0;
    await onInit();
  }

}
