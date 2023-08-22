import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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

import '../../feedback/views/feedback_view.dart';

class ReadBookController extends AppController {
  int intValue = 1;
  final count = 0.obs;
  final inAsyncCall = false.obs;
  final isLastPage = false.obs;
  bool isDarkMode = false;
  int audioPlayerLoad = 0;
  String id = "";
  String bookId = "";
  String chapterId = "";
  bool bookmark = false;
  final haveAudio = false.obs;
  String audioUrl = "";
  List<TextEditingController> controllerList = [];
  final isBookmark = false.obs;
  final isZoom = false.obs;
  final isCommentHidden = false.obs;
  final isShowMusicPlayer = true.obs;
  final selectedChapter = "".obs;
  final selectedChapterId = 0.obs;
  final selectedChapterContent = "".obs;
  final selectedChapterObject = Rxn<Chapters?>();
  final isPlaying = false.obs;
  final audioPlayed = false.obs;
  final currentPos = 0.obs;
  final currentPositionLabel = "00:00".obs;
  final setPlaybackRate = 1.0.obs;
  int maxDuration = 100;
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

  final responseCodeQuiz = 0.obs;
  Map<String, dynamic> queryParametersForQuiz = {};
  final getDataModelForQuiz = Rxn<GetDashBoardBooksModel>();
  List<Books> quizList = [];
  String quizLimit = "10";
  int quizOffset = 0;

  Map<String, dynamic> bodyParamsForSubmitQuestionAnswerApi = {};

  Map<String, dynamic> bodyParamsForAddFinishedBookApi = {};

  final responseCodeQuizReply = 0.obs;
  Map<String, dynamic> queryParametersForQuizReply = {};
  final getDataModelForQuizReply = Rxn<GetDashBoardBooksModel>();
  List<Books> quizReplyList = [];
  String quizReplyLimit = "10";
  int quizReplyOffset = 0;
  bool isLiked = false;

  final responseCodeDictionary = 0.obs;
  D? dictionary;
  String audio = "";
  String example = "";

  @override
  Future<void> onInit() async {
    super.onInit();
/*
    onReload();
*/
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    if (isPlaying.value && audioPlayed.value) {
      player.stop();
    }
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
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
    isDarkMode = await DatabaseHelper.databaseHelperInstance
            .getParticularData(key: DatabaseConst.columnMode) ==
        "1";
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
    player.onDurationChanged.listen((Duration d) {
      maxDuration = d.inMilliseconds;
    });
    player.onPositionChanged.listen((Duration p) async {
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

    player.onPlayerStateChanged.listen((event) async {
      if (event == PlayerState.completed) {
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

  void increment() => count.value++;

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
    screens = Screens.readAndListen;
    inAsyncCall.value = false;
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
    if ((!isPlaying.value) && (!audioPlayed.value)) {
      await player.setSourceUrl(CM.getImageUrl(value: audioUrl));
      await player.play(UrlSource(CM.getImageUrl(value: audioUrl)));
      isPlaying.value = true;
      audioPlayed.value = true;
    } else if (audioPlayed.value && !isPlaying.value) {
      await player.resume();
      isPlaying.value = true;
      audioPlayed.value = true;
      await player.setPlaybackRate(setPlaybackRate.value);
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

  void clickOnMusicSoundButton({required double value}) {
    inAsyncCall.value = true;
    VolumeController().setVolume(value);
    inAsyncCall.value = false;
  }

  Future<void> changePlaybackRate(double value) async {
    inAsyncCall.value = true;
    setPlaybackRate.value = value;
    await player.setPlaybackRate(setPlaybackRate.value);
    inAsyncCall.value = false;
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
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.setSourceUrl(
      audio,
    );
    await audioPlayer.play(
      UrlSource(
        audio,
      ),
    );
    audioPlayer.onPlayerComplete.listen((event) {
      audioPlayer.pause();
    });
  }

  void clickOnCrossIcon() {
    Get.back();
  }
}
