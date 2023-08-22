import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/load_more/load_more.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/read_book_controller.dart';

// ignore: must_be_immutable
class ReadBookView extends GetView<ReadBookController> {
  @override
  // ignore: overridden_fields
  String? tag;
  String? bookId;
  String? chapterId;
  bool? isBookmark;
  bool? isLiked;

  @override
  late ReadBookController controller;

  ReadBookView({super.key,
    Key? k,
    this.tag,
    this.bookId,
    this.isBookmark,
    this.chapterId,
    this.isLiked}) {
    controller = Get.find(tag: tag);
    if (controller.intValue == 1) {
      controller.intValue = 0;
      controller.id = tag ?? "";
      controller.bookId = bookId ?? "";
      controller.bookmark = isBookmark ?? false;
      controller.isLiked = isLiked ?? false;
      controller.chapterId = chapterId ?? "";
      controller.myOnInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        WillPopScope(
          onWillPop: () => controller.clickOnBackButton(),
          child: ModalProgress(
            inAsyncCall: controller.inAsyncCall.value,
            child: getView(),
          ),
        ));
  }

  Widget getView() {
    if (controller.chapterList.isNotEmpty) {
      return controller.isZoom.value
          ? Scaffold(
        backgroundColor: controller.isDarkMode
            ? Col.darkAppBar
            : Theme
            .of(Get.context!)
            .scaffoldBackgroundColor,
        body: Column(
          children: [
            SafeArea(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  SizedBox(
                    height: CM.getDeviceSize(),
                    child: ScrollConfiguration(
                      behavior: ListScrollBehaviour(),
                      child: Scrollbar(
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: C.margin - 6.px,
                                  vertical: C.margin + 12.px),
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.px, horizontal: 6.px),
                                  color: controller.isDarkMode
                                      ? Col.darkGray
                                      : Col.inverseSecondary,
                                  child: textViewChapterContent()),
                            ),
                            SizedBox(
                              height: 30.px,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  floatingButtonForZoomIn()
                ],
              ),
            )
          ],
        ),
      )
          : Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        floatingActionButton: audioPlayerView(),
        backgroundColor: controller.isDarkMode &&
            controller.selectedChapter.value != "Quiz"
            ? Col.darkAppBar
            : Theme
            .of(Get.context!)
            .scaffoldBackgroundColor,
        body: Column(
          children: [
            appBarView(),
            if (controller.responseCode.value == 200)
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  SizedBox(
                    height: CM.getDeviceSize() - CM.getAppBarSize(),
                    child: ScrollConfiguration(
                      behavior: ListScrollBehaviour(),
                      child: Scrollbar(
                        child: Obx(() {
                          controller.count.value;
                          return RefreshLoadMore(
                            isLastPage: controller.isLastPage.value,
                            wantLoadMore:
                            !controller.isCommentHidden.value,
                            onLoadMore: () => controller.onLoadMore(),
                            child: ListView(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              padding:
                              EdgeInsets.symmetric(vertical: 18.px),
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: controller
                                              .selectedChapter
                                              .value !=
                                              "Quiz"
                                              ? controller.isDarkMode
                                              ? Col.secondary
                                              : Col
                                              .cardBackgroundColor
                                              : Col.cardBackgroundColor,
                                          width: 2.px),
                                      borderRadius:
                                      BorderRadius.circular(9.px)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: C.margin),
                                  child: buttonViewDropDown(),
                                ),
                                Obx(() {
                                  if (controller.selectedChapter.value !=
                                      "Quiz") {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: C.margin - 6.px,
                                          vertical: C.margin + 12.px),
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.px,
                                              horizontal: 6.px),
                                          color: controller.isDarkMode
                                              ? Col.darkGray
                                              : Col.inverseSecondary,
                                          child:
                                          textViewChapterContent()),
                                    );
                                  } else {
                                    if (controller
                                        .responseCodeQuiz.value ==
                                        200) {
                                      return Column(
                                        children: [
                                          listViewQuiz(),
                                          buttonViewSubmit(),
                                          if (controller
                                              .responseCodeQuizReply
                                              .value ==
                                              200 &&
                                              controller.quizReplyList
                                                  .isNotEmpty)
                                            Padding(
                                              padding:
                                              EdgeInsets.symmetric(
                                                  horizontal:
                                                  C.margin),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  textViewComments(),
                                                  SizedBox(
                                                    height: 30.px,
                                                    child:
                                                    buttonViewEyeShowHide(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (!controller.isCommentHidden
                                              .value &&
                                              controller
                                                  .responseCodeQuizReply
                                                  .value ==
                                                  200 &&
                                              controller.quizReplyList
                                                  .isNotEmpty)
                                            listViewComments(),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }
                                }),
                                if (controller.selectedChapter.value !=
                                    "Quiz")
                                  SizedBox(
                                    height: 150.px,
                                  )
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  if (controller.haveAudio.value &&
                      !controller.isShowMusicPlayer.value &&
                      controller.selectedChapter.value.isNotEmpty &&
                      controller.selectedChapter.value != "Quiz")
                    floatingButtonForShowMusicPlayer()
                ],
              ),
          ],
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: controller.isDarkMode &&
              controller.selectedChapter.value != "Quiz"
              ? Col.darkAppBar
              : Theme
              .of(Get.context!)
              .scaffoldBackgroundColor,
          body: Column(
            children: [
              appBarView(),
              if (controller.responseCode.value == 0)
                const SizedBox()
              else
                CW.commonNoDataFoundImage(
                  onRefresh: () async {},
                ),
            ],
          ));
    }
  }

  Widget appBarView() =>
      CW.commonAppBarWithActon(
        wantDarkMode:
        controller.selectedChapter.value != "Quiz" && controller.isDarkMode,
        wantSelectedBookMarkButton: controller.isBookmark.value,
        wantZoomButton: controller.selectedChapter.value != "Quiz" &&
            controller.chapterList.isNotEmpty,
        wantMenuButton: controller.selectedChapter.value != "Quiz" &&
            controller.chapterList.isNotEmpty,
        wantBookMarkButton: controller.selectedChapter.value != "Quiz" &&
            controller.chapterList.isNotEmpty,
        wantLikeButton: false,
        wantInfoButton: controller.chapterList.isNotEmpty,
        wantShareButton: controller.chapterList.isNotEmpty,
        clickOnZoomButton: () => controller.clickOnZoomButton(),
        clickOnBackButton: () => controller.clickOnBackButton(),
        clickOnInfoButton: () => controller.clickOnInfoButton(),
        clickOnBookMarkButton: () => controller.clickOnBookMarkButton(),
        clickOnShareButton: () => controller.clickOnShareButton(),
        menuButton: popUpMenuView(),
      );

  Widget appBarViewForZoom() =>
      CW.commonAppBarWithoutActon(title: "", wantBackButton: false);

  Widget buttonViewDropDown() =>
      Obx(
            () =>
            DropdownView<Chapters>(
              hintText: controller.selectedChapter.value.isNotEmpty
                  ? controller.selectedChapter.value
                  : 'Select Chapter',
              isQuiz: controller.selectedChapter.value == "Quiz",
              hintStyle: CT.openSansDisplayMedium(),
              isDarkMode: controller.isDarkMode,
              items: controller.chapterList
                  .map(
                    (Chapters e) =>
                    DropdownMenuItem<Chapters>(
                        value: e,
                        child: Container(
                          padding: EdgeInsets.all(8.px),
                          margin: EdgeInsets.only(bottom: 5.px),
                          decoration: BoxDecoration(
                              color: e.chapterName != "Quiz"
                                  ? controller.isDarkMode
                                  ? controller.selectedChapterId.value == e.id
                                  ? Col.darkGray
                                  : Col.inverseSecondary
                                  : controller.selectedChapterId.value == e.id
                                  ? Col.borderColor
                                  : Col.inverseSecondary
                                  : Col.borderColor,
                              borderRadius: BorderRadius.circular(7.px)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${e.chapterName}",
                                style: Theme
                                    .of(Get.context!)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                  fontFamily: C.fontOpenSans,
                                  color: e.chapterName != "Quiz"
                                      ? controller.isDarkMode
                                      ? controller.selectedChapterId
                                      .value ==
                                      e.id
                                      ? Col.inverseSecondary
                                      : Col.secondary
                                      : Col.secondary
                                      : Col.secondary,
                                ),
                              ),
                              controller.selectedChapterId.value == e.id
                                  ? imageViewArrowUp()
                                  : imageViewArrowDown()
                            ],
                          ),
                        )),
              )
                  .toList(),
              selectedItem: controller.selectedChapterObject.value,
              onChange: (value) async {
                controller.isBookmark.value =
                    controller.bookmarkList.contains(value?.id.toString());
                if (value?.audio != null) {
                  if (controller.selectedChapterId.value != value?.id) {
                    controller.player.pause();
                    await controller.player.seek(
                        const Duration(milliseconds: 0));
                    controller.haveAudio.value = true;
                    controller.audioUrl = value?.audio ?? "";
                    controller.isPlaying.value = false;
                    controller.audioPlayed.value = false;
                  } else {}
                } else {
                  controller.player.pause();
                  controller.haveAudio.value = false;
                }

                controller.selectedChapter.value = value!.chapterName!;
                controller.selectedChapterContent.value =
                    value.chapterDescription ?? "";
                controller.selectedChapterId.value = value.id ?? 0;
                controller.selectedChapterObject.value = value;
                if (controller.selectedChapter.value == "Quiz") {
                  if (controller.quizList.isEmpty) {
                    controller.inAsyncCall.value = true;
                    await controller.getQuizForBook();
                    await controller.getQuizReplyForBook();
                    controller.inAsyncCall.value = false;
                  }
                } else {
                  int v = 1;
                  int j = 0;
                  if (controller.selectedChapterId.value ==
                      controller
                          .chapterList[controller.chapterList.length - 1].id) {
                    controller.finishBookApiCalling();
                  }

                  for (var element in controller.chapterList) {
                    if (controller.selectedChapterId.value == element.id) {
                      j = 1;
                    } else {
                      if (j != 1) {
                        v++;
                      }
                    }
                  }
                  controller.addViewBookApiCalling(chapter: v.toString());
                }
              },
            ),
      );

  Widget imageViewArrowUp() =>
      Image.asset(
        C.imageArrowUpKeyBoardLogo,
        height: 10.px,
        width: 25.px,
        color: controller.selectedChapter.value != "Quiz"
            ? controller.isDarkMode
            ? Col.inverseSecondary
            : Col.secondary
            : Col.secondary,
      );

  Widget imageViewArrowDown() =>
      Image.asset(
        C.imageArrowDownKeyBoardLogo,
        height: 10.px,
        width: 25.px,
      );

  Widget textViewChapterContent() =>
      SelectableText(
        CM.parseHtmlString(controller.selectedChapterContent.value),
        style: Theme
            .of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(
            fontFamily: C.fontOpenSans,
            color: controller.isDarkMode
                ? Col.lightInverseSecondary
                : Col.secondary),
        onSelectionChanged: (selection, cause) =>controller.onTextSelection(selection:selection,cause:cause),
      );

  Widget listViewQuiz() =>
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.quizList[index].question != null)
                textViewQuestion(index: index),
              SizedBox(
                height: 10.px,
              ),
              textFiledViewReply(index: index),
              SizedBox(
                height: 18.px,
              ),
            ],
          );
        },
        shrinkWrap: true,
        itemCount: controller.quizList.length,
        padding: EdgeInsets.only(left: C.margin, right: C.margin, top: 28.px),
      );

  Widget textViewQuestion({required int index}) =>
      Text("Q${index + 1}. ${controller.quizList[index].question ?? ""}");

  Widget textFiledViewReply({required int index}) =>
      CW.commonTextFieldForLoginSignUP(
        borderRadius: 20.px,
        hintText: C.textReply,
        maxHeight: 40.px,
        elevation: 0,
        controller: controller.controllerList[index],
      );

  Widget buttonViewSubmit() =>
      CW.commonElevatedButton(
          onPressed: () => controller.clickOnSubmitButton(),
          child: Text(
            C.textSubmit,
            style: CT.openSansTitleMedium(),
          ),
          borderRadius: 5.px,
          buttonColor: Col.primaryColor);

  Widget textViewComments() =>
      Text(
        C.textComments,
        style: CT.openSansDisplayMedium(),
      );

  Widget buttonViewEyeShowHide() =>
      FloatingActionButton(
        onPressed: () => controller.clickOnCommentHideShowButton(),
        backgroundColor: Colors.transparent,
        splashColor: Colors.white12,
        elevation: 0.px,
        heroTag: null,
        highlightElevation: 0.px,
        child: controller.isCommentHidden.value
            ? Image.asset(
          C.imageEyeShowLogo,
          height: 25.px,
          width: 25.px,
        )
            : Image.asset(
          C.imageEyeHideLogo,
          height: 25.px,
          width: 25.px,
        ),
      );

  Widget listViewComments() =>
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                left: C.margin, right: C.margin, bottom: C.margin),
            child: InkWell(
              onTap: () => controller.clickOnParticularComment(index: index),
              borderRadius: BorderRadius.circular(10.px),
              child: Container(
                padding: EdgeInsets.all(10.px),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.px),
                    color: Col.inverseSecondaryVariant),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.px),
                      child: imageViewUserProfile(index: index),
                    ),
                    SizedBox(
                      width: 20.px,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller
                              .quizReplyList[index].userdetails?.name !=
                              null)
                            textViewCommentUserName(index: index),
                          /*if (controller
                                  .quizReplyList[index].userdetails?.name !=
                              null)
                            textViewCommentDis(index: index),*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        shrinkWrap: true,
        itemCount: controller.quizReplyList.length,
        padding: EdgeInsets.only(top: 18.px),
      );

  Widget imageViewUserProfile({required int index}) {
    if (controller.quizReplyList[index].userdetails != null &&
        controller.quizReplyList[index].userdetails?.userImage != null) {
      return Image.network(
        CM.getImageUrl(
            value:
            controller.quizReplyList[index].userdetails?.userImage ?? ''),
        height: 40.px,
        width: 40.px,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 40.px, width: 40.px, radius: 22.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageUserProfile,
            height: 40.px,
            width: 40.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageUserProfile,
        height: 40.px,
        width: 40.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textViewCommentUserName({required int index}) =>
      Text(
        controller.quizReplyList[index].userdetails?.name ?? "",
        style: CT.openSansBodyMedium(),
      );

  Widget textViewCommentDis({required int index}) =>
      Text(
        C.textReviewDis,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CT.openSansBodySmall(),
      );

  Widget floatingButtonForShowMusicPlayer() =>
      Padding(
        padding: EdgeInsets.only(right: C.margin, bottom: 20.px),
        child: FloatingActionButton(
          onPressed: () => controller.clickOnEyeHideButton(),
          foregroundColor: Colors.green,
          focusColor: Colors.red,
          backgroundColor: Col.primary,
          child: Image.asset(
            C.imageMusicSoundMusicHideLogo,
            height: 32.px,
            width: 32.px,
          ),
        ),
      );

  Widget audioPlayerView() {
    if (controller.haveAudio.value &&
        controller.isShowMusicPlayer.value &&
        controller.selectedChapter.value.isNotEmpty &&
        controller.selectedChapter.value != "Quiz") {
      return Container(
          height: 130.px,
          color: controller.isDarkMode ? Col.darkGray : Col.borderColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 13.px, bottom: 8.px, top: 8.px),
                child: SizedBox(
                  height: 30.px,
                  child: buttonViewEyeHide(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: C.margin),
                height: 30.px,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textViewDurationOfMusic(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonButtonView(
                            image: C.imagePlayBackLogo,
                            onPressed: () => controller.clickOnPlayBackButton(),
                          ),
                          SizedBox(height: 30.px, child: buttonViewPlayPause()),
                          commonButtonView(
                            image: C.imagePlayForwordLogo,
                            onPressed: () =>
                                controller.clickOnPlayForwordButton(),
                          ),
                        ],
                      ),
                    ),
                    volumeBarView(),
                    SizedBox(
                      height: 30.px,
                      child: buttonViewAudioSpeed(),
                    ),
                  ],
                ),
              ),
              Slider(
                value: double.parse(controller.currentPos.toString()),
                min: 0,
                max: double.parse(controller.maxDuration.toString()),
                divisions: controller.maxDuration,
                label: controller.currentPositionLabel.value,
                onChanged: (double value) => controller.onChangedSlider(value),
              ),
            ],
          ));
    } else {
      return const SizedBox();
    }
  }

  Widget commonButtonView(
      {required String image, required VoidCallback onPressed}) =>
      SizedBox(
        height: 30.px,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.transparent,
          splashColor: Colors.white12,
          elevation: 0.px,
          heroTag: null,
          highlightElevation: 0.px,
          child: Image.asset(
            image,
            height: 25.px,
            width: 25.px,
          ),
        ),
      );

  Widget buttonViewEyeHide() =>
      FloatingActionButton(
        onPressed: () => controller.clickOnEyeHideButton(),
        backgroundColor: Colors.transparent,
        splashColor: Colors.white12,
        elevation: 0.px,
        heroTag: null,
        highlightElevation: 0.px,
        child: Image.asset(
          C.imageEyeHideLogo,
          height: 25.px,
          width: 25.px,
        ),
      );

  Widget textViewDurationOfMusic() =>
      Text(
        controller.currentPositionLabel.value,
        style: Theme
            .of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: C.fontOpenSans, fontSize: 12.px),
      );

  Widget buttonViewPlayPause() =>
      FloatingActionButton(
        backgroundColor: Colors.transparent,
        splashColor: Colors.white12,
        elevation: 0.px,
        heroTag: null,
        highlightElevation: 0.px,
        onPressed: () => controller.clickOnPauseAndPlayButton(),
        child: controller.isPlaying.value
            ? Image.asset(
          C.imagePlayMusicLogo,
          height: 25.px,
          width: 25.px,
        )
            : Icon(
          Icons.play_arrow,
          size: 25.px,
          color: Col.secondary,
        ),
      );

  Widget buttonViewAudioSpeed() =>
      Obx(
            () =>
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              splashColor: Colors.white12,
              elevation: 0.px,
              heroTag: null,
              highlightElevation: 0.px,
              onPressed: () {},
              child: PopupMenuButton<double>(
                initialValue: controller.selectedMenu.value,
                child: Container(
                  height: 25.px,
                  width: 38.5.px,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Col.secondary, width: 1.px)),
                  child: Center(
                    child: Text(
                      "${controller.selectedMenu.value}x",
                      style: Theme
                          .of(Get.context!)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                          fontFamily: C.fontOpenSans, fontSize: 12.px),
                    ),
                  ),
                ),
                onSelected: (double value) {
                  controller.selectedMenu.value = value;
                  controller.changePlaybackRate(controller.selectedMenu.value);
                },
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<double>>[
                  const PopupMenuItem<double>(
                    value: 0.25,
                    child: Text('0.25x'),
                  ),
                  const PopupMenuItem<double>(
                    value: 0.5,
                    child: Text('0.5x'),
                  ),
                  const PopupMenuItem<double>(
                    value: 0.75,
                    child: Text('0.75x'),
                  ),
                  const PopupMenuItem<double>(
                    value: 1,
                    child: Text('1x'),
                  ),
                  const PopupMenuItem<double>(
                    value: 1.25,
                    child: Text('1.25x'),
                  ),
                  const PopupMenuItem<double>(
                    value: 1.75,
                    child: Text('1.75x'),
                  ),
                ],
              ),
            ),
      );

  Widget floatingButtonForZoomIn() =>
      Padding(
        padding: EdgeInsets.only(bottom: 20.px),
        child: CW.commonElevatedButton(
          borderRadius: 11.px,
          buttonColor: Colors.transparent,
          onPressed: () => controller.clickOnZoomButton(),
          child: Image.asset(
            C.imageZoomInLogo,
            height: 50.px,
            width: 50.px,
          ),
        ),
      );

  Widget volumeBarView() =>
      FloatingActionButton(
        backgroundColor: Colors.transparent,
        splashColor: Colors.white12,
        elevation: 0.px,
        heroTag: null,
        highlightElevation: 0.px,
        onPressed: () {},
        child: Obx(() =>
            PopupMenuButton(
              constraints:
              BoxConstraints.tightFor(width: 40.px, height: 185.px),
              color: Col.cardBackgroundColor,
              initialValue: controller.getVolume.value,
              shape: Border.all(width: .4.px, color: Col.primary),
              tooltip: "Volume",
              child: Image.asset(
                C.imageMusicSoundMusicHideLogo,
                height: 25.px,
                width: 25.px,
              ),
              itemBuilder: (BuildContext context) =>
              <PopupMenuItem>[
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  value: controller.getVolume.value,
                  child: Obx(() =>
                      Container(
                        padding: EdgeInsets.zero,
                        color: Col.cardBackgroundColor,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            value: controller.getVolume.value,
                            max: 1.0,
                            onChanged: (double newValue) {
                              controller.clickOnMusicSoundButton(
                                  value: newValue);
                            },
                          ),
                        ),
                      )),
                ),
              ],
            )),
      );

  Widget popUpMenuView() {
    return IconButton(
      onPressed: null,
      icon: PopupMenuButton(
        padding: EdgeInsets.zero,
        splashRadius: 30.px,
        position: PopupMenuPosition.under,
        itemBuilder: (context) =>
        [
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconOne,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconTwo,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconThree,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconFour,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconFive,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconSix,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconSeven,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconEight,
              setValue: "one"),
          commonPopUpMenuItem(
              innerList: ["vsd", "vsd", "sdvvvd"],
              image: C.imagePopUpIconNine,
              setValue: "one"),
        ],
        child: Image.asset(
          C.imageComaLogo,
          color: controller.isDarkMode ? Col.inverseSecondary : Col.secondary,
          height: 25.px,
          width: 25.px,
        ),
      ),
    );
  }

  PopupMenuItem commonPopUpMenuItem({required List<String> innerList,
    required String image,
    required String setValue}) {
    return PopupMenuItem(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 25.px,
            width: 25.px,
          ),
          SizedBox(
            width: 10.px,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.px,
                width: 90.px,
                child: Stack(
                  children: [
                    Container(
                      height: 30.px,
                      width: 90.px,
                      padding: EdgeInsets.all(5.px),
                      decoration: BoxDecoration(
                        border: Border.all(color: Col.surface, width: 1.px),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(setValue),
                          Image.asset(
                            C.imagePopUpIconDown,
                            height: 25.px,
                            width: 14.px,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          onChanged: (value) async {},
                          items: innerList.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          iconEnabledColor: Colors.transparent,
                          iconDisabledColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DropdownView<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? selectedItem;
  final Function(T? value) onChange;
  String hintText;
  TextStyle? hintStyle;
  bool? isDarkMode = false;
  bool? isQuiz = false;

  DropdownView({Key? key,
    required this.items,
    required this.onChange,
    required this.selectedItem,
    required this.hintText,
    this.hintStyle,
    this.isDarkMode,
    this.isQuiz})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (context, setState) =>
            Stack(
              children: [
                Container(
                  height: 52.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.px),
                    color: isQuiz ?? false
                        ? Col.borderColor
                        : isDarkMode ?? false
                        ? Col.darkGray
                        : Col.borderColor,
                  ),
                  alignment: Alignment.center,
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(8.px),
                    onChanged: onChange,
                    dropdownColor: isQuiz ?? false
                        ? Col.borderColor
                        : isDarkMode ?? false
                        ? Col.darkGray
                        : Col.borderColor,
                    elevation: 0,
                    items: items,
                    hint: Padding(
                      padding: EdgeInsets.symmetric(horizontal: C.margin / 2),
                      child: Text(hintText, style: hintStyle),
                    ),
                    isExpanded: true,
                    value: selectedItem,
                    underline: Container(color: Colors.transparent),
                  ),
                ),
              ],
            ));
  }
}
