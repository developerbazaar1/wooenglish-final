import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/load_more/load_more.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/quiz_detail_controller.dart';

// ignore: must_be_immutable
class QuizDetailView extends GetView<QuizDetailController> {
  @override
  // ignore: overridden_fields
  String? tag;
  String? quizId;
  String? bookId;
  bool? isLiked;
  Books? quiz;

  @override
  late QuizDetailController controller;

  QuizDetailView(
      {super.key,
      Key? k,
      this.tag,
      this.quizId,
      this.isLiked,
      this.bookId,
      this.quiz}) {
    controller = Get.find(
      tag: tag,
    );
    if (controller.intValue == 1) {
      controller.intValue = 0;
      controller.quizId = quizId ?? "";
      controller.isLiked.value = isLiked ?? false;
      controller.bookId = bookId ?? "";

      controller.quiz = quiz;
      controller.myOnInit();
    }
    print("this is $quizId");
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              appBarView(),
              Container(
                margin: EdgeInsets.only(
                    left: C.margin, right: C.margin, top: C.margin),
                padding: EdgeInsets.all(10.px),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.px),
                    color: Col.inverseSecondaryVariant),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.px),
                      child: imageViewUserProfile(),
                    ),
                    SizedBox(
                      width: 20.px,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (controller.quiz?.userdetails?.name != null)
                            textViewQuizUserName(),
                          /* if (controller.quiz?.userdetails?.name !=
                              null)
                            textViewCommentDis(),*/
                        ],
                      ),
                    )
                  ],
                ),
              ),
           
              Obx(() {
                if (AppController.isConnect.value) {
                  if (controller.responseCode.value == 200 ||
                      controller.getDataModel.value != null) {
                    if (controller.quizList.isNotEmpty) {
                      return Expanded(
                        child: ScrollConfiguration(
                          behavior: ListScrollBehaviour(),
                          child: CW.commonRefreshIndicator(
                            onRefresh: () => controller.onRefresh(),
                            child: RefreshLoadMore(
                              isLastPage: controller.isLastPage.value,
                              onLoadMore: () => controller.onLoadMore(),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                children: [

                                  listViewQuiz(),

                                  if (controller
                                          .getDataModel.value?.adminReply !=
                                      null)
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 15.px,
                                        left: C.margin,
                                        right: C.margin,
                                      ),
                                      child: Column(
                                        children: [

                                          Container(
                                            height: 60.px,
                                            decoration: BoxDecoration(
                                              color: Col.onSurface,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.px),
                                                topRight: Radius.circular(4.px),
                                                bottomLeft:Radius.circular(0.px),
                                                bottomRight: Radius.circular(0.px),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.px,
                                                  top: 5.px,
                                                  bottom: 5.px),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.px),
                                                    child:
                                                        imageViewReviewUserForList(),
                                                  ),
                                                  SizedBox(
                                                    width: 5.px,
                                                  ),

                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              textViewReviewUserForList(
                                                                  value: C
                                                                      .textWooEnglishOfficial),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            C.margin /
                                                                                2),
                                                                child: Icon(
                                                                  Icons
                                                                      .verified,
                                                                  color: Col
                                                                      .darkGreen,
                                                                  size: 18.px,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),


                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Col.inverseSecondary,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(4.px),
                                                bottomRight:
                                                    Radius.circular(4.px),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 15.px,
                                                  top: 8.px,
                                                  bottom: 8.px),
                                              child: textViewReadMore(
                                                  value: controller.getDataModel
                                                          .value?.adminReply ??
                                                      ""),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                //  if (controller.quiz?.userdetails?.status == 'active')

                                  Container(
                                    height: 62.px,
                                    margin: EdgeInsets.only(right: 15,left: 15),
                                    decoration: BoxDecoration(
                                      color: Col.onSurface,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4.px),
                                        topLeft: Radius.circular(4.px),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.px,
                                          top: 7.px,
                                          bottom: 7.px,
                                          right: 8.px),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(
                                                30.px),

                                            child: imageViewUserProfile(),),
                                          SizedBox(
                                            width: 20.px,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                if (controller.quiz?.userdetails?.name != null)
                                                  textViewQuizUserName(),

                            //                      if (controller.quiz?.userdetails?.name !=
                            //   null)
                            // textViewCommentDis(),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.px,
                                          ),

                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                  height: 25.px,
                                                  child: buttonViewSubmit())
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Container(

                                        decoration: BoxDecoration( borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(4.px),
                                          bottomLeft: Radius.circular(4.px),
                                        )),

                                        margin: EdgeInsets.only(right: 10.px,left: 10.px),
                                      child: textFieldReview(

                                      )
                                  ),

                                 if(controller.getCommentModel.value!=null)


                                     listCommet()


                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return CW.commonNoDataFoundImage(
                        onRefresh: () => controller.onRefresh(),
                      );
                    }
                  } else {
                    if (controller.responseCode.value == 0) {
                      return const SizedBox();
                    }
                    return CW.commonSomethingWentWrongImage(
                      onRefresh: () => controller.onRefresh(),
                    );
                  }
                } else {
                  return CW.commonNoInternetImage(
                    onRefresh: () => controller.onRefresh(),
                  );
                }
              }),

            ],
          ),
        ),
      );
    });
  }

  Widget textFieldReview() => CW.commonTextFieldForWriteSomething(
      wantBorder: false,
      maxHeight: 100.px,
      borderRadius: 0.px,
      elevation: 0.px,
      hintText: C.textWriteYourReply,
      controller: controller.submitCommentController,
      hintStyle: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
        fontFamily: C.fontOpenSans,
        color: Col.textGrayColor,
      ),
      keyboardType: TextInputType.multiline,
     // controller: controller.reviewController
      );
  Widget buttonViewSubmit() => CW.commonElevatedButton(
      onPressed: () => controller.clickOnSubmitComment(),
      child: textViewSubmit(),
      contentPadding: EdgeInsets.symmetric(horizontal: 7.px),
      borderRadius: 5.px,
      buttonColor: Col.primaryColor);
  Widget textViewSubmit() => Text(
    C.textSubmit,
    style: CT.openSansTitleMedium(),
  );

  Widget appBarView() => Obx(() => CW.commonAppBarWithActon(
        wantBookMarkButton: false,
        wantSelectedLikeButton: controller.isLiked.value,
        clickOnBackButton: () => controller.clickOnBackButton(),
        clickOnInfoButton: () => controller.clickOnInfoButton(),
        wantLikeButton: false,
        clickOnShareButton: () => controller.clickOnShareButton(),
      ));

  Widget imageViewUserProfile() {
    if (controller.quiz?.userdetails != null &&
        controller.quiz?.userdetails?.userImage != null) {
      return Image.network(
        CM.getImageUrl(value: controller.quiz?.userdetails?.userImage ?? ''),
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
  Widget imageCommentsProfile(int index) {
    if (controller.getCommentModel.value!.data != null ) {
      return Image.network(
        CM.getImageUrl(value: controller.getCommentModel.value!.data![index].userdetails!.userImage ?? ''),
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

  Widget textViewQuizUserName() => Text(
        controller.quiz?.userdetails?.name ?? "",
        style: CT.openSansBodyMedium(),
      );
  Widget textViewCommentUserName(int index) => Text(
        controller.getCommentModel.value!.data![index].userdetails?.name ?? "",
        style: CT.openSansBodyMedium(),
      );

  Widget textViewCommentDis() => Text(
        C.textReviewDis,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CT.openSansBodySmall(),
      );

  Widget listViewQuiz() => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.quizList[index].question != null)
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        right: 10.px, left: 10.px, bottom: 10.px, top: 5.px),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.px),
                            topRight: Radius.circular(15.px)),
                        color: Col.primaryColor.withOpacity(0.25)),
                    child: textViewQuestion(index: index)),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      right: 10.px, left: 10.px, bottom: 10.px, top: 5.px),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.px),
                          bottomRight: Radius.circular(15.px)),
                      color: Col.inverseSecondary),
                  child: textViewAnswer(index: index)),
              SizedBox(
                height: 18.px,
              ),
            ],
          );
        },
        shrinkWrap: true,
        itemCount: controller.quizList.length,
        padding: EdgeInsets.only(left: C.margin, right: C.margin, top: 18.px),
      );
  Widget listCommet() =>Obx(() => ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
   //   if (controller.getCommentModel.value!.data![index] != null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

            Container(
              height: 62.px,
              margin: EdgeInsets.only(right: 0,left: 0),
              decoration: BoxDecoration(
                color: Col.onSurface,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.px),
                  topLeft: Radius.circular(4.px),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 15.px,
                    top: 7.px,
                    bottom: 7.px,
                    right: 8.px),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(
                          30.px),

                      child: imageCommentsProfile(index),),
                    SizedBox(
                      width: 20.px,
                    ),
                    if (controller.quiz?.userdetails?.name != null)
                      textViewCommentUserName(index),
                    SizedBox(width: 5,),

                    if(controller.getCommentModel.value!.data![index].userdetails!.status=='active')
                      Icon(
                        Icons
                            .verified,
                        color: Col
                            .darkGreen,
                        size: 18.px,
                      ),


                  ],
                ),
              ),
            ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Col.inverseSecondary,
              borderRadius: BorderRadius.only(
                bottomLeft:
                Radius.circular(4.px),
                bottomRight:
                Radius.circular(4.px),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 15.px,
                  top: 8.px,
                  bottom: 8.px),
              child: textViewReadMore(
                  value: controller.getCommentModel
                      .value!.data![index].comment??
                      ""),
            ),
          ),


          SizedBox(
            height: 18.px,
          ),
        ],
      );
    },
    shrinkWrap: true,
    itemCount: controller.getCommentModel.value!.data!.length,
    padding: EdgeInsets.only(left: C.margin, right: C.margin, top: 18.px),
  ))
      ;

  Widget textViewQuestion({required int index}) => Text(
        "Q${index + 1}. ${controller.quizList[index].question ?? ""}",
        style: CT.openSansBodyMedium(),
      );

  Widget textViewAnswer({required int index}) => Text(
        " ${controller.quizList[index].answer ?? ""}",
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.onSecondary),
      );

  Widget imageViewReviewUserForList() {
    return Image.asset(
      C.imageWooEnglishAppLogo,
      height: 50.px,
      width: 50.px,
      fit: BoxFit.cover,
    );
  }

  Widget textViewReviewUserForList({required String value}) => Text(
        value,
        style: CT.openSansBodyMedium(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget textViewReadMore({required String value}) {
    return CW.commonReadMoreText(
      value: value,
    );
  }
}
