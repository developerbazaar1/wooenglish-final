import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:http/http.dart' as http;

class AuthorListController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final loaderForSearch = false.obs;
  final isSearchShow = false.obs;
  final searchController = TextEditingController();
  Timer? searchOnStoppedTyping;
  int load = 0;
  Map<String, dynamic> queryParametersForAuthors = {};
  final isLastPage = false.obs;
  final responseCode = 0.obs;
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Authors> authorList = [];
  String limit = "10";
  int offset = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.authorsList;
    inAsyncCall.value = true;
    if (await CM.internetConnectionCheckerMethod()) {
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

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod() &&
          load == 0 &&
          screens == Screens.authorsList) {
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
    await getAuthorsApiCalling();
    increment();
    return true;
  }

  onChange({required String value}) {
    loaderForSearch.value = true;

    if (value.isNotEmpty) {
      isSearchShow.value = true;
    } else {
      isSearchShow.value = false;
    }
    const duration = Duration(
        milliseconds:
        800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel(); // clear timer
    }
    searchOnStoppedTyping = Timer(duration, () async {
      offset=0;
      await getAuthorsApiCalling();
    });
  }


  Future<void> getAuthorsApiCalling() async {
    queryParametersForAuthors = {
      ApiKey.limit: limit,
      ApiKey.search: searchController.text.trim(),
      ApiKey.offset: offset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetAuthors,
        queryParameters: queryParametersForAuthors);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForAuthors.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (offset == 0) {
        authorList.clear();
      }
      if (getDataModel.value != null &&
          getDataModel.value?.authors != null &&
          getDataModel.value!.authors!.isNotEmpty) {
        getDataModel.value?.authors?.forEach((element) {
          authorList.add(element);
        });
        isLastPage.value = false;
      } else {
        isLastPage.value = true;
      }
    }
    loaderForSearch.value = false;
    increment();
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularAuthor({required int index}) async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.AUTHOR, arguments: [


      authorList[index].name ?? "",
      authorList[index].id.toString()
    ]);
    offset = 0;
    await getAuthorsApiCalling();
    inAsyncCall.value = false;
  }

  clickOnSearchKeyBordButton({required String value}) {}
}
