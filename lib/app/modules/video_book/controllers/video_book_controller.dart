import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/book_list/controllers/book_list_controller.dart';
import 'package:woo_english/app/modules/book_list/views/book_list_view.dart';
import 'package:woo_english/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/firebase/firebase_login_method.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../feedback/views/feedback_view.dart';

class VideoBookController extends AppController {
  int intValue = 1;
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load=0;
  String bookId = "";
  String categoryId = "";
  bool like = false;

  int videoLoad=0;
  final isLiked = false.obs;
  String id = "";
  String videoId ="";
  late YoutubePlayerController videoController ;

  Map<String, dynamic> bodyParamsForBookLikeUnlike = {};

  final responseCode = 0.obs;
  final getVideoBook = Rxn<GetDashBoardBooksModel>();
  Map<String, dynamic> queryParametersForVideoBook = {};

  final responseCodeSimilarBook = 0.obs;
  final getSimilarBookModel = Rxn<GetDashBoardBooksModel>();
  List<Books> bookList = [];
  Map<String, dynamic> queryParametersForSimilarBooks = {};

  Map<String, dynamic> bodyParamsForAddViewBook = {};


  @override
  void onInit() {
    super.onInit();
    screens=Screens.videoScreen;
    onReload();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    super.onClose();
    videoController.pause();
    await CM.setScreenPortraitMode();
  }

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod()&&load==0 && screens==Screens.videoScreen) {
        load++;
        await myOnInit();
      } else {
        load=0;
      }
    });
  }

  Future<void> onRefresh() async {
    await myOnInit();
  }

  Future<void> myOnInit() async {
    if (videoLoad == 0)
      {
        inAsyncCall.value = true;
      }
    isLiked.value = like;
   if(await CM.internetConnectionCheckerMethod())
     {
       await addViewBookApiCalling();
       await getVideoBooksApiCalling();
       inAsyncCall.value = false;
       if(videoLoad==0)
       {
         videoId=YoutubePlayer.convertUrlToId(getVideoBook.value?.book?.video??"")!;
         videoController=YoutubePlayerController(
           initialVideoId: YoutubePlayer.convertUrlToId(videoId)!,
           flags: const YoutubePlayerFlags(

           ),
         );
         videoLoad++;
       }

       await getSimilarBooksApiCalling();
       videoController.play();
     }
  }

  void increment() => count.value++;

  Future<void> getVideoBooksApiCalling() async {
    queryParametersForVideoBook = {
      ApiKey.bookId:bookId,
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetVideoBook,
        queryParameters: queryParametersForVideoBook);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForVideoBook.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getVideoBook.value = GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
    }
  }

  Future<void> getSimilarBooksApiCalling() async {
    queryParametersForSimilarBooks = {
      ApiKey.categoryId: categoryId,
      ApiKey.inBookDetails: "1",
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetSimilarBook,
        queryParameters: queryParametersForSimilarBooks);
    responseCodeSimilarBook.value = response?.statusCode ?? 0;
    queryParametersForSimilarBooks.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getSimilarBookModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      bookList = getSimilarBookModel.value?.books ?? [];
    }
  }

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

  Future<bool> addViewBookApiCalling() async {
    bodyParamsForAddViewBook = {
      ApiKey.bookId: bookId,
      ApiKey.video:"yes",
    };

    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointAddViewBook,
        bodyParams: bodyParamsForAddViewBook);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForAddViewBook.clear();
      return true;
    } else {
      bodyParamsForAddViewBook.clear();
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

  Future<void> clickOnInFoButton() async {
    videoController.pause();
    await CM.setScreenPortraitMode();
    String tag = CM.getRandomNumber();
    Get.put(FeedbackController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => FeedbackView(
          tag: tag,),
      ),
    );
    await Get.delete<FeedbackController>(tag: tag);
    screens = Screens.videoScreen;
  }


  Future<void> clickOnLikeAppBarButton() async {
    inAsyncCall.value = true;
    if (await bookLikeUnlikeApiCalling()) {
      isLiked.value = !isLiked.value;
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnShareButton() async {
    inAsyncCall.value = true;
    await FirebaseMethod.instance.shareDynamicLink(routes: C.video,bookId:bookId,categoryId:categoryId );
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBookForList({required int index}) async {
    videoController.pause();
    await CM.setScreenPortraitMode();
    String tag = CM.getRandomNumber();
    Get.put(BookDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookDetailView(
          tag: tag,
          bookId: bookList[index].id.toString(),
          categoryId: bookList[index].category.toString(),
          isLiked: getSimilarBookModel.value?.favorite
              ?.contains(bookList[index].id.toString()),
        ),
      ),
    );
    await Get.delete<BookDetailController>(tag: tag);
     videoController.play();
    await getSimilarBooksApiCalling();
  }

  void clickOnSoundButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnLikeButton({required int index}) {
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  Future<void> clickOnSeeMoreBooks({required String id}) async {
    videoController.pause();
    await CM.setScreenPortraitMode();

    String tag = CM.getRandomNumber();
    Get.put(BookListController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => BookListView(tag: tag, title: id,categoryId: categoryId),
      ),
    );
    await Get.delete<BookListController>(tag: tag);
    videoController.play();
    await getSimilarBooksApiCalling();
  }

}
