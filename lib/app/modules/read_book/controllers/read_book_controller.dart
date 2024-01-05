import 'dart:convert';
import 'package:audioplayers/audioplayers.dart' as mainAudioPlayer;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/api/api_model/get_dictionary_model.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/modules/quiz_detail/controllers/quiz_detail_controller.dart';
import 'package:woo_english/app/modules/quiz_detail/views/quiz_detail_view.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/firebase/firebase_login_method.dart';
import 'package:woo_english/main.dart';
import '../../feedback/views/feedback_view.dart';
import '../../splash/controllers/splash_controller.dart';
import '../views/read_book_view.dart';


class ReadBookController extends AppController with WidgetsBindingObserver {
  int intValue = 1;
  final count = 0.obs;
  //final isAudioPlaying = '1'.obs;
  final inAsyncCall = false.obs;

  final isLastPage = false.obs;
  final modeValue = false.obs;
  RxInt popupValue = 4.obs;
  RxInt quizpopupvalue = 0.obs;
  RxBool isBGColorSelected = false.obs;
  final value = 3.0.obs;
  final clickOnAudioSpeed = false.obs;
  RxBool isDarkMode = false.obs;
  int audioPlayerLoad = 0;
  String id = "";
  String bookId = "";
  String chapterId = "";
  bool bookmark = false;
  final haveAudio = false.obs;
  String audioUrl = "";

  var selectedValue = 'Option 1'; // Default selected value

  List<BankListDataModel> bankDataList = [
    BankListDataModel("Bg 1".obs, C.imageBG1.obs),
    BankListDataModel("Bg 2".obs, C.imageBG2.obs),
    BankListDataModel("Bg 3".obs, C.imageBG3.obs),
    BankListDataModel("Bg 4".obs, C.imageBG4.obs),
    BankListDataModel("Bg 5".obs, C.imageBG5.obs),
    BankListDataModel("Bg 6".obs, C.imageBG6.obs),
    BankListDataModel("Bg 7".obs, C.imageBG7.obs),
    BankListDataModel("Bg 8".obs, C.imageBG8.obs),
    BankListDataModel("Bg 9".obs, C.imageBG9.obs),
    BankListDataModel("Bg 10".obs, C.imageBG10.obs),
  ];

  void onDropDownItemSelected(BankListDataModel newSelectedBank) {
    isBGColorSelected.value = false;
    backGroundColor.value = Colors.transparent;
    bankChoose.value = newSelectedBank;

    print('djkfhddjkfhk' + bankChoose.value.bank_logo.value);
  }

  Rx<BankListDataModel> bankChoose = BankListDataModel(''.obs, ''.obs).obs;
  List<TextEditingController> controllerList = [];
  RxList<DropdownMenuItem<FontStyle>> listFontStyle = [
    DropdownMenuItem(
      child: Text('normal'),
      value: FontStyle.normal,
    ),
    DropdownMenuItem(
      child: Text('italic'),
      value: FontStyle.italic,
    )
  ].obs;
  RxList<DropdownMenuItem<String>> listFontFamily = [
    DropdownMenuItem(
      child: Text(C.fontArial),
      value: C.fontArial,
    ),
    DropdownMenuItem(
      child: Text(C.fontTimes_New_Roman),
      value: C.fontTimes_New_Roman,
    ),
    DropdownMenuItem(
      child: Text(C.fontgeorgia),
      value: C.fontgeorgia,
    ),
    DropdownMenuItem(
      child: Text(C.fontVerdana),
      value: C.fontVerdana,
    ),
  ].obs;
  RxList<DropdownMenuItem<String>> imageUrlList = [
    DropdownMenuItem(
      child: Text('https://english-e-reader.net/images/reader/1.png'),
      value: C.fontArial,
    ),
    DropdownMenuItem(
      child: Text('https://english-e-reader.net/images/reader/1.png'),
      value: C.fontInter,
    ),
    DropdownMenuItem(
      child: Text('https://english-e-reader.net/images/reader/1.png'),
      value: C.fontLato,
    ),
  ].obs;
// RxList<String> imageUrlList = [
//     'assets/images/Admob.jpg',
//     'assets/images/Admob.jpg',
//     'assets/images/Admob.jpg',
//
//     // 'https://english-e-reader.net/images/reader/1.png',
//     // 'https://english-e-reader.net/images/reader/1.png',
//     // 'https://english-e-reader.net/images/reader/1.png',
//
//   ].obs;

