


import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/modules/splash/controllers/splash_controller.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/load_more/load_more.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../../../../custom_image_picker/custom_image_view.dart';
import '../../Showpopup/showpopup.dart';
import '../../book_detail/views/book_detail_view.dart';
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

  ReadBookView(
      {super.key,
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
    return Obx(() => WillPopScope(
          onWillPop: () => controller.clickOnBackButton(),
          child: ModalProgress(
            inAsyncCall: controller.inAsyncCall.value,
            child: getView(),
          ),
        ));
  }

  Widget getView() {
    ShowPopup showPopup = ShowPopup();
    if (controller.chapterList.isNotEmpty) {
      return controller.isZoom.value
          ? Scaffold(
              backgroundColor: controller.isDarkMode.value
                  ? Col.darkAppBar
                  : Theme.of(Get.context!).scaffoldBackgroundColor,
              body: Stack(
                children: [
                  Column(
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
                                    controller: ScrollController(),
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: C.margin - 6.px,
                                            vertical: C.margin + 12.px),
                                        child: Obx(() => Container(
                                            decoration: BoxDecoration(
                                                color: controller
                                                    .modeValue
                                                    .value
                                                    ? controller
                                                    .changeBackgroundColor(
                                                    Colors
                                                        .transparent)
                                                    : controller
                                                    .backGroundColor
                                                    .value,
                                                image: controller
                                                    .isBGColorSelected
                                                    .value ==
                                                    false
                                                    ? DecorationImage(
                                                    image:
                                                    AssetImage(
                                                      controller
                                                          .imageChoose
                                                          .value
                                                          .bank_logo
                                                          .value,
                                                    ),
                                                    fit: BoxFit
                                                        .cover)
                                                    : null),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.px,
                                                horizontal: 6.px),
                                            child: textViewChapterContent())),
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
                ],
              ),
            )
          : Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: audioPlayerView(),
              backgroundColor: controller.isDarkMode.value &&
                      controller.selectedChapter.value != "Quiz"
                  ? Col.darkAppBar
                  : Theme.of(Get.context!).scaffoldBackgroundColor,
              body: Stack(
                children: [
                  Column(
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
                                    return RefreshLoadMoreForController(
                                      scrollControllerMain:
                                          controller.scrollController,
                                      wantValueUpdate:
                                          controller.selectedChapter.value ==
                                              "Quiz",
                                      onValueUpdate: (value) {
                                        controller.wantScrollBackButton.value =
                                            value;
                                      },
                                      isLastPage: controller.isLastPage.value,
                                      wantLoadMore: !controller
                                              .isCommentHidden.value &&
                                          controller.selectedChapter.value ==
                                              "Quiz",
                                      onLoadMore: () => controller.onLoadMore(),
                                      child: ListView(
                                        controller: ScrollController(),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 18.px),
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: controller
                                                                .selectedChapter
                                                                .value !=
                                                            "Quiz"
                                                        ? controller.isDarkMode
                                                                .value
                                                            ? Col.secondary
                                                            : Col
                                                                .cardBackgroundColor
                                                        : Col
                                                            .cardBackgroundColor,
                                                    width: 2.px),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        9.px)),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: C.margin),
                                            child: buttonViewDropDown(),
                                          ),

                                            if (controller.selectedChapter.value !="Quiz")
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: C.margin - 6.px,
                                                    vertical: C.margin + 12.px),
                                                child: SingleChildScrollView(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color: controller
                                                                  .modeValue
                                                                  .value
                                                              ? controller
                                                                  .changeBackgroundColor(
                                                                      Colors
                                                                          .transparent)
                                                              : controller
                                                                  .backGroundColor
                                                                  .value,
                                                          image: controller
                                                                      .isBGColorSelected
                                                                      .value ==
                                                                  false
                                                              ? DecorationImage(
                                                                  image:
                                                                      AssetImage(
                                                                    controller
                                                                        .imageChoose
                                                                        .value
                                                                        .bank_logo
                                                                        .value,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)
                                                              : null),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5.px,
                                                              horizontal: 6.px),
                                                      child:
                                                          textViewChapterContent()),
                                                ),
                                              ),
                                    if (controller.selectedChapter.value =="Quiz")
                                     if (controller.responseCodeQuiz.value ==200)
                                                Column(
                                                  children: [
                                                    listViewQuiz(),
                                                    if (controller.userStatus.value == "active")
                                                      buttonViewSubmit(),
                                                    if (controller.userStatus.value == "inactive")
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 15.px,
                                                            bottom: 15.px,
                                                            left: C.margin,
                                                            right: C.margin),
                                                        child: InkWell(
                                                          onTap: () => controller.clickOnGetPremium(),
                                                          borderRadius: BorderRadius.circular(5.px),
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                vertical: 10.px, horizontal: 10.px),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5.px),
                                                              border: Border.all(
                                                                  color: Col.primary, width: 2.px),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      textViewGetPremium(),
                                                                      SizedBox(
                                                                        height: 10.px,
                                                                      ),
                                                                      textViewDownload()
                                                                    ],
                                                                  ),
                                                                ),
                                                                imageViewPremium()
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    if (controller.userStatus.value == "inactive")
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 8),
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 8,
                                                                right: 8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors
                                                                .orange.shade100),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.info_outline),
                                                            SizedBox(width: 10.px,),
                                                            Flexible(
                                                              child: Text(
                                                                C.userAnswers,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (controller.userStatus.value == "active")
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 15,
                                                            right: 15,
                                                            bottom: 8,
                                                            top: 10),
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8,
                                                                bottom: 8,
                                                                left: 8,
                                                                right: 8),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors
                                                                .orange.shade100),
                                                        child: Row(
                                                          children: [
                                                            Icon(Icons.info_outline),
                                                            SizedBox(width: 10,),
                                                            Flexible(
                                                              child: Text(
                                                                C.userupdate,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    if (controller
                                                                .responseCodeQuizReply
                                                                .value ==
                                                            200 &&
                                                        controller.quizReplyList
                                                            .isNotEmpty)
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    C.margin),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            textViewComments(),
                                                            // SizedBox(
                                                            //   height: 30.px,
                                                            //   child:
                                                            //      // buttonViewEyeShowHide(),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    // if (!controller
                                                    //         .isCommentHidden
                                                    //         .value &&
                                                    //     controller
                                                    //             .responseCodeQuizReply
                                                    //             .value ==
                                                    //         200 &&
                                                    //     controller.quizReplyList
                                                    //         .isNotEmpty)
                                                      listViewComments(),
                                                  ],
                                                ),



                                          if (controller
                                                  .selectedChapter.value !=
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
                              floatingButtonForShowMusicPlayer(),
                            if (controller.quizpopupvalue.value == 0 &&
                                controller.selectedChapter.value == "Quiz" &&popupvalue==4)
                              FutureBuilder<bool>(
                                future: showPopup.shouldShowPopup(),
                                builder: (context, snapshot) {
                                  if (isUserLogin.isEmpty) {
                                    // Show your popup here
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      insetPadding: EdgeInsets.only(
                                        bottom: 400,
                                        left: 60,
                                        right: 60,
                                      ),
                                      alignment: Alignment.topCenter,
                                      elevation: 3.0,
                                      backgroundColor: Colors.red,
                                      child: CustomPaint(
                                        painter: ArrowDialogPainter(),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          strokeWidth: 1,
                                          dashPattern: [10, 7],
                                          color: Col.primary,
                                          radius: Radius.circular(5),
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                    child: Text(
                                                        'Write answers to quizzes related to the book.',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              "Open Sans",
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ))),
                                                Center(
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                    onPressed: () {
                                                      controller.quizpopupvalue
                                                          .value++;
                                                      print(controller
                                                          .quizpopupvalue
                                                          .value++);
                                                    },
                                                    child: Text('Got It'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    // Loading indicator or placeholder
                                    return SizedBox();
                                  }
                                },
                              ),
                            if (controller.quizpopupvalue.value == 1&&popupvalue==4)
                              Obx(() {
                                print(
                                    " value called ${controller.quizpopupvalue.value}");
                                return controller.quizpopupvalue.value == 1
                                    ? FutureBuilder<bool>(
                                        future: showPopup.shouldShowPopup(),
                                        builder: (context, snapshot) {
                                          if (isUserLogin.isEmpty) {
                                            // Show your popup here
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              insetPadding: EdgeInsets.only(
                                                bottom: 400,
                                                left: 60,
                                                right: 60,
                                              ),
                                              alignment: Alignment.topCenter,
                                              elevation: 3.0,
                                              backgroundColor: Colors.red,
                                              child: CustomPaint(
                                                painter: ArrowDialogPainter(),
                                                child: DottedBorder(
                                                  borderType: BorderType.RRect,
                                                  strokeWidth: 1,
                                                  dashPattern: [10, 7],
                                                  color: Col.primary,
                                                  radius: Radius.circular(5),
                                                  padding: EdgeInsets.all(5),
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10, left: 10),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                            child: Text(
                                                                'Write answers to quizzes related to the book.',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Open Sans",
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ))),
                                                        Center(
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .quizpopupvalue
                                                                  .value++;
                                                            },
                                                            child:
                                                                Text('Got It'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            // Loading indicator or placeholder
                                            return SizedBox();
                                          }
                                        },
                                      )
                                    : SizedBox();
                              }),
                          ],
                        ),
                    ],
                  ),
                  if (controller.popupValue.value == 4 && popupvalue==4)
                    FutureBuilder<bool>(
                      future: showPopup.shouldShowPopup(),
                      builder: (context, snapshot) {
                        if (isUserLogin.isEmpty) {
                          // Show your popup here
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            insetPadding: EdgeInsets.only(
                              top: 170,
                              left: 70,
                              right: 50,
                            ),
                            alignment: Alignment.topCenter,
                            elevation: 3.0,
                            backgroundColor: Colors.red,
                            child: CustomPaint(
                              painter: ArrowDialogPainter(),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                strokeWidth: 1,
                                dashPattern: [10, 7],
                                color: Col.primary,
                                radius: Radius.circular(5),
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      showPopup.widgetRow(  Image.asset(C.imageArrowUpKeyBoardLogo,height: 20,width: 20,), C.readbookPopupFirst),
                                      SizedBox(height: 8,),

                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            controller.popupValue.value++;
                                            controller.setPopupKey(controller.popupValue.value);
                                          },
                                          child: Text('Got It'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Loading indicator or placeholder
                          return SizedBox();
                        }
                      },
                    ),
                  if (controller.popupValue.value ==5&&popupvalue==4)
                    FutureBuilder<bool>(
                      future: showPopup.shouldShowPopup(),
                      builder: (context, snapshot) {
                        if (isUserLogin.isEmpty) {
                          // Show your popup here
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            insetPadding: EdgeInsets.only(
                              top: 100,
                              left: 70,
                              right: 10,
                            ),
                            alignment: Alignment.topCenter,
                            elevation: 3.0,
                            backgroundColor: Colors.red,
                            child: CustomPaint(
                              painter: ArrowDialogPainter(),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                strokeWidth: 1,
                                dashPattern: [10, 7],
                                color: Col.primary,
                                radius: Radius.circular(5),
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      showPopup.widgetRow(  Image.asset(C.imageComaLogo,height: 20,width: 20,), C.readbookPopupSecond),

                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            controller.popupValue.value++;
                                            controller.setPopupKey(controller.popupValue.value);
                                          },
                                          child: Text('Got It'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Loading indicator or placeholder
                          return SizedBox();
                        }
                      },
                    ),
                  if (controller.popupValue.value == 6&&popupvalue==4)
                    FutureBuilder<bool>(
                      future: showPopup.shouldShowPopup(),
                      builder: (context, snapshot) {
                        if (isUserLogin.isEmpty) {
                          // Show your popup here
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            insetPadding: EdgeInsets.only(
                              bottom: 140,
                              left: 40,
                              right: 20,
                            ),
                            alignment: Alignment.bottomCenter,
                            elevation: 3.0,
                            backgroundColor: Colors.red,
                            child: CustomPaint(
                              painter: ArrowDialogPainter(),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                strokeWidth: 1,
                                dashPattern: [10, 7],
                                color: Col.primary,
                                radius: Radius.circular(5),
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Text(
                                              'Control audio playback with options for pause, play, forward, backward, speed adjustment, and hiding/unhiding the audio panel.',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Open Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ))),
                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            controller.popupValue.value++;
                                            controller.setPopupKey(controller.popupValue.value);
                                          },
                                          child: Text('Got It'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Loading indicator or placeholder
                          return SizedBox();
                        }
                      },
                    ),
                  if (controller.popupValue.value == 7&&popupvalue==4)
                    FutureBuilder<bool>(
                      future: showPopup.shouldShowPopup(),
                      builder: (context, snapshot) {
                        if (isUserLogin.isEmpty) {
                          // Show your popup here
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            insetPadding: EdgeInsets.only(
                              bottom: 10,
                              left: 40,
                              right: 20,
                            ),
                            alignment: Alignment.center,
                            elevation: 3.0,
                            backgroundColor: Colors.red,
                            child: CustomPaint(
                              painter: ArrowDialogPainter(),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                strokeWidth: 1,
                                dashPattern: [10, 7],
                                color: Col.primary,
                                radius: Radius.circular(5),
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          child: Text(
                                              'Tap and hold on a word for its dictionary definition',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Open Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ))),
                                      Center(
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () {
                                            controller.popupValue.value++;
                                            controller.setPopupKey(controller.popupValue.value);
                                          },
                                          child: Text('Got It'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          // Loading indicator or placeholder
                          return SizedBox();
                        }
                      },
                    ),
                ],
              ),
            );
    } else {
      return Scaffold(
          backgroundColor: controller.isDarkMode.value &&
                  controller.selectedChapter.value != "Quiz"
              ? Col.darkAppBar
              : Theme.of(Get.context!).scaffoldBackgroundColor,
          body: Stack(
            children: [
              Column(
                children: [
                  appBarView(),
                  if (controller.responseCode.value == 0)
                    const SizedBox()
                  else
                    CW.commonNoDataFoundImage(
                      onRefresh: () async {},
                    ),
                ],
              ),
            ],
          ));
    }
  }

  Widget appBarView() {
    return CW.commonAppBarWithActon(
        wantDarkMode: controller.selectedChapter.value != "Quiz" &&
            controller.isDarkMode.value,
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
        wantSwitch: controller.selectedChapter.value != "Quiz" &&
            controller.chapterList.isNotEmpty,
        modeValue: controller.modeValue.value,
        isSelected: [controller.modeValue.value].obs,
        onChanged: (value) {
          if (controller.onchangeValue == 0) {
            controller.modeValue.value=!controller.modeValue.value;
            controller.modeOnChange(value: !controller.modeValue.value);
            print("mode value${controller.modeValue.value}");
            if (controller.modeValue.value == false) {
              controller.modeValue.value = true;

              controller.modeOnChange(value: controller.modeValue.value);
            } else {
              controller.modeValue.value = false;

              controller.modeOnChange(value: controller.modeValue.value);
            }

            controller.onchangeValue++;
            print("Onchange value called ${controller.onchangeValue}");
          } else if (controller.modeValue.value == true) {
            controller.modeValue.value = false;
            controller.modeOnChange(value: controller.modeValue.value);

          } else {
            controller.modeValue.value = true;
            controller.modeOnChange(value: controller.modeValue.value);

          }
        });
  }

  Widget appBarViewForZoom() =>
      CW.commonAppBarWithoutActon(title: "", wantBackButton: false);

  Widget buttonViewDropDown() => Obx(
        () => DropdownView<Chapters>(
          hintText: controller.selectedChapter.value.isNotEmpty
              ? controller.selectedChapter.value
              : 'Select Chapter',
          isQuiz: controller.selectedChapter.value == "Quiz",
          hintStyle: CT.openSansDisplayMedium(),
          isDarkMode: controller.isDarkMode.value,
          items: controller.chapterList
              .map(
                (Chapters e) => DropdownMenuItem<Chapters>(
                    value: e,
                    child: Container(
                      padding: EdgeInsets.all(8.px),
                      margin: EdgeInsets.only(bottom: 5.px),
                      decoration: BoxDecoration(
                          color: e.chapterName != "Quiz"
                              ? controller.isDarkMode.value
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
                            style: Theme.of(Get.context!)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontFamily: C.fontOpenSans,
                                  color: e.chapterName != "Quiz"
                                      ? controller.isDarkMode.value
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
                await controller.player.seek(const Duration(milliseconds: 0));
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

  Widget imageViewArrowUp() => Image.asset(
        C.imageArrowUpKeyBoardLogo,
        height: 10.px,
        width: 25.px,
        color: controller.selectedChapter.value != "Quiz"
            ? controller.isDarkMode.value
                ? Col.inverseSecondary
                : Col.secondary
            : Col.secondary,
      );

  Widget imageViewArrowDown() => Image.asset(
        C.imageArrowDownKeyBoardLogo,
        height: 10.px,
        width: 25.px,
      );

  Widget textViewChapterContent() => SelectableText(
        CM.parseHtmlString(controller.selectedChapterContent.value),
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            fontFamily: controller.setFontFamily.value,
            fontSize: controller.selectFontSize.value,
            fontStyle: controller.setFontStyle.value,
            color:

            // controller.isDarkMode.value
            //     ? Colors.white
            //     :
            controller.textColor.value),
        //: Colors.black),
        textAlign: controller.setTextAlign.value,
        onSelectionChanged: (selection, cause) =>
            controller.onTextSelection(selection: selection, cause: cause),
      );

  Widget listViewQuiz() => ListView.builder(
        controller: ScrollController(),
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.quizList[index].question != null)
                textViewQuestion(index: index),
            //  if (isUserSubscribed == true)
                SizedBox(
                  height: 10.px,
                ),
             // if (isUserSubscribed == true)
                textFiledViewReply(index: index,context: context),
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
  PopupMenuItem BGImagesDialog(BuildContext context) {
    print(" images value ${controller.setFontFamily.value}");
    return PopupMenuItem(
        child: Container(
          child: Column(children: [
            DropdownButton<BankListDataModel>(
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: "verdana_regular",
              ),
              hint: Text(
                "Select Image",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: "verdana_regular",
                ),
              ),
              items: controller.bgImageList
                  .map<DropdownMenuItem<BankListDataModel>>(
                      (BankListDataModel value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Row(
                        children: [
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: CustomImageView(
                                imagePath: value.bank_logo.value,
                                height: 30,
                                width: 30,
                                fit: BoxFit.cover,
                                radius: BorderRadius.circular(30),
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            value.bank_name.value,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              isExpanded: true,
              isDense: true,
              onChanged: (BankListDataModel? newSelectedBank) {
                controller.onDropDownItemSelected(newSelectedBank!);
                Navigator.pop(context);
              },
              value: controller.imageChoose.value,
            )
          ]),
        ));

    //   AlertDialog(
    //
    //   title: const Text('Pick a color!'),
    //   content: SingleChildScrollView(
    //     child: MaterialPicker(
    //       // pickerColor: mycolor, //default color
    //       onColorChanged: (Color color) {
    //         //on the color picked
    //
    //       }, pickerColor: controller.textColor.value,
    //     ),
    //   ),
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: const Text('DONE',style: TextStyle(color: Colors.black),),
    //       onPressed: () {
    //         Navigator.of(context)
    //             .pop(); //dismiss the color picker
    //       },
    //     ),
    //   ],
    // );
  }
  Widget textViewGetPremium() => Text(
    C.textGetPremium,
    style: CT.alegreyaDisplaySmall(),
  );
  Widget textViewDownload() => Text(
    C.textDownloadNowAnd,
    style: CT.openSansBodySmall(),
  );
  Widget imageViewPremium() => Image.asset(
    C.imageGetPremium,
    height: 100.px,
    width: 100.px,
  );

  Widget textFiledViewReply({required int index,required BuildContext context}) {

    return controller.userStatus.value == "active"
        ?CW.commonTextFieldForLoginSignUP(
      borderRadius: 20.px,
      hintText: C.textReply,
      maxHeight: 40.px,





      elevation: 0,



      controller: controller.controllerList[index],
    )
    :TextFormField(
      readOnly: true,
      onTap: () {
        _showDialog(context);
      },

      style: Theme.of(Get.context!)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: C.fontOpenSans, color: Col.onSecondary),


      decoration: InputDecoration(
        contentPadding:  EdgeInsets.symmetric(horizontal: 20.px),
        prefixIcon: Icon(Icons.lock_outline,color: Colors.black,),
        border: OutlineInputBorder(
            borderSide:
                 BorderSide.none,
            borderRadius:
            BorderRadius.circular( C.loginTextFieldRadius)),

        fillColor: Colors.white,
        filled: true,





      ),







      controller: controller.controllerList[index],
    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          content: Text('Please subscribe to access this feature.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'
                  ''),
            ),
          ],
        );
      },
    );
  }

  Widget buttonViewSubmit() => CW.commonElevatedButton(
      onPressed: () => controller.clickOnSubmitButton(),
      child: Text(
        C.textSubmit,
        style: CT.openSansTitleMedium(),
      ),
      borderRadius: 5.px,
      buttonColor: Col.primaryColor);

  Widget textViewComments() => Text(
        C.viewAnswers,
        style: CT.openSansDisplayMedium(),
      );

  Widget buttonViewEyeShowHide() => FloatingActionButton(
        onPressed: () => controller.clickOnCommentHideShowButton(),
        backgroundColor: Colors.transparent,
        splashColor: Colors.white12,
        elevation: 0.px,
        heroTag: null,
        highlightElevation: 0.px,
        child: Obx(() {
          return controller.isCommentHidden.value
              ? Image.asset(
            C.imageEyeShowLogo,
            height: 25.px,
            width: 25.px,
          )
              : Image.asset(
            C.imageEyeHideLogo,
            height: 25.px,
            width: 25.px,
          );
        }),
      );

  Widget listViewComments() => ListView.builder(

        controller: ScrollController(),
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,

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

  Widget textViewCommentUserName({required int index}) => Text(
        controller.quizReplyList[index].userdetails?.name ?? "",
        style: CT.openSansBodyMedium(),
      );

  Widget textViewCommentDis({required int index}) => Text(
        C.textReviewDis,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CT.openSansBodySmall(),
      );

  Widget floatingButtonForShowMusicPlayer() => Padding(
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
          color: controller.isDarkMode.value ? Col.darkGray : Col.borderColor,
          child: ListView(
            controller: ScrollController(),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              if (controller.clickOnAudioSpeed.value)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.px),
                  margin: EdgeInsets.symmetric(
                      horizontal: C.margin, vertical: C.margin),
                  decoration: BoxDecoration(
                      color: Col.borderColor,
                      border: Border.all(color: Col.secondary, width: 1.px),
                      borderRadius: BorderRadius.circular(10.px)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: C.margin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textViewCommonForSlider("85"),
                            textViewCommonForSlider("90"),
                            textViewCommonForSlider("95"),
                            textViewCommonForSlider("100"),
                            textViewCommonForSlider("105"),
                            textViewCommonForSlider("110"),
                            textViewCommonForSlider("115"),
                            textViewCommonForSlider("120"),
                          ],
                        ),
                      ),
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.symmetric(vertical: 3.px),
                          child: SizedBox(
                            height: 20.px,
                            child: Slider(
                              value: controller.value.value,
                              min: 0,
                              max: 8.0,
                              divisions: 7,
                              label: controller.selectedMenu.value.toString(),
                              onChanged: (double value) async {
                                controller.value.value = value;
                                await controller.getProgress(
                                    controller.value.value.toInt());
                              },
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Click on Bar to Choose Listening Speed = ${controller.selectedMenu.value}",
                        style: CT.openSansTitleSmall(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: 13.px, bottom: 8.px, top: 8.px),
                      child: SizedBox(
                        height: 30.px,
                        child: buttonViewEyeHide(),
                      ),
                    ),
                  ],
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
    } else if (controller.selectedChapter.value == "Quiz" &&
        controller.wantScrollBackButton.value) {
      return Padding(
        padding: EdgeInsets.all(C.margin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedOpacity(
              opacity: controller.wantScrollBackButton.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 3000),
              child: FloatingActionButton(
                  onPressed: () => controller.clickOnArrowUpButton(),
                  heroTag: null,
                  elevation: 0.2,
                  backgroundColor: Col.primaryColor,
                  child: Icon(
                    Icons.arrow_upward,
                    color: Col.secondary,
                  )),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget textViewCommonForSlider(String value) {
    return Text(
      value,
      style: Theme.of(Get.context!)
          .textTheme
          .titleSmall
          ?.copyWith(fontFamily: C.fontOpenSans, fontSize: 12.px),
    );
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

  Widget buttonViewEyeHide() => FloatingActionButton(
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

  Widget textViewDurationOfMusic() => Text(
        controller.currentPositionLabel.value,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: C.fontOpenSans, fontSize: 12.px),
      );

  Widget buttonViewPlayPause() => FloatingActionButton(
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

  Widget buttonViewAudioSpeed() => Obx(
        () => FloatingActionButton(
          backgroundColor: Colors.transparent,
          splashColor: Colors.white12,
          elevation: 0.px,
          heroTag: null,
          highlightElevation: 0.px,
          onPressed: () => controller.clickOnAudioSpeedFunction(),
          child: Container(
            height: 25.px,
            width: 38.5.px,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Col.secondary, width: 1.px)),
            child: Center(
              child: Text(
                "${controller.selectedMenu.value}x",
                style: Theme.of(Get.context!)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontFamily: C.fontOpenSans, fontSize: 12.px),
              ),
            ),
          ),
        ),
      );

  Widget floatingButtonForZoomIn() => Padding(
        padding: EdgeInsets.only(bottom: 20.px),
        child: CW.commonElevatedButton(
          borderRadius: 11.px,
          buttonColor: Colors.transparent,
          onPressed: () => controller.clickOnZoomButton(),
          child: Image.asset(
            C.imageZoomInLogo,
            height: 35.px,
            width: 35.px,
          ),
        ),
      );

  Widget volumeBarView() => FloatingActionButton(
        backgroundColor: Colors.transparent,
        splashColor: Colors.white12,
        elevation: 0.px,
        heroTag: null,
        highlightElevation: 0.px,
        onPressed: () {},
        child: Obx(() => PopupMenuButton(
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
              itemBuilder: (BuildContext context) => <PopupMenuItem>[
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  value: controller.getVolume.value,
                  child: Obx(() => Container(
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
        splashRadius: 35.px,
        position: PopupMenuPosition.under,
        color: Colors.white,
        shadowColor: Colors.transparent,
        itemBuilder: (context) => [
          commonPopUpMenuItem(context,
              image: C.imagePopUpIconTwo,
              function: TextColorDialog(context),
              setValue: "Text Color"),
          commonPopUpMenuItem(context,
              image: C.imagePopUpIconThree,
              function: BackgroundColorDialog(context),
              setValue: "BG Color"),
          commonPopUpMenuItem(context,
              image: C.imagePopUpIconBGImage,
              function: BGImagesDialog(context),
              setValue: "BG Texture"),
          commonPopUpMenuItem(context,
              image: C.imagePopUpIconSix,
              function: FontSizeDialog(context),
              setValue: "Font Size"),
          commonPopUpMenuItem(context,
              image: C.imagePopUpIconFour,
              function: FontFamilyDialog(context),
              setValue: "Font Family"),
          commonPopUpMenuItem(context,
              image: C.imagePopUpIconFive,
              function: FontStyleDialog(context),
              setValue: "Font Style"),
          commonPopUpMenuItem(context,
              image: C.imagePopUpIconEight,
              function: FontAlignDialog(context),
              setValue: "Font Align"),
        ],
        child: Image.asset(
          C.imageComaLogo,
          color: controller.isDarkMode.value
              ? Col.inverseSecondary
              : Col.secondary,
          height: 25.px,
          width: 25.px,
        ),
      ),
    );
  }

  PopupMenuItem commonPopUpMenuItem(contaxt,
      {required String image,
      required PopupMenuItem<dynamic> function,
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
                height: 35.px,
                width: 90.px,
                child: Container(
                  height: 30.px,
                  width: 90.px,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    border: Border.all(color: Col.surface, width: 1.px),
                  ),
                  child: PopupMenuButton(
                    icon: Text(
                      setValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11),
                    ),
                    itemBuilder: (context) => [function],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  PopupMenuItem TextColorDialog(BuildContext context) {
    return PopupMenuItem(
      child: Container(
          child: Obx(
        () => Column(
          children: [
            Container(
              width: 140,
              height: 350,
              padding: EdgeInsets.zero,
              child: MaterialPicker(
                // pickerColor: mycolor, //default color
                onColorChanged: (Color color) {
                  //on the color picked
                  controller.changeTextColor(color);
                  print('Color updated ${controller.textColor.value}');
                },
                pickerColor: controller.textColor.value,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      )),
    );

    //   AlertDialog(
    //
    //   title: const Text('Pick a color!'),
    //   content: SingleChildScrollView(
    //     child: MaterialPicker(
    //       // pickerColor: mycolor, //default color
    //       onColorChanged: (Color color) {
    //         //on the color picked
    //
    //       }, pickerColor: controller.textColor.value,
    //     ),
    //   ),
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: const Text('DONE',style: TextStyle(color: Colors.black),),
    //       onPressed: () {
    //         Navigator.of(context)
    //             .pop(); //dismiss the color picker
    //       },
    //     ),
    //   ],
    // );
  }

  PopupMenuItem BackgroundColorDialog(BuildContext context) {
    return PopupMenuItem(
      child: Container(
          child: Obx(
        () => Column(
          children: [
            Container(
              width: 200.px,
              height: 150,
              child: BlockPicker(
                pickerColor: controller.backGroundColor.value, //default color
                availableColors: [
                  Colors.red,
                  Colors.pink,
                  Colors.green,
                  Colors.blue,
                  Colors.purple,
                  Colors.yellow,
                  Colors.orange,
                  Colors.grey,
                  Colors.brown,
                  Colors.white,
                  Colors.black,
                ],

                onColorChanged: (Color color) {
                  print('this is my color ${color.value}');

                  //on the color picked
                  controller.changeBackgroundColor(color);
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      )),
    );

    //   AlertDialog(
    //
    //   title: const Text('Pick a color!'),
    //   content: SingleChildScrollView(
    //     child: MaterialPicker(
    //       // pickerColor: mycolor, //default color
    //       onColorChanged: (Color color) {
    //         //on the color picked
    //
    //       }, pickerColor: controller.textColor.value,
    //     ),
    //   ),
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: const Text('DONE',style: TextStyle(color: Colors.black),),
    //       onPressed: () {
    //         Navigator.of(context)
    //             .pop(); //dismiss the color picker
    //       },
    //     ),
    //   ],
    // );
  }

  PopupMenuItem FontSizeDialog(BuildContext context) {
    return PopupMenuItem(
        child: Container(
      child: Obx(() => Column(children: [
            DropdownButton<double>(
              dropdownColor: Colors.white,
              value: controller.selectFontSize.value,
              onChanged: (newValue) {
                controller.changeFontSize(newValue);
                print(controller.selectFontSize.value);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              items: <DropdownMenuItem<double>>[
                for (double i = 10.00; i <= 30; i++)
                  DropdownMenuItem<double>(
                    value: i,
                    child: Text('$i'),
                  ),
              ],
            ),
          ])),
    ));

    //   AlertDialog(
    //
    //   title: const Text('Pick a color!'),
    //   content: SingleChildScrollView(
    //     child: MaterialPicker(
    //       // pickerColor: mycolor, //default color
    //       onColorChanged: (Color color) {
    //         //on the color picked
    //
    //       }, pickerColor: controller.textColor.value,
    //     ),
    //   ),
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: const Text('DONE',style: TextStyle(color: Colors.black),),
    //       onPressed: () {
    //         Navigator.of(context)
    //             .pop(); //dismiss the color picker
    //       },
    //     ),
    //   ],
    // );
  }

  PopupMenuItem FontStyleDialog(BuildContext context) {
    return PopupMenuItem(
        child: Container(
      child: Obx(() => Column(children: [
            DropdownButton<FontStyle>(
              value: controller.setFontStyle.value,
              onChanged: (newValue) {
                controller.changeTextFontStyle(newValue);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              items: controller.listFontStyle.value,
            ),
          ])),
    ));

    //   AlertDialog(
    //
    //   title: const Text('Pick a color!'),
    //   content: SingleChildScrollView(
    //     child: MaterialPicker(
    //       // pickerColor: mycolor, //default color
    //       onColorChanged: (Color color) {
    //         //on the color picked
    //
    //       }, pickerColor: controller.textColor.value,
    //     ),
    //   ),
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: const Text('DONE',style: TextStyle(color: Colors.black),),
    //       onPressed: () {
    //         Navigator.of(context)
    //             .pop(); //dismiss the color picker
    //       },
    //     ),
    //   ],
    // );
  }

  PopupMenuItem FontFamilyDialog(BuildContext context) {
    return PopupMenuItem(
        child: Container(
      child: Obx(() => Column(children: [
            DropdownButton<String>(
              value: controller.setFontFamily.value,
              onChanged: (newValue) {
                controller.changeFontFamily(newValue);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              items: controller.listFontFamily.value,
            ),
          ])),
    ));

    //   AlertDialog(
    //
    //   title: const Text('Pick a color!'),
    //   content: SingleChildScrollView(
    //     child: MaterialPicker(
    //       // pickerColor: mycolor, //default color
    //       onColorChanged: (Color color) {
    //         //on the color picked
    //
    //       }, pickerColor: controller.textColor.value,
    //     ),
    //   ),
    //   actions: <Widget>[
    //     ElevatedButton(
    //       child: const Text('DONE',style: TextStyle(color: Colors.black),),
    //       onPressed: () {
    //         Navigator.of(context)
    //             .pop(); //dismiss the color picker
    //       },
    //     ),
    //   ],
    // );
  }



  PopupMenuItem FontAlignDialog(BuildContext context) {
    return PopupMenuItem(
        child: Container(
      child: Obx(() => Column(children: [
            DropdownButton<TextAlign>(
              value: controller.setTextAlign.value,
              onChanged: (newValue) {
                controller.changeTextAlignment(newValue);

                Navigator.pop(context);
                Navigator.pop(context);
              },
              items: controller.listTextAlign.value,
            ),
          ])),
    ));


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

  DropdownView(
      {Key? key,
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
        builder: (context, setState) => Stack(
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

class BankListDataModel {
  RxString bank_name;
  RxString bank_logo;
  BankListDataModel(this.bank_name, this.bank_logo);
}
