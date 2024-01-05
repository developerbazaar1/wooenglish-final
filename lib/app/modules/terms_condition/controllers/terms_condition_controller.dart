import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';

class TermsConditionController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  Map<String, dynamic> queryParametersForGetTermsAndCondition = {};
  final responseCode = 0.obs;
  final getDataModel = Rxn<GetDashBoardBooksModel>();

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.termsAndCondition;

    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
      try {
        await getHelpAndSupportApiCalling();
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
          screens == Screens.termsAndCondition) {
        load++;
        await onInit();
      } else {
        load = 0;
      }
    });
  }

  Future<void> onRefresh() async {
    await onInit();
  }

  void increment() => count.value++;

  Future<void> getHelpAndSupportApiCalling() async {
    queryParametersForGetTermsAndCondition = {
      ApiKey.pageName: ApiKey.termsAndCondition
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetPages,
        queryParameters: queryParametersForGetTermsAndCondition);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForGetTermsAndCondition.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
    }
  }

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }
}
