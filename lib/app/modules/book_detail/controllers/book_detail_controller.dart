import 'dart:convert';
import 'dart:io';

/*
import 'package:admob_flutter/admob_flutter.dart';
*/
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/addmob_helper/addmob_helper.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/all_reviews/controllers/all_reviews_controller.dart';
import 'package:woo_english/app/modules/all_reviews/views/all_reviews_view.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/book_list/controllers/book_list_controller.dart';
import 'package:woo_english/app/modules/book_list/views/book_list_view.dart';
import 'package:woo_english/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:woo_english/app/modules/feedback/views/feedback_view.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/modules/read_book/controllers/read_book_controller.dart';
import 'package:woo_english/app/modules/read_book/views/read_book_view.dart';
import 'package:woo_english/app/modules/video_book/controllers/video_book_controller.dart';
import 'package:woo_english/app/modules/video_book/views/video_book_view.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/firebase/firebase_login_method.dart';

import '../../../../services/ad_mob_services.dart';
import '../../../api/api_model/get_dashboard_data_model.dart';

class BookDetailController extends AppController  {
  int intValue = 1;
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  final isLiked = false.obs;
  final isVideo = true.obs;
  String id = "";
  TextEditingController reviewController = TextEditingController();

  bool like = false;
  String? userName;
  String? userProfile;
  String bookId = "";
  final responseCode = 0.obs;
  Map<String, dynamic> queryParametersForBookDetail = {};
  final getBookDetailDataModel = Rxn<GetDashBoardBooksModel>();
  List<Reviews> reviewsList = [];

  String categoryId = "";
  final responseCodeSimilarBook = 0.obs;
  final getSimilarBookModel = Rxn<GetDashBoardBooksModel>();
  List<Books> bookList = [];
  Map<String, dynamic> queryParametersForSimilarBooks = {};

  Map<String, dynamic> bodyParamsForBookLikeUnlike = {};
  Map<String, dynamic> bodyParamsForAddViewCountApi = {};

  String rating = "4.5";
  Map<String, dynamic> bodyParamsForPostReview = {};
  static Map<String, String> params = Get.arguments;

  /*AdmobBannerSize? bannerSize;
  late AdmobInterstitial interstitialAd;*/

 // BannerAd? bannerAd;

  final addLoadSuccess=false.obs;
  RxBool isload = false.obs;
BannerAd? bannerAd;
  InterstitialAd? interstitialAd;


  @override
  void onInit() async{
    super.onInit();




    await loadBanner();
    await loadIndustrial();





    onReload();

  }
  @override
  void dispose() {
    // TODO: Dispose a BannerAd object

    bannerAd?.dispose();



    super.dispose();
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
          screens == Screens.bookDetail) {
        load++;
        await myOnInit();
      } else {
        load = 0;
      }
    });
  }
