import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

class AllReviewsController extends AppController {
  int intValue = 1;
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load=0;
  String id = "";
  String bookId = "";

  final isLastPage = false.obs;
  final responseCode = 0.obs;
  Map<String, dynamic> queryParametersForAllReviews = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Reviews> reviewsList = [];
  String limit = "10";
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
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


  Future<void> myOnInit() async {
    screens = Screens.allReviews;
    inAsyncCall.value = true;
    if(await CM.internetConnectionCheckerMethod())
    {
      await getBooksReviewsApiCalling();
    }
    inAsyncCall.value = false;
  }

  onReload(){
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod()&&load==0&&screens == Screens.allReviews) {
        load++;
        await myOnInit();
      } else {
        load=0;
      }
    });
  }

  Future<bool> onLoadMore() async {
    offset = offset + 10;
    await getBooksReviewsApiCalling();
    increment();
    return true;
  }

  Future<void> onRefresh() async {
    offset = 0;
    await myOnInit();
  }

  void increment() => count.value++;

  Future<void> getBooksReviewsApiCalling() async {
    queryParametersForAllReviews = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
      ApiKey.bookId: bookId.isNotEmpty ? bookId : ""
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetBookReview,
        queryParameters: queryParametersForAllReviews);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForAllReviews.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (offset == 0) {
        reviewsList.clear();
      }
      if (getDataModel.value != null &&
          getDataModel.value?.reviews != null &&
          getDataModel.value!.reviews!.isNotEmpty) {
        getDataModel.value?.reviews?.forEach((element) {
          reviewsList.add(element);
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
}