  RxList<DropdownMenuItem<TextAlign>> listTextAlign = [
    DropdownMenuItem(
      child: Text('left'),
      value: TextAlign.left,
    ),
    DropdownMenuItem(
      child: Text('center'),
      value: TextAlign.center,
    ),
    DropdownMenuItem(
      child: Text('right'),
      value: TextAlign.right,
    )
  ].obs;

  final isBookmark = false.obs;
  final isZoom = false.obs;
  final isCommentHidden = false.obs;
  final isShowMusicPlayer = true.obs;
  final selectedChapter = "".obs;
  final selectedChapterId = 0.obs;
  var setFontStyle = FontStyle.normal.obs;
  var setTextAlign = TextAlign.left.obs;
  var setImage = 'fontOpenSans'.obs;
  var setFontFamily = C.fontArial.obs;
  var setBGImage = 'fontOpenSans'.obs;
  final selectedChapterContent = "".obs;
  final selectedChapterObject = Rxn<Chapters?>();
  final isPlaying = false.obs;
  final audioPlayed = false.obs;
  final currentPos = 0.obs;
  final currentPositionLabel = "00:00".obs;
  final setPlaybackRateValue = 1.0.obs;
  int maxDuration = 100;
  int onchangeValue = 0;
  late Uint8List audioBytes;
  AudioPlayer player = AudioPlayer();
  int forwordBackWordValue = 10;
  final selectedMenu = 1.0.obs;
  final isMute = false.obs;
  final volumeListenerValue = 0.0.obs;
  final getVolume = 0.0.obs;
  String dAudioUrl = "";
  Map<String, dynamic> bodyParamsForBookmarkAddRemove = {};

  final responseCode = 0.obs;
  Map<String, dynamic> queryParametersForGetChapters = {};
  final getDataModel = Rxn<GetDashBoardBooksModel>();
  List<Chapters> chapterList = [];
  List<String> bookmarkList = [];
  String limit = "10";
  int offset = 0;
  Map<String, dynamic> bodyParamsForAddViewBook = {};
  final selectFontSize = 13.00.obs;

  final isMamber = true.obs;
  final wantScrollBackButton = false.obs;
  final responseCodeQuiz = 0.obs;
  Map<String, dynamic> queryParametersForQuiz = {};
  final getDataModelForQuiz = Rxn<GetDashBoardBooksModel>();
  List<Books> quizList = [];
  String quizLimit = "10";
  int quizOffset = 0;
  final textColor = Colors.black.obs;
  final Rx<Color> backGroundColor = Color(0xffffffff).obs;

  Map<String, dynamic> bodyParamsForSubmitQuestionAnswerApi = {};

  Map<String, dynamic> bodyParamsForAddFinishedBookApi = {};

  ScrollController scrollController = ScrollController();
  final responseCodeQuizReply = 0.obs;
  Map<String, dynamic> queryParametersForQuizReply = {};
  final getDataModelForQuizReply = Rxn<GetDashBoardBooksModel>();
  List<Books> quizReplyList = [];
  String quizReplyLimit = "10";
  int quizReplyOffset = 0;
  bool isLiked = false;

  changeTextColor(color) {
    textColor.value = color;
    print("@@@@@@@@@@@T$textColor");
  }

  changeTextFontStyle(value) {
    print(value);

    setFontStyle.value = value;

    print(setFontStyle.value);
  }

  changeBGImage(value) {
    setImage.value = value;
  }

// Chnages in Text Alignment
  changeTextAlignment(value) {
    print(value);

    setTextAlign.value = value;
  }

  // Chnages in Font Family
  changeFontFamily(value) {
    print(value);

    setFontFamily.value = value;
  }

  changeFontSize(value) {
    selectFontSize.value = value;
  }

