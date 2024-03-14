import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:http/http.dart' as http;
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class BookListController extends AppController {
  int intValue = 1;
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int filterLoad=0;
  int load=0;
  String title = "";
  String id = "";
  String categoryId = "";
  String endPoint = "";
  List<BooksFilter> listOfFilter = [];
  List<String> listOfFilterTitle=["Genre","Level","Length","English"];
  List<String> selectedFilterId = [];
  List<String> selectedFilter = [];
  String limit = "10";
  int offset = 0;
  RxBool isAudioApplied = false.obs;
  final isLastPage = false.obs;
  final statusCode = 0.obs;
  Map<String, dynamic> queryParametersForSeeMore = {};
  final getBooksModel = Rxn<GetDashBoardBooksModel?>();
  List<Books> listOfBooks = [];

  final isAudio=false.obs;

  final selectedFilterValue = ''.obs;


  @override
  void onInit() {
    super.onInit();
    onReload();
  }

  Future<void> myOnInit() async {
    screens = Screens.booksList;
    inAsyncCall.value = true;
    if (title == C.textMostPopularBooks) {
      endPoint = UriConstant.endPointGetPopularBooks;
    } else if (title == C.textYourFavorite) {
      endPoint = UriConstant.endPointGetFavoriteBooks;
    } else if (title == C.textNewRelease) {
      endPoint = UriConstant.endPointGetNewReleaseBooks;
    } else if (title == C.textMemberOnlyBooks) {
      endPoint = UriConstant.endPointGetMemberBooks;
    } else if (title == C.textRecommendedForYou) {
      endPoint = UriConstant.endPointGetRecommendedBooks;
    } else if (title == C.textSimilarBooks||categoryId.isNotEmpty) {
      endPoint = UriConstant.endPointGetSimilarBook;
    }
    if(await CM.internetConnectionCheckerMethod())
    {
      await getBookListApiCalling(
          isUserFavoriteData: title == C.textYourFavorite);
    }

    inAsyncCall.value = false;
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
      if (await CM.internetConnectionCheckerMethod()&&load==0&&screens == Screens.booksList) {
        load++;
        await myOnInit();
      } else {
        load=0;
      }
    });
  }

  Future<void> onRefresh() async {
    offset = 0;
    await myOnInit();
  }

  Future<bool> onLoadMore() async {
    offset = offset ;
    await getBookListApiCalling(
        isUserFavoriteData: title == C.textYourFavorite);
    increment();
    return true;
  }



  Future<void> getBookListApiCalling({bool isUserFavoriteData = false}) async {
    if (isUserFavoriteData) {
      queryParametersForSeeMore = {
        ApiKey.limit: limit,
        ApiKey.offset: offset.toString(),
        ApiKey.isDashboard: "0",
        if(isAudioApplied.value != false)
        ApiKey.isAudio:isAudio.value?"1":"0"
      };
    } else if (title == C.textSimilarBooks || categoryId.isNotEmpty) {
      queryParametersForSeeMore = {
        ApiKey.categoryId: categoryId.isNotEmpty ? categoryId : "",
        ApiKey.limit: limit,
        ApiKey.offset: offset.toString(),
        ApiKey.inBookDetails: "0",
        if(isAudioApplied.value != false)
        ApiKey.isAudio:isAudio.value?"1":"0"
      };
    } else {
      queryParametersForSeeMore = {
        ApiKey.limit: limit,
        ApiKey.offset: offset.toString(),
        if(isAudioApplied.value != false)
        ApiKey.isAudio: isAudio.value ? "1" : "0"
      };
    }
    if (selectedFilterId.isNotEmpty) {
      queryParametersForSeeMore[ApiKey.genre] = selectedFilterId[0];
      queryParametersForSeeMore[ApiKey.level] = selectedFilterId[1];
      queryParametersForSeeMore[ApiKey.length] = selectedFilterId[2];

      queryParametersForSeeMore[ApiKey.language] = selectedFilterId[3];

    }
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: endPoint,
        queryParameters: queryParametersForSeeMore);
    statusCode.value = response?.statusCode ?? 0;
    queryParametersForSeeMore.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getBooksModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (offset == 0) {
        listOfBooks.clear();
      }
      int index = 0;
      if (getBooksModel.value!= null&&getBooksModel.value?.books != null &&
          getBooksModel.value!.books!.isNotEmpty) {
        getBooksModel.value?.books?.forEach((element) {
          listOfBooks.add(element);


          print('this is book list${listOfBooks[index].title}');
          index++;
        });
        isLastPage.value = false;
      } else {
        isLastPage.value = true;
      }

      if(filterLoad==0)
        {
          filterLoad++;
          listOfFilter.clear();
          selectedFilterId.clear();
          selectedFilter.clear();
          if (getBooksModel.value?.genre != null &&
              getBooksModel.value!.genre!.isNotEmpty) {
            listOfFilter.add(BooksFilter(title: "Any", filterList: getBooksModel.value?.genre));
            selectedFilterId.add("");
            selectedFilter.add("");
          }
          if (getBooksModel.value?.level != null &&
              getBooksModel.value!.level!.isNotEmpty) {
            listOfFilter.add(BooksFilter(
                title: "Any", filterList: getBooksModel.value?.level));
            selectedFilterId.add("");
            selectedFilter.add("");
          }
          if (getBooksModel.value?.length != null &&
              getBooksModel.value!.length!.isNotEmpty) {
            listOfFilter.add(BooksFilter(
                title: "Any", filterList: getBooksModel.value?.length));
            selectedFilterId.add("");
            selectedFilter.add("");
          }
          if (getBooksModel.value?.language != null &&
              getBooksModel.value!.length!.isNotEmpty) {
            listOfFilter.add(BooksFilter(
                title: "Any", filterList: getBooksModel.value?.language));
            selectedFilterId.add("");
            selectedFilter.add("");
          }
          if (getBooksModel.value?.is_audio != null &&
              getBooksModel.value!.length!.isNotEmpty) {
            listOfFilter.add(BooksFilter(
                title: "Any", filterList: getBooksModel.value?.is_audio));
            selectedFilterId.add("");
            selectedFilter.add("");
          }
    /*      if (getBooksModel.value?.language != null &&
              getBooksModel.value!.language!.isNotEmpty) {
            listOfFilter.add(BooksFilter(
                title: "Language", filterList: getBooksModel.value?.language));
            selectedFilterId.add("");
            selectedFilter.add("");
          }*/
        }

    }
  }

  void increment() => count.value++;

  void clickOnBackButton() {
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBook({required int index}) async {
    print("fev book ${listOfBooks[index].showbookto.toString()}");
    inAsyncCall.value = true;

    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    intValue = 0;
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookDetailView(
          isAudio: listOfBooks[index].isAudio,
          showbookto:title == C.textYourFavorite?listOfBooks[index].bookdetails!.showbookto.toString(): listOfBooks[index].showbookto.toString(),
            tag: tag,
            bookId: title == C.textYourFavorite
                ? listOfBooks[index].bookId.toString()
                : listOfBooks[index].id.toString(),
            isLiked: title == C.textYourFavorite
                ? true
                : getBooksModel.value!.favorite!
                    .contains(listOfBooks[index].id.toString()),
            categoryId: title == C.textYourFavorite
                ? listOfBooks[index].bookdetails?.category
                : listOfBooks[index].category),
      ),
    );
    await Get.delete<BookDetailController>(tag: tag);
    offset = 0;
    await myOnInit();
  }

  void clickOnSoundButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnLikeButton({required int index})  {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  Future<void> clickOnSelectAudioFilter() async {


    inAsyncCall.value = true;
    isAudio.value=!isAudio.value;
    isAudioApplied.value = true;
    print("button presssed ${ isAudioApplied.value}  ${isAudio.value}");
    offset = 0;
    await getBookListApiCalling(
        isUserFavoriteData: title == C.textYourFavorite);
    inAsyncCall.value = false;
  }
  Future<void> clickOnAllBooks() async {


    inAsyncCall.value = true;
    isAudio.value=false;
    isAudioApplied.value = false;

    // offset = 0;
    // await getBookListApiCalling(
    //     isUserFavoriteData: title == C.textYourFavorite);
    inAsyncCall.value = false;
  }

}

class BooksFilter {
  String? title;
  List<Filters>? filterList;
  BooksFilter({this.title, this.filterList});
}
