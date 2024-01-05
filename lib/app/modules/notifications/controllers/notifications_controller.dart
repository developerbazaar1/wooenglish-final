import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

class NotificationsController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  final isLastPage = false.obs;
  final responseCode = 0.obs;
  Map<String, dynamic> queryParametersForUserNotificationApi = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Notification> notificationList = [];
  String limit = "10";
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.notifications;
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        await getUserNotificationApiCalling();
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
          screens == Screens.notifications) {
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
    await getUserNotificationApiCalling();
    increment();
    return true;
  }

  Future<void> getUserNotificationApiCalling() async {
    queryParametersForUserNotificationApi = {
      ApiKey.limit: limit,
      ApiKey.offset: offset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetNotification,
        queryParameters: queryParametersForUserNotificationApi);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForUserNotificationApi.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataModel.value?.notification == null ||
          getDataModel.value!.notification!.isEmpty) {
        isLastPage.value = true;
      } else {
        isLastPage.value = false;
      }

      if (offset == 0) {
        notificationList.clear();
      }
      if (getDataModel.value != null &&
          getDataModel.value?.notification != null &&
          getDataModel.value!.notification!.isNotEmpty) {
        getDataModel.value?.notification?.forEach((element) {
          notificationList.add(element);
        });
      }
    }
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  void clickOnClearButton() {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnParticularNotification({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnCrossIcon({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }
}