  void clickOnGetPremium() {
    inAsyncCall.value = true;

    Get.toNamed(Routes.SUBSCRIPTION);

    inAsyncCall.value = false;
  }

  changeBackgroundColor(color) {
    isBGColorSelected.value = true;
    backGroundColor.value = color;
    print(backGroundColor.value);
  }

  final responseCodeDictionary = 0.obs;
  D? dictionary;
  String audio = "";
  String example = "";

  Map<String, dynamic> queryParametersForDarkModeOnOff = {};

  final audioPlayerMain = mainAudioPlayer.AudioPlayer();

  @override
  Future<void> onInit() async {
    super.onInit();
    print(' ++++++++++++++++++++++${isDarkMode.value}');
    bankChoose.value = bankDataList[0];
    await getPopupKey();
    await getPlayerKey();
    print('---------------${await player.playing}');
    WidgetsBinding.instance?.addObserver(this);

/*
    onReload();
*/
  }

  @override
  void onReady() {
    player.stop();
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    if (isPlaying.value && audioPlayed.value) {}
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (isUserSubscribed == null)       await player.pause();

    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      if (isUserSubscribed == null) player.stop();
    }
  }

  @override
  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    player.stop();
    player.dispose();
    super.dispose();

    WidgetsBinding.instance?.removeObserver(this);
  }

  /*  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod()) {
        onInit();
      } else {}
    });
  }*/


  Future<bool> onLoadMore() async {
    if (selectedChapter.value == "Quiz") {
      quizReplyOffset = quizReplyOffset + 10;
      await getQuizReplyForBook();
      increment();
      return true;
    } else {
      return false;
    }
  }

  Future<void> onRefresh() async {
    await myOnInit();
  }

  Future<void> myOnInit() async {
    bankChoose.value = bankDataList[0];
    isDarkMode.value = await DatabaseHelper.databaseHelperInstance
            .getParticularData(key: DatabaseConst.columnMode) ==
        "1";
    modeValue.value = await DatabaseHelper.databaseHelperInstance
            .getParticularData(key: DatabaseConst.columnMode) ==
        "1";
    isMamber.value = await DatabaseHelper.databaseHelperInstance
            .getParticularData(key: DatabaseConst.columnStatus) ==
        "active";
    inAsyncCall.value = true;
    isBookmark.value = bookmark;
    if (await CM.internetConnectionCheckerMethod()) {
      await getChaptersApiCalling();
      if (chapterList.isNotEmpty) {
        if (chapterId.isNotEmpty) {
          for (var element in chapterList) {
            if (chapterId == element.id.toString()) {
              await addViewBookApiCalling(chapter: element.chapterNo ?? '');
            }
          }
        } else {
          await addViewBookApiCalling(chapter: '1');
        }
      }
    }
    inAsyncCall.value = false;
    player.durationStream.listen((Duration? d) {
      maxDuration = d?.inMilliseconds ?? 0;
    });

    player.positionStream.listen((Duration p) async {
      if (player.playing) {
        isPlaying.value = true;
        audioPlayed.value = true;
      } else {
        isPlaying.value = false;
      }
      currentPos.value = p.inMilliseconds;
      int sHours = Duration(milliseconds: currentPos.value).inHours;
      int sMinutes = Duration(milliseconds: currentPos.value).inMinutes;
      int sSeconds = Duration(milliseconds: currentPos.value).inSeconds;
      int rHours = sHours;
      int rMinutes = sMinutes - (sHours * 60);
      int rSeconds = sSeconds - (sMinutes * 60 + sHours * 60 * 60);
      currentPositionLabel.value =
          "${(rHours <= 9) ? '0$rHours' : '$rHours'}:${(rMinutes <= 9) ? '0$rMinutes' : '$rMinutes'}:${(rSeconds <= 9) ? '0$rSeconds' : '$rSeconds'}";
    });

    player.processingStateStream.listen((event) async {
      if (event == ProcessingState.completed) {
        await player.pause();
        isPlaying.value = false;
        audioPlayed.value = false;
        currentPos.value = 0;
        currentPositionLabel.value = "00:00";
      }
    });

    if (await CM.internetConnectionCheckerMethod() && audioPlayerLoad == 0) {
      VolumeController().listener((volume) async {
        volumeListenerValue.value = volume;
        getVolume.value = await VolumeController().getVolume();
      });
      audioPlayerLoad++;
    }
  }

  Future<void> showMediaPlayerNotification(String title, String artist) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
      channelShowBadge: false,
      playSound: false,
      enableVibration: false,
      styleInformation: MediaStyleInformation(),
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      artist,
      platformChannelSpecifics,
      payload: 'media_player',
    );
  }

  Future<void> setPopupKey(key) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('popup', key);
    print('set popup key');
  }

  Future<void> getPopupKey() async {
    print('Popup running');
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.get('popup');

    popupvalue = key;

    print('YOUR Popup read book  - $popupvalue');
    print('YOUR USER KEY - $Key');
  }

  Future<void> getChaptersApiCalling() async {
    queryParametersForGetChapters = {
      ApiKey.bookId: bookId,
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetReadListen,
        queryParameters: queryParametersForGetChapters);
    queryParametersForGetChapters.clear();
    responseCode.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModel.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataModel.value != null &&
          getDataModel.value?.chapters != null &&
          getDataModel.value!.chapters!.isNotEmpty) {
        chapterList = getDataModel.value?.chapters ?? [];
        bookmarkList = getDataModel.value?.bookmark ?? [];
        if (chapterList.isNotEmpty) {
          if (chapterId.isEmpty) {
            isBookmark.value =
                bookmarkList.contains(chapterList[0].id.toString());
            if (chapterList[0].audio != null) {
              await player.seek(const Duration(milliseconds: 0));
              player.pause();
              haveAudio.value = true;
              audioUrl = chapterList[0].audio ?? "";
            } else {
              haveAudio.value = false;
            }
            selectedChapterObject.value = chapterList[0];
            selectedChapter.value = chapterList[0].chapterName ?? '';
            selectedChapterId.value = chapterList[0].id ?? 0;
            selectedChapterContent.value =
                chapterList[0].chapterDescription ?? '';
          } else {
            for (var element in chapterList) {
              if (element.id.toString() == chapterId) {
                isBookmark.value = bookmarkList.contains(element.id.toString());

                if (element.audio != null) {
                  await player.seek(const Duration(milliseconds: 0));
                  player.pause();
                  haveAudio.value = true;
                  audioUrl = element.audio ?? "";
                } else {
                  haveAudio.value = false;
                }
                selectedChapterObject.value = element;
                selectedChapter.value = element.chapterName ?? '';
                selectedChapterId.value = element.id ?? 0;
                selectedChapterContent.value = element.chapterDescription ?? '';
              }
            }
          }
        }
        if (getDataModel.value?.isQuiz != null &&
            getDataModel.value?.isQuiz != 0) {
          chapterList.add(Chapters(
            bookId: bookId,
            chapterName: "Quiz",
            id: -1,
          ));
        }
      }
    }
  }

  Future<bool> bookMarkAddRemoveApiCalling() async {
    bodyParamsForBookmarkAddRemove = {
      ApiKey.bookId: bookId,
      ApiKey.chapterId: selectedChapterId.value.toString(),
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointAddBookMark,
        bodyParams: bodyParamsForBookmarkAddRemove);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForBookmarkAddRemove.clear();
      return true;
    } else {
      bodyParamsForBookmarkAddRemove.clear();
      return false;
    }
  }

  Future<bool> addViewBookApiCalling({required String chapter}) async {
    bodyParamsForAddViewBook = {ApiKey.bookId: bookId, ApiKey.chapter: chapter};
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

  Future<void> getQuizForBook() async {
    queryParametersForQuiz = {
      ApiKey.bookId: bookId,
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetQuiz,
        queryParameters: queryParametersForQuiz);
    queryParametersForQuiz.clear();
    responseCodeQuiz.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      getDataModelForQuiz.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataModelForQuiz.value != null &&
          getDataModelForQuiz.value?.quiz != null &&
          getDataModelForQuiz.value!.quiz!.isNotEmpty) {
        getDataModelForQuiz.value?.quiz?.forEach((element) {
          quizList.add(element);
          TextEditingController controller = TextEditingController();
          controllerList.add(controller);
        });
      }
    }
  }

  Future<bool> submitQuestionAnswerApiCalling() async {
    List<String> questionArray = [];
    for (var element in quizList) {
      questionArray.add(element.question ?? "");
    }
    List<String> answerArray = [];
    for (var element in controllerList) {
      answerArray.add(element.text.trim().toString());
    }

    String question = questionArray.toString().replaceAll("[", "");
    question = question.toString().replaceAll("]", "");
    String answer = answerArray.toString().replaceAll("[", "");
    answer = answer.toString().replaceAll("]", "");

    bodyParamsForSubmitQuestionAnswerApi = {
      ApiKey.bookId: bookId,
      ApiKey.question: jsonEncode(question),
      ApiKey.answer: jsonEncode(answer),
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointSubmitQuizAnswer,
        bodyParams: bodyParamsForSubmitQuestionAnswerApi);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForSubmitQuestionAnswerApi.clear();
      return true;
    } else {
      bodyParamsForSubmitQuestionAnswerApi.clear();
      return false;
    }
  }

  Future<bool> finishBookApiCalling() async {
    bodyParamsForAddFinishedBookApi = {
      ApiKey.bookId: bookId,
    };
    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointAddFinishedBook,
        bodyParams: bodyParamsForAddFinishedBookApi);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForAddFinishedBookApi.clear();
      return true;
    } else {
      bodyParamsForAddFinishedBookApi.clear();
      return false;
    }
  }

  Future<void> getQuizReplyForBook() async {
    queryParametersForQuizReply = {
      ApiKey.bookId: bookId,
      ApiKey.limit: quizReplyLimit,
      ApiKey.offset: quizReplyOffset.toString(),
    };
    http.Response? response = await HttpMethod.instance.getRequestForParams(
        baseUriForParams: UriConstant.baseUriForParams,
        endPointUri: UriConstant.endPointGetQuizReply,
        queryParameters: queryParametersForQuizReply);
    queryParametersForQuizReply.clear();
    responseCodeQuizReply.value = response?.statusCode ?? 0;
    if (CM.responseCheckForGetMethod(response: response)) {
      if (quizReplyOffset == 0) {
        quizReplyList.clear();
      }
      getDataModelForQuizReply.value =
          GetDashBoardBooksModel.fromJson(jsonDecode(response?.body ?? ""));
      if (getDataModelForQuizReply.value != null &&
          getDataModelForQuizReply.value?.quiz != null &&
          getDataModelForQuizReply.value!.quiz!.isNotEmpty) {
        isLastPage.value = false;

        getDataModelForQuizReply.value?.quiz?.forEach((element) {
          quizReplyList.add(element);
        });
      } else {
        if (quizReplyOffset != 0) {
          isLastPage.value = true;
        }
      }
    }
  }

  Future<void> getDictionaryApiCalling({required String value}) async {
    http.Response? response = await HttpMethod.instance
        .getRequest(url: "${UriConstant.endPointDictionaryApi}$value");
    responseCodeDictionary.value = response?.statusCode ?? 0;
    List<dynamic> map = [];
    try {
      map = jsonDecode(response?.body ?? "");
    } catch (e) {
      responseCodeDictionary.value == 100;
    }

    Map<String, dynamic> test = {};
    test = {"d": map};
    String te = jsonEncode(test);

    dictionary = D.fromJson(jsonDecode(te));
    if (dictionary != null &&
        dictionary?.listOfDictionary != null &&
        dictionary!.listOfDictionary!.isNotEmpty &&
        dictionary?.listOfDictionary?[0].phonetics != null &&
        dictionary!.listOfDictionary![0].phonetics!.isNotEmpty) {
      dictionary?.listOfDictionary?[0].phonetics?.forEach((element) {
        if (audio.isEmpty &&
            element.audio != null &&
            element.audio!.isNotEmpty) {
          audio = element.audio ?? '';
        }
      });
    }

    if (dictionary != null &&
        dictionary?.listOfDictionary != null &&
        dictionary!.listOfDictionary!.isNotEmpty &&
        dictionary?.listOfDictionary?[0].meanings != null &&
        dictionary!.listOfDictionary![0].meanings!.isNotEmpty) {
      dictionary?.listOfDictionary?[0].meanings?.forEach((element) {
        if (example.isEmpty &&
            element.definitions != null &&
            element.definitions!.isNotEmpty) {
          element.definitions?.forEach((element) {
            if (example.isEmpty &&
                element.example != null &&
                element.example!.isNotEmpty) {
              example = element.example ?? '';
            }
          });
        }
      });
    }
  }

  Future<bool> darkModeOnOffApiCalling() async {
    if (await CM.internetConnectionCheckerMethod()) {
      queryParametersForDarkModeOnOff = {
        ApiKey.mode: modeValue.value ? "0" : "1",
      };
      http.Response? response = await HttpMethod.instance.getRequestForParams(
          baseUriForParams: UriConstant.baseUriForParams,
          endPointUri: UriConstant.endPointDarkModeOnOff,
          queryParameters: queryParametersForDarkModeOnOff);
      if (CM.responseCheckForPostMethod(response: response)) {
        queryParametersForDarkModeOnOff.clear();
        return true;
      } else {
        queryParametersForDarkModeOnOff.clear();
        return false;
      }
    } else {
      queryParametersForDarkModeOnOff.clear();
      return false;
    }
  }

  void increment() => count.value++;

  clickOnBackButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    player.stop();
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
    screens = Screens.readAndListen;
    inAsyncCall.value = false;
  }

  Future<void> getPlayerKey() async {
    print('running');
    final prefs = await SharedPreferences.getInstance();
    // final key = prefs.get('player');

    // isAudioPlaying  = key;

    print('YOUR Audio KEY - $isAudioPlaying');
    print('YOUR Audio KEY - $Key');
  }

  Future<void> setPlayerpKey( key) async {

    final prefs = await SharedPreferences.getInstance();

    prefs.setString('player', key);
    print('set player $key');
  }

  Future<void> clickOnBookMarkButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    if (await bookMarkAddRemoveApiCalling()) {
      if (isBookmark.value) {
        bookmarkList.remove(selectedChapterId.value.toString());
        isBookmark.value = false;
      } else {
        bookmarkList.add(selectedChapterId.value.toString());
        isBookmark.value = true;
      }
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnShareButton() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    await FirebaseMethod.instance.shareDynamicLink(
      routes: C.chapters,
      bookId: bookId,
      chapterId: selectedChapterId.value.toString(),
    );
    inAsyncCall.value = false;
  }

  void clickOnMenuButton() {
    inAsyncCall.value = true;

    inAsyncCall.value = false;
  }

  void clickOnZoomButton() {
    inAsyncCall.value = true;
    isZoom.value = !isZoom.value;
    inAsyncCall.value = false;
  }

  Future<void> modeOnChange({required bool value}) async {
    inAsyncCall.value = true;
    try {
      if (await darkModeOnOffApiCalling()) {
        DatabaseHelper.databaseHelperInstance.updateParticularData(
            key: DatabaseConst.columnMode, val: modeValue.value ? "0" : "1");
        isDarkMode.value = modeValue.value ? false : true;
        modeValue.value = value;
      }
    } catch (e) {
      CM.error();
      inAsyncCall.value = false;
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnSubmitButton() async {
    CM.unFocsKeyBoard();

    inAsyncCall.value = true;
    if (await submitQuestionAnswerApiCalling()) {
      for (var element in controllerList) {
        element.text = "";
      }
      if (await finishBookApiCalling()) {
        quizReplyOffset = 0;
        await getQuizReplyForBook();
      }
    }
    inAsyncCall.value = false;
  }

  void clickOnCommentHideShowButton() {
    inAsyncCall.value = true;
    isCommentHidden.value = !isCommentHidden.value;
    inAsyncCall.value = false;
  }

  void clickOnEyeHideButton() {
    inAsyncCall.value = true;
    isShowMusicPlayer.value = !isShowMusicPlayer.value;
    inAsyncCall.value = false;
  }

  void clickOnPlayBackButton() async {
    inAsyncCall.value = true;
    await player.seek(Duration(
        milliseconds: currentPos.value > 10000
            ? currentPos.value - 10000
            : currentPos.value));
    inAsyncCall.value = false;
  }

  void clickOnPauseAndPlayButton() async {
    inAsyncCall.value = true;
    player.stop();

    print(">>>>${player.playing}");
    print("${audioPlayed}");
    print("${isPlaying.value}");


    if ((!isPlaying.value) && (!audioPlayed.value)) {
      await player.setAudioSource(AudioSource.uri(
        Uri.parse(CM.getImageUrl(value: audioUrl)),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: selectedChapterId.value.toString(),
          // Metadata to display in the notification:
          album: "WooEnglish",
          title: selectedChapter.value,
          artUri: Uri.parse(
             'https://yt3.googleusercontent.com/qMSrYxqjC6z3xn7hCSO0Psf6Oynyn5PoEyCPQS3QQ4VrisyNeEbe6Eh5qGbNzzPV43OqwGXJ=s176-c-k-c0x00ffffff-no-rj'),
        ),
      ));


   /*   if (player.playing == false &&  isAudioPlaying == '1') {
        print("audio is playing $audioPlayed $isPlaying");

        await player.pause();
        await player.play();
        await setPlayerpKey('1');

      } else {
        print("audio is not playing");
        player.stop();
      }*/
      isPlaying.value = true;
      audioPlayed.value = true;
      player.play();

    } else if (audioPlayed.value && !isPlaying.value) {
      /*if (player.playing == false) {
        player.stop();
      } else {
        player.stop();
      }*/
      player.play();

      isPlaying.value = true;
      audioPlayed.value = true;
      await player.setSpeed(setPlaybackRateValue.value);
    } else {
      await player.pause();
      isPlaying.value = false;
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnPlayForwordButton() async {
    inAsyncCall.value = true;
    await player.seek(Duration(
        milliseconds: currentPos.value != maxDuration
            ? currentPos.value + 10000
            : currentPos.value));
    inAsyncCall.value = false;
  }

  Future<void> getProgress(int value) async {
    if (value == 0) {
      selectedMenu.value = 0.8;
    } else if (value == 1) {
      selectedMenu.value = 0.85;
    } else if (value == 2) {
      selectedMenu.value = 0.9;
    } else if (value == 3) {
      selectedMenu.value = 1.0;
    } else if (value == 4) {
      selectedMenu.value = 1.05;
    } else if (value == 5) {
      selectedMenu.value = 1.1;
    } else if (value == 6) {
      selectedMenu.value = 1.15;
    } else if (value == 8) {
      selectedMenu.value = 1.2;
    }

    await changePlaybackRate(selectedMenu.value);
  }

  void clickOnMusicSoundButton({required double value}) {
    inAsyncCall.value = true;
    VolumeController().setVolume(value);
    inAsyncCall.value = false;
  }

  void clickOnArrowUpButton() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn);
  }

  Future<void> changePlaybackRate(double value) async {
    inAsyncCall.value = true;
    setPlaybackRateValue.value = value;
    await player.setSpeed(setPlaybackRateValue.value);
    inAsyncCall.value = false;
  }

  void clickOnAudioSpeedFunction() {
    clickOnAudioSpeed.value = !clickOnAudioSpeed.value;
  }

  Future<void> onChangedSlider(double value) async {
    inAsyncCall.value = true;
    int seekVal = value.round();
    await player.seek(Duration(milliseconds: seekVal));
    currentPos.value = seekVal;
    inAsyncCall.value = false;
  }

  Future<void> clickOnParticularComment({required int index}) async {
    inAsyncCall.value = true;
    String tag = CM.getRandomNumber();
    Get.put(QuizDetailController(), tag: tag);
    await Navigator.of(Get.context!).push(
      MaterialPageRoute(
        builder: (context) => QuizDetailView(
            tag: tag,
            quizId: quizReplyList[index].id.toString(),
            isLiked: getDataModel.value?.isFavorite == 1,
            bookId: bookId,
            quiz: quizReplyList[index]),
      ),
    );
    await Get.delete<QuizDetailController>(tag: tag);
    screens = Screens.readAndListen;
    inAsyncCall.value = false;
  }

  void onTextSelection(
      {required TextSelection selection, SelectionChangedCause? cause}) {
    responseCodeDictionary.value = 0;
    audio = "";
    example = "";
    String value =
        selection.textInside(CM.parseHtmlString(selectedChapterContent.value));
    getDictionaryApiCalling(value: value);
    if (value.trim().toString().isNotEmpty) {
      showDialog(
        context: Get.context!,
        builder: (context) => alertDialogView(value: value),
      );
    }
  }

  AlertDialog alertDialogView({required String value}) => AlertDialog(
        backgroundColor: Col.borderColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.px),
            side: BorderSide(width: 2.px, color: Col.secondary)),
        title: Obx(() {
          if (responseCodeDictionary.value == 200) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value,
                                  style: CT.openSansBodyLarge(),
                                ),
                              ],
                            ),
                          ),
                          if (audio.isNotEmpty)
                            commonButtonView(
                                onTap: () => clickOnVoiceNote(),
                                image: const Icon(Icons.volume_up_sharp))
                        ],
                      ),
                    ),
                    commonButtonView(
                        onTap: () => clickOnCrossIcon(),
                        image: const Icon(Icons.close))
                  ],
                ),
                if (dictionary != null &&
                    dictionary?.listOfDictionary != null &&
                    dictionary!.listOfDictionary!.isNotEmpty &&
                    dictionary?.listOfDictionary?[0].meanings != null &&
                    dictionary!.listOfDictionary![0].meanings!.isNotEmpty &&
                    dictionary?.listOfDictionary?[0].meanings?[0].definitions !=
                        null &&
                    dictionary!.listOfDictionary![0].meanings![0].definitions!
                        .isNotEmpty &&
                    dictionary?.listOfDictionary?[0].meanings?[0]
                            .definitions?[0].definition !=
                        null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4.px,
                      ),
                      Text(
                        "phrasal verb of $value:",
                        style: CT.openSansTitleMedium(),
                      ),
                      SizedBox(
                        height: 4.px,
                      ),
                      Text(
                        "1.${dictionary?.listOfDictionary?[0].meanings?[0].definitions?[0].definition ?? ""}",
                        style: CT.openSansBodyMedium(),
                      ),
                      if (example.isNotEmpty)
                        SizedBox(
                          height: 4.px,
                        ),
                      if (example.isNotEmpty)
                        Text(
                          "EX.: \"$example\"",
                          style: CT.openSansBodyMedium(),
                        ),
                    ],
                  ),
              ],
            );
          } else if (responseCodeDictionary.value == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.px,
                  width: 40.px,
                  child: CW.commonProgressBarView(),
                ),
              ],
            );
          } else if (responseCodeDictionary.value == 404) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(value, style: CT.openSansBodyLarge()),
                        ],
                      ),
                    ),
                    commonButtonView(
                        onTap: () => clickOnCrossIcon(),
                        image: const Icon(Icons.close))
                  ],
                ),
                SizedBox(
                  height: 10.px,
                ),
                Text(
                  "No Result Found",
                  style: CT.openSansBodyMedium(),
                ),
              ],
            );
          }
          return const SizedBox();
        }),
      );

  Widget commonButtonView(
          {required Widget image, required VoidCallback onTap}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.px),
        child: Padding(padding: EdgeInsets.all(5.px), child: image),
      );

  void clickOnVoiceNote() async {
    isPlaying.value = false;
    player.pause();
    await audioPlayerMain.setSourceUrl(
      audio,
    );
    await audioPlayerMain.play(
      mainAudioPlayer.UrlSource(
        audio,
      ),
    );
    audioPlayerMain.onPlayerComplete.listen((event) {
      audioPlayerMain.pause();
    });
  }

  void clickOnCrossIcon() {
    Get.back();
  }

}
