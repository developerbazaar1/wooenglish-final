import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sqflite/sql.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/search_suggestion_list/views/filter_bottom_sheet.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import '../../../api/api_model/get_dashboard_data_model.dart';

class SearchSuggestionListController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final loaderForSearch = false.obs;
  final isSearchShow = false.obs;
  final searchController = TextEditingController();
  Timer? searchOnStoppedTyping;
  ScrollController scrollController = ScrollController();
  final responseCode = 0.obs;
  Map<String, dynamic> queryParametersForSearchBook = {};
  final getDataNewReleaseBook = Rxn<GetDashBoardBooksModel>();
  RxList<Books> bookList = <Books>[].obs;

  final getDataForCategory = Rxn<GetDashBoardBooksModel>();
  final getDataForGenre = Rxn<GetDashBoardBooksModel>();

  List<String> myaudioList= ['Any','With',"Without"];
  int index = 0;
  List<Filters> categoryList = [];
  List<Filters> genreList = [];
  List<Filters> englishAccentList = [];
  List<Filters> levelList = [];
  List<Filters> languageList = [];
  List<Filters> audioList = [];
  List<Filters> lengthList = [];

  List<int> selectedCategory = [];
  List<int> selectedGenre = [];
  List<int> selectedEnglishAssent = [];
  List<int> selectedLevel = [];
  List<int> selectedLanguage = [];
  List<int> selectedLength = [];
  List<int> selectedAudio = [];

  List<int> category = [];
  List<int> englishAssent = [];
  List<int> level = [];
  List<int> language = [];
  List<int> length = [];

  String categoryValue = "";
  String englishAssentValue = "3";
  String levelValue = "5";
  String languageValue = "";
  String lengthValue = "4";
  RxString isAudioValue = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getSearchBookDataApiCalling();
    inAsyncCall.value = true;
    try {
      await getGenreApiCalling();
      await getCategoryApiCalling();

      await getEnglishAccentApiCalling();
      await getLevelApiCalling();
      await getLanguageApiCalling();
      await getLengthApiCalling();
      await getSearchBookDataApiCalling();
    } catch (e) {
      inAsyncCall.value = false;
    }
    print(bookList);
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
      if (await CM.internetConnectionCheckerMethod()) {
        onInit();
      } else {}
    });
  }

  void increment() => count.value++;


  Future<void> getSearchBookDataApiCalling() async {
    queryParametersForSearchBook = {
       //ApiKey.category: categoryValue,
     // ApiKey.englishAccent: englishAssentValue.toString(),
     // ApiKey.level: levelValue.toString(),
      ////? ApiKey.language: languageValue,
      //ApiKey.length: lengthValue.toString(),
       ApiKey.bookName: searchController.text.toString().trim(),
     // ApiKey.genre:6.toString(),
        ApiKey.isAudio:isAudioValue.value

    };

    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetSearchList,
        queryParameters: queryParametersForSearchBook);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForSearchBook.clear();
    print('this is search fitler data '+" ${jsonDecode(response?.body ?? "")}");
   // print(" id value ${languageList[Filters.fromJson(json as Map<String, dynamic>).id!]}");
    print(" $categoryValue 1 $englishAssentValue 2 $levelValue 3 $languageValue 4 $lengthValue 5 ${searchController.text.toString().trim()}");

    if (CM.responseCheckForGetMethod(response: response)) {
      getDataNewReleaseBook.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      print('this is search data '+" ${getDataNewReleaseBook.value!.book}");
     print( 'this is audio fitler data '+
        ' ${getDataNewReleaseBook.value?.is_audio}');
      if (getDataNewReleaseBook.value?.books != null) {
        bookList.value = getDataNewReleaseBook.value?.books ?? [];
      }
    }
    loaderForSearch.value = false;
  }

  Future<void> getCategoryApiCalling() async {
    http.Response? response = await HttpMethod.instance
        .getRequest(url: UriConstant.endPointGetCategory);
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataForCategory.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataForCategory.value?.category != null) {
        getDataForCategory.value?.category?.forEach((element) {
          categoryList.add(element);
          selectedCategory.add(-1);
        });
      }
    }
  }
  Future<void> getGenreApiCalling() async {
    http.Response? response = await HttpMethod.instance
        .getRequest(url: UriConstant.endPointGetGenre);
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataForGenre.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataForGenre.value?.level != null) {
        getDataForGenre.value?.level?.forEach((element) {
          genreList.add(element);
          selectedGenre.add(-1);
          print("this is genre value ${genreList[index].name}");
        });
      }

    }
  }

  Future<void> getEnglishAccentApiCalling() async {
    http.Response? response = await HttpMethod.instance
        .getRequest(url: UriConstant.endPointGetEnglishAssent);
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataForCategory.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataForCategory.value?.englishAccent != null) {
        getDataForCategory.value?.englishAccent?.forEach((element) {
          englishAccentList.add(element);
          selectedEnglishAssent.add(-1);
        });
      }
    }
  }

  Future<void> getLevelApiCalling() async {
    http.Response? response =
        await HttpMethod.instance.getRequest(url: UriConstant.endPointGetLevel);
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataForCategory.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataForCategory.value?.level != null) {
        getDataForCategory.value?.level?.forEach((element) {
          levelList.add(element);
          selectedLevel.add(-1);
        });
      }
    }
  }
  Future<void> getLanguageApiCalling() async {
    http.Response? response =
        await HttpMethod.instance.getRequest(url: UriConstant.endPointGetLanguage);
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataForCategory.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataForCategory.value?.language != null) {
        print(getDataForCategory.value?.is_audio);
        getDataForCategory.value?.language?.forEach((element) {


          languageList.add(Filters(name: myaudioList[index],id: index-1),);
          selectedLanguage.add(index);
          print("ELEvamt ${selectedLanguage}");
          index++;


        });
      }else{
        print("audio is null");
      }
    }
  }

  Future<void> getLengthApiCalling() async {
    http.Response? response =
        await HttpMethod.instance.getRequest(url: UriConstant.endPointGetLength);
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataForCategory.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataForCategory.value?.length != null) {
        getDataForCategory.value?.length?.forEach((element) {
          lengthList.add(element);
          selectedLength.add(-1);
        });
      }
    }
  }

  void clickOnBackButton() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  void clickOnSearchIcon() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  Future<void> clickOnFilterButton() async {
    CM.unFocsKeyBoard();
    showModalBottomSheet(
        context: Get.context!,
        builder: (context) =>  FilterBottomSheet(),
        isDismissible: true,
        enableDrag: true,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.px),
              topRight: Radius.circular(25.px)),
        ),
        isScrollControlled: true,
        backgroundColor: Col.cardBackgroundColor);
  }

  Future<void> clickOnParticularBook({required int index}) async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookDetailView(
          showbookto:  bookList[index].showbookto.toString(),
            tag: tag,
            bookId: bookList[index].id.toString(),
            categoryId: bookList[index].category,
            isLiked: getDataNewReleaseBook.value?.favorite
                    ?.contains(bookList[index].id.toString()) ??
                false),
      ),
    );
    await Get.delete<BookDetailController>(tag: tag);
    inAsyncCall.value = false;
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
      await getSearchBookDataApiCalling();
    });
  }

  void clickOnArrowButton({required int index}) {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularFilter(
      {required int index, required int key, String? name,bool? value}) async {


    increment();
    CM.unFocsKeyBoard();

    if (key == 0) {
      if(value==false) {
        if (name == "Without".toString()) {
          isAudioValue.value = 0.toString();
          print(isAudioValue.value);
          print("${isAudioValue.value} + $name!");
        } else if (name == "With".toString()) {
          isAudioValue.value = 1.toString();
          print(isAudioValue.value);
          print("${isAudioValue.value} + $name!");
        }
      }else{
        isAudioValue.value = '';
        print("${isAudioValue.value} + $name!");
      }

      if ((selectedLanguage[index] == languageList[index].id) &&
          language.contains(selectedLanguage[index])) {
        language.remove(selectedLanguage[index]);

        selectedLanguage[index] = -1;
      } else {
        selectedLanguage[index] = languageList[index].id ?? -1;
        language.add(languageList[index].id ?? -1);
      }
    }
    else if (key == 1) {
      print("${selectedGenre[index]} == ${genreList[index].id} && ${category.contains(selectedGenre[index])}");
      if ((selectedGenre[index] == genreList[index].id) &&
          category.contains(selectedGenre[index])) {
        category.remove(selectedGenre[index]);


        selectedGenre[index] = -1;
      } else {
        selectedGenre[index] = genreList[index].id ?? -1;
        category.add(genreList[index].id ?? -1);
      }
    } else if (key == 2) {
      if ((selectedEnglishAssent[index] == englishAccentList[index].id) &&
          englishAssent.contains(selectedEnglishAssent[index])) {
        englishAssent.remove(selectedEnglishAssent[index]);
        selectedEnglishAssent[index] = -1;
      } else {
        selectedEnglishAssent[index] = englishAccentList[index].id ?? -1;
        englishAssent.add(englishAccentList[index].id ?? -1);
      }
    } else if (key == 3) {
      if ((selectedLevel[index] == levelList[index].id) &&
          level.contains(selectedLevel[index])) {
        level.remove(selectedLevel[index]);
        selectedLevel[index] = -1;
      } else {
        selectedLevel[index] = levelList[index].id ?? -1;
        level.add(levelList[index].id ?? -1);
      }
    }else if (key == 4) {
      if ((selectedLength[index] == lengthList[index].id) &&
          length.contains(selectedLength[index])) {
        length.remove(selectedLength[index]);
        selectedLength[index] = -1;
      } else {
        selectedLength[index] = lengthList[index].id ?? -1;
        length.add(lengthList[index].id ?? -1);
      }
    }

    categoryValue = category.toString().replaceAll("]", "");
    categoryValue = categoryValue.toString().replaceAll("[", "");

    englishAssentValue = englishAssent.toString().replaceAll("]", "");
    englishAssentValue = englishAssentValue.toString().replaceAll("[", "");

    levelValue = level.toString().replaceAll("]", "");
    levelValue = levelValue.toString().replaceAll("[", "");

    languageValue = language.toString().replaceAll("]", "");
    languageValue = languageValue.toString().replaceAll("[", "");

    lengthValue = length.toString().replaceAll("]", "");
    lengthValue = lengthValue.toString().replaceAll("[", "");

  }



  void clickOnSearchKeyBordButton({required String value}) async {
    CM.unFocsKeyBoard();
    if (bookList.isNotEmpty) {
      inAsyncCall.value = true;
      String tag = CM.getRandomNumber();
      Get.put(BookDetailController(), tag: tag);
      await Navigator.of(Get.context!).push(
        MaterialPageRoute(
          builder: (context) => BookDetailView(
              tag: tag,
              showbookto: bookList[0].showbookto.toString(),
              bookId: bookList[0].id.toString(),
              categoryId: bookList[0].category,
              isLiked: getDataNewReleaseBook.value?.favorite
                      ?.contains(bookList[0].id.toString()) ??
                  false),
        ),
      );
      await Get.delete<BookDetailController>(tag: tag);
      inAsyncCall.value = false;
    }
  }

  void clearFilter() {
    int i = 0;
    int j = 0;
    int k = 0;
    int l = 0;
    int m = 0;
    // ignore: unused_local_variable
    for (var element in selectedCategory) {
      selectedCategory[i] = -1;
      i++;
    }
    // ignore: unused_local_variable
    for (var element in selectedEnglishAssent) {
      selectedEnglishAssent[j] = -1;
      j++;
    }
    // ignore: unused_local_variable
    for (var element in selectedLevel) {
      selectedLevel[k] = -1;
      k++;
    }
    // ignore: unused_local_variable
    for (var element in selectedLanguage) {
      selectedLanguage[l] = -1;
      l++;
    }
    // ignore: unused_local_variable
    for (var element in selectedLength) {
      selectedLength[m] = -1;
      m++;
    }

    category = [];
    englishAssent = [];
    level = [];
    language = [];
    length = [];
    categoryValue = "";
    englishAssentValue = "";
    levelValue = "";
    languageValue = "";
    lengthValue = "";
  }

  Future<void> clickOnClearFilterButton() async {
    increment();
    clearFilter();
    Get.back();
    responseCode.value = 0;
    loaderForSearch.value = true;
    await getSearchBookDataApiCalling();
  }

  Future<void> clickOnApplyFilterButton() async {
    Get.back();
    responseCode.value = 0;
    loaderForSearch.value = true;
    await getSearchBookDataApiCalling();
  }
}