Future<void>loadBanner()async{
  bannerAd =  BannerAd(

    adUnitId: AdHelper.bannerAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      onAdLoaded: (ad) {


        isload.value = true;
        print(' Success to ** load a banner');


        // bannerAd = ad as BannerAd;

      },
      onAdFailedToLoad: (ad, err) {
        print('Failed to load @@ a banner ad: ${err.message}');

        // print('+++______________+$params');

        ad.dispose();
      },
    ),
  );
  bannerAd!.load();


  }
  Future<void>loadIndustrial()async{


    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));




  }

  Future<void> onRefresh() async {
    await myOnInit();
  }

  void increment() => count.value++;

  Future<void> myOnInit() async {

    screens = Screens.bookDetail;
    inAsyncCall.value = true;
   /* bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId: getInterstitialAdUnitId()!,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );*/
/*
    interstitialAd.load();
*/
/*   await BannerAd(
     adUnitId: AdMobHelper.bannerAdUnitId,
     request: AdRequest(),
     size: AdSize.banner,
     listener: BannerAdListener(
       onAdLoaded: (ad) {
         addLoadSuccess.value=true;
           bannerAd = ad as BannerAd;
       },
       onAdFailedToLoad: (ad, err) {
         print('Failed to load a banner ad: ${err.message}');
         print('Failed to load a banner ad: ${ad.adUnitId}');
         ad.dispose();
       },
     ),
   ).load();*/
    userName = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnName);
    userProfile = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnUserImage);
    isLiked.value = like;
    if (await CM.internetConnectionCheckerMethod()) {
      await getBookDetailApiCalling();
    }
    inAsyncCall.value = false;
    if (await CM.internetConnectionCheckerMethod()) {
      await getSimilarBooksApiCalling();
      await addViewCountApiCalling();
    }
  }

  String? getInterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-9747725006209280/3853081805';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-9747725006209280/5353865734';
    }
    return null;
  }

  Future<void> getBookDetailApiCalling() async {
    queryParametersForBookDetail = {ApiKey.bookId: bookId};
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetBookDetail,
        queryParameters: queryParametersForBookDetail);
    responseCode.value = response?.statusCode ?? 0;
    queryParametersForBookDetail.clear();
    if (CM.responseCheckForGetMethod(response: response)) {
      getBookDetailDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      isVideo.value = getBookDetailDataModel.value?.book?.video != null;
      reviewsList = getBookDetailDataModel.value?.reviews ?? [];
      isLiked.value = getBookDetailDataModel.value?.isFavorite == 1;
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

  Future<bool> addViewCountApiCalling() async {
    bodyParamsForAddViewCountApi = {
      ApiKey.bookId: bookId,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointAddViewCountApi,
        bodyParams: bodyParamsForAddViewCountApi);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForAddViewCountApi.clear();
      return true;
    } else {
      bodyParamsForAddViewCountApi.clear();
      return false;
    }
  }

  Future<bool> postReviewApiCalling() async {
    bodyParamsForPostReview = {
      ApiKey.bookId: bookId,
      ApiKey.review: reviewController.text,
      ApiKey.rating: rating,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointPostUserReview,
        bodyParams: bodyParamsForPostReview);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForPostReview.clear();
      return true;
    } else {
      bodyParamsForPostReview.clear();
      return false;
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

/*  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic>? args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                return true;
              },
              child: AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Reward callback fired. Thanks Andrew!'),
                    Text('Type: ${args!['type']}'),
                    Text('Amount: ${args['amount']}'),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
    }
  }*/

  void showSnackBar(String content) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }


  clickOnBackButton() async {
    CM.unFocsKeyBoard();

    inAsyncCall.value = true;
    if (AppController.routes == C.not) {
      AppController.routes = C.yes;

      await Get.offAllNamed(Routes.NAVIGATOR);
    } else {
      Get.back();
    }

    inAsyncCall.value = false;
  }

  Future<void> clickOnInfoButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(FeedbackController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => FeedbackView(
          tag: tag,
        ),
      ),
    );
    await Get.delete<FeedbackController>(tag: tag);
    screens = Screens.bookDetail;
    inAsyncCall.value = false;
  }

  Future<void> clickOnLikeAppBarButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    if (await bookLikeUnlikeApiCalling()) {
      isLiked.value = !isLiked.value;
      if (isLiked.value) {
        getBookDetailDataModel.value?.favoriteCount =
            getBookDetailDataModel.value!.favoriteCount! + 1;
      } else {
        getBookDetailDataModel.value?.favoriteCount =
            getBookDetailDataModel.value!.favoriteCount! - 1;
      }
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnShareButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    await FirebaseMethod.instance.shareDynamicLink(routes: C.books,bookId:bookId,categoryId:categoryId );
    inAsyncCall.value = false;
  }

  Future<void> clickOnSeeMoreReview() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(AllReviewsController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => AllReviewsView(
          tag: tag,
          bookId: bookId,
        ),
      ),
    );
    await Get.delete<AllReviewsController>(tag: tag);
    await getBookDetailApiCalling();
    inAsyncCall.value = false;
  }

  Future<void> clickOnSubmitButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    if (await postReviewApiCalling()) {
      reviewController.text = "";
      await getBookDetailApiCalling();
    }
   /* if (reviewController.text.isNotEmpty) {

    } else {
      CM.showToast("Please write review!");
    }*/
    inAsyncCall.value = false;
  }

  void onRattingUpdate({required double rating}) {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    this.rating = rating.toString();
    inAsyncCall.value = false;
  }

  Future<void> clickOnSeeMoreBooks({required String id}) async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(BookListController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) =>
            BookListView(tag: tag, title: id, categoryId: categoryId),
      ),
    );
    await Get.delete<BookListController>(tag: tag);
    await getBookDetailApiCalling();
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularBookForList({
    required int index,
  }) async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
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
    await getBookDetailApiCalling();
    inAsyncCall.value = false;
  }

  void clickOnSoundButton({required int index}) {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  void clickOnLikeButton({required int index}) {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    inAsyncCall.value = false;
  }

  Future<void> clickOnReadAndListenButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(ReadBookController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => ReadBookView(
          tag: tag,
          isBookmark: getBookDetailDataModel.value?.isBookmark == 1,
          bookId: bookId,
          isLiked: isLiked.value,
        ),
      ),
    );
    await Get.delete<ReadBookController>(tag: tag);
    await getBookDetailApiCalling();
    inAsyncCall.value = false;
  }

  Future<void> clickOnVideoButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(VideoBookController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => VideoBookView(
          tag: tag,
          bookId: bookId,
          categoryId: categoryId,
          isLiked: isLiked.value,
        ),
      ),
    );
    await Get.delete<VideoBookController>(tag: tag);
    await getBookDetailApiCalling();
    inAsyncCall.value = false;
  }
}
