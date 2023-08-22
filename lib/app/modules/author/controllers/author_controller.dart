import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_author_detail_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:woo_english/app/modules/feedback/views/feedback_view.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/firebase/firebase_login_method.dart';
import '../../book_detail/controllers/book_detail_controller.dart';

class AuthorController extends AppController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load=0;
  late TabController tabController;
  List<Tab> tabs = [
    const Tab(text: C.textBooks),
    const Tab(
      text: C.textReviews,
    )
  ];
  final isFollow = false.obs;
  final followersCount = 0.obs;
  final statusCode = 0.obs;
  String title = Get.arguments[0] ?? "";
  String authorId = Get.arguments[1] ?? "";
  Map<String, dynamic> queryParametersForAuthor = {};
  final getAuthorDetailsModel = Rxn<GetAuthorDetailsModel>();
  Map<String, dynamic> bodyParamsForAuthorFollowUnfollow = {};

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.authorDetail;
    inAsyncCall.value = true;
    tabController = TabController(length: 2, vsync: this);
    if(await CM.internetConnectionCheckerMethod())
      {
        await getAuthorsApiCalling();
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

  onReload(){
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod()&&load==0&&screens == Screens.authorDetail) {
        load++;
        inAsyncCall.value=true;
        await getAuthorsApiCalling();
        inAsyncCall.value=false;
      } else {
        load=0;
      }
    });
  }

  Future<void> onRefresh() async {
    inAsyncCall.value = true;
    await getAuthorsApiCalling();
    inAsyncCall.value = false;
  }

  void increment() => count.value++;

  Future<void> getAuthorsApiCalling() async {
    queryParametersForAuthor = {ApiKey.authorId: authorId};
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetAuthorDetail,
        queryParameters: queryParametersForAuthor);
    statusCode.value = response?.statusCode ?? 0;
    queryParametersForAuthor.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getAuthorDetailsModel.value =
          GetAuthorDetailsModel.fromJson(jsonDecode(response?.body ?? ""));
      title=getAuthorDetailsModel.value?.author?.name??"";
      followersCount.value = getAuthorDetailsModel.value?.noOfFollowers ?? 0;
      if (getAuthorDetailsModel.value?.isFollow.toString() == "1") {
        isFollow.value = true;
      } else {
        isFollow.value = false;
      }
    }
  }

  Future<bool> authorFollowUnfollowApi() async {
    bodyParamsForAuthorFollowUnfollow = {
      ApiKey.authorId: authorId,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointFollowAuthor,
        bodyParams: bodyParamsForAuthorFollowUnfollow);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForAuthorFollowUnfollow.clear();
      return true;
    } else {
      bodyParamsForAuthorFollowUnfollow.clear();
      return false;
    }
  }

   clickOnBackButton() async {
    inAsyncCall.value = true;
    if(AppController.routes==C.not)
      {
        AppController.routes=C.yes;
        await Get.offAllNamed(Routes.NAVIGATOR);
      }
    else
      {
      Get.back();
      }

    inAsyncCall.value = false;
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
    screens = Screens.authorDetail;
    inAsyncCall.value = false;
  }

  Future<void> clickOnShareButton() async {
    inAsyncCall.value = true;
    await FirebaseMethod.instance.shareDynamicLink(routes: C.authors,authorId:authorId );
    inAsyncCall.value = false;
  }

  Future<void> clickOnFollowButton() async {
    inAsyncCall.value = true;
    if (await authorFollowUnfollowApi()) {
      isFollow.value = !isFollow.value;
      if (isFollow.value) {
        followersCount.value++;
      } else {
        followersCount.value--;
      }
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBook({required int index}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookDetailView(
            tag: tag,
            bookId:
                getAuthorDetailsModel.value!.authorBooks?[index].id.toString(),
            isLiked: getAuthorDetailsModel.value!.favorite!.contains(
                getAuthorDetailsModel.value!.authorBooks?[index].id.toString()),
            categoryId: getAuthorDetailsModel
                .value!.authorBooks?[index].category
                .toString(),),
      ),
    );
    await Get.delete<BookDetailController>(tag: tag);
    screens = Screens.authorDetail;
    await getAuthorsApiCalling();
    inAsyncCall.value = false;
  }
}
