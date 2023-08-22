import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/api_model/user_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/book_list/controllers/book_list_controller.dart';
import 'package:woo_english/app/modules/book_list/views/book_list_view.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/firebase/firebase_login_method.dart';

class HomeController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final isLoading = false.obs;
  final responseCode = 0.obs;
  String fcmId = "";
  Map<String, dynamic> bodyParamsForFcmIdApi = {};

  UserData? getUserDataModel;
  Map<String, dynamic> responseMapForGreeting = {};
  String greeting = "";
  int i = 1;
  Map<String, dynamic> queryParametersForDashboard = {};
  final getDashBoarDataForPopularBooks = Rxn<GetDashBoardBooksModel>();
  final getDashBoarDataForContinueBooks = Rxn<GetDashBoardBooksModel>();
  final getDashBoarDataForRecommendedBooks = Rxn<GetDashBoardBooksModel>();
  final getDashBoarDataForUserFavoriteBooks = Rxn<GetDashBoardBooksModel>();
  final getDashBoarDataForNewReleaseBooks = Rxn<GetDashBoardBooksModel>();
  final getDashBoarDataForMemberBooks = Rxn<GetDashBoardBooksModel>();
  final getDashBoarDataAuthors = Rxn<GetDashBoardBooksModel>();
  Map<String, dynamic> queryParametersForGetUserFavoriteData = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    if (await CM.internetConnectionCheckerMethod()) {
      await insertIntoDataBase();
      inAsyncCall.value = true;
      try {
        await getGreetingApiCalling();
        await getUserDataApiCalling();
        getDashBoarDataForContinueBooks.value = await getContinueBookData();
        if (getDashBoarDataAuthors.value == null) {
          isLoading.value = true;
        }
        inAsyncCall.value = false;
        getDashBoarDataForPopularBooks.value =
            await getDashBoardDataApiCalling(bookTitle: ApiKey.popularBooks);
        getDashBoarDataForRecommendedBooks.value =
            await getDashBoardDataApiCalling(
                bookTitle: ApiKey.recommendedBooks);
        getDashBoarDataForUserFavoriteBooks.value = await getUserFavoriteData();
        getDashBoarDataForNewReleaseBooks.value =
            await getDashBoardDataApiCalling(bookTitle: ApiKey.newReleaseBooks);
        getDashBoarDataForMemberBooks.value =
            await getDashBoardDataApiCalling(bookTitle: ApiKey.memberBooks);
        getDashBoarDataAuthors.value =
            await getDashBoardDataApiCalling(bookTitle: ApiKey.authors);
        isLoading.value = false;
        fcmId = await FirebaseMethod.instance.fcmIdRequest() ?? "  ";
        await fcmIdApiCalling();
      } catch (e) {
        inAsyncCall.value = false;
      }
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

  Future<bool> fcmIdApiCalling() async {
    bodyParamsForFcmIdApi = {
      ApiKey.fcmId: fcmId,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointFirebaseToken,
        bodyParams: bodyParamsForFcmIdApi);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForFcmIdApi.clear();
      return true;
    } else {
      bodyParamsForFcmIdApi.clear();
      return false;
    }
  }

  Future<bool> insertIntoDataBase() async {
    if (await DatabaseHelper.databaseHelperInstance.isDatabaseHaveData(
        db: DatabaseHelper.db, tableName: DatabaseConst.tableNameUserLogin)) {
      bool isInsert = await DatabaseHelper.databaseHelperInstance.insert(
        db: DatabaseHelper.db,
        tableName: DatabaseConst.tableNameUserLogin,
        data: {DatabaseConst.columIsLogIn: "1"},
      );
      return isInsert;
    }
    return false;
  }

  void increment() => count.value++;

  Future<bool> getUserDataApiCalling() async {
    http.Response? response = await HttpMethod.instance.getRequest(
      url: UriConstant.endPointGetUserData,
    );
    responseCode.value=response?.statusCode??0;

    if (CM.responseCheckForGetMethod(response: response)) {
      getUserDataModel = UserData.fromJson(jsonDecode(response?.body ?? ""));
      await CM.insertDataIntoDataBase(userData: getUserDataModel);
      return true;
    } else {
      return false;
    }
  }

  Future<void> getGreetingApiCalling() async {
    http.Response? response = await HttpMethod.instance
        .getRequest(url: UriConstant.endPointGetGreeting);
    responseCode.value=response?.statusCode??0;
    if (CM.responseCheckForGetMethod(response: response)) {
      responseMapForGreeting = jsonDecode(response?.body ?? "");
      greeting = responseMapForGreeting[ApiKey.data];
    }
  }

  Future<GetDashBoardBooksModel?> getContinueBookData() async {
    GetDashBoardBooksModel getDashBoardBooksModel;
    http.Response? response = await HttpMethod.instance
        .getRequest(url: UriConstant.endPointGetContinueBook);
    responseCode.value=response?.statusCode??0;
    if (CM.responseCheckForGetMethod(response: response)) {
      getDashBoardBooksModel =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      return getDashBoardBooksModel;
    } else {
      return null;
    }
  }

  Future<GetDashBoardBooksModel?> getDashBoardDataApiCalling({
    required String bookTitle,
  }) async {
    GetDashBoardBooksModel getDashBoardBooksModel;
    queryParametersForDashboard = {
      ApiKey.bookTitle: bookTitle,
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetDashBoardData,
        queryParameters: queryParametersForDashboard);
    responseCode.value=response?.statusCode??0;
    queryParametersForDashboard.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDashBoardBooksModel =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      return getDashBoardBooksModel;
    } else {
      return null;
    }
  }

  Future<GetDashBoardBooksModel?> getUserFavoriteData() async {
    GetDashBoardBooksModel getDashBoardBooksModel;
    queryParametersForGetUserFavoriteData = {ApiKey.isDashboard: "1"};
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        queryParameters: queryParametersForGetUserFavoriteData,
        endPointUri: UriConstant.endPointGetFavoriteBooks);
    if (CM.responseCheckForGetMethod(response: response)) {
      getDashBoardBooksModel =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      return getDashBoardBooksModel;
    } else {
      return null;
    }
  }

  Future<void> clickOnUserProfileButton() async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.EDIT_PROFILE);
    await onInit();
  }

  void clickOnNotificationButton() async {
    inAsyncCall.value = true;
    Get.toNamed(Routes.NOTIFICATIONS);
    inAsyncCall.value = false;
  }

  Future<void> clickOnContinueBook() async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookDetailView(
            tag: tag,
            bookId: getDashBoarDataForContinueBooks.value?.book?.bookId
                    .toString() ??
                "0",
            isLiked: getDashBoarDataForContinueBooks.value!.favorite!.contains(
                getDashBoarDataForContinueBooks.value!.book?.bookId.toString()),
            categoryId: getDashBoarDataForContinueBooks
                .value!.book?.bookdetails?.category
                .toString()),
      ),
    );
    await Get.delete<BookDetailController>(tag: tag);
    await onInit();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBook(
      {required int index,
      required String id,
      required GetDashBoardBooksModel getDashBoardBooksModel}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookDetailView(
            tag: tag,
            bookId: id == C.textYourFavorite
                ? getDashBoardBooksModel.books![index].bookId ?? "0"
                : getDashBoardBooksModel.books![index].id.toString(),
            categoryId: id == C.textYourFavorite
                ? getDashBoardBooksModel.books![index].bookdetails?.category ??
                    "0"
                : getDashBoardBooksModel.books![index].category.toString(),
            isLiked: id == C.textYourFavorite
                ? true
                : getDashBoardBooksModel.favorite!.contains(
                    getDashBoardBooksModel.books?[index].id.toString())),
      ),
    );
    await Get.delete<BookDetailController>(tag: tag);
    await onInit();
    inAsyncCall.value = false;
  }

  Future<void> clickOnSeeMore({required String id}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookListController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookListView(tag: tag, title: id),
      ),
    );
    await Get.delete<BookListController>(tag: tag);
    await onInit();

    inAsyncCall.value = false;
  }

  Future<void> clickOnAuthorSeeMore({required String id}) async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.AUTHOR_LIST);
    await onInit();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularAuthor({required int index}) async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.AUTHOR, arguments: [
      getDashBoarDataAuthors.value?.authors?[index].name ?? "",
      getDashBoarDataAuthors.value?.authors?[index].id.toString() ?? ""
    ]);
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
