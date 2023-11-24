import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/video_book_controller.dart';

// ignore: must_be_immutable
class VideoBookView extends GetView<VideoBookController> {
  @override
  // ignore: overridden_fields
  String? tag;
  String? bookId;
  String? categoryId;
  bool? isLiked;
  @override
  late VideoBookController controller;

  VideoBookView(
      {super.key,
      Key? k,
      this.tag,
      this.bookId,
      this.categoryId,
      this.isLiked}) {
    controller = Get.find(
      tag: tag,
    );
    if (controller.intValue == 1) {
      controller.id = tag ?? "";
      controller.bookId = bookId ?? "";
      controller.categoryId = categoryId ?? "";
      controller.like = isLiked ?? false;
      controller.intValue = 0;
      controller.myOnInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (
        buildContext,
        orientation,
        screenType,
      ) =>
          Obx(
        () => ModalProgress(
          inAsyncCall: controller.inAsyncCall.value,
          child: WillPopScope(
            onWillPop: () => controller.clickOnBackButton(),
            child: Scaffold(
              backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
              body: Column(
                children: [
                  appBarView(),
                  if (controller.responseCode.value == 200)
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ListScrollBehaviour(),
                        child: CW.commonRefreshIndicator(
                          onRefresh: () => controller.onRefresh(),
                          child: ListView(
                            padding: EdgeInsets.only(top: 27.px),
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: C.margin),
                                child: YoutubePlayerBuilder(
                                  builder: (context, player) => SizedBox(
                                    height: orientation == Orientation.portrait
                                        ? 340.px
                                        : 273.px,
                                    child: player,
                                  ),
                                  player: YoutubePlayer(
                                    controller: controller.videoController,
                                    showVideoProgressIndicator: true,
                                    onReady: () {},
                                  ),
                                ),
                              ),
                              if (controller.getVideoBook.value?.book
                                      ?.bookDescription !=
                                  null)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: C.margin,
                                      right: C.margin,
                                      top: orientation==Orientation.portrait?10.px:40.px),
                                  child: textViewOverView(),
                                ),
                              if (controller.getVideoBook.value?.book
                                      ?.bookDescription !=
                                  null)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.px, horizontal: C.margin),
                                  child: textViewOverViewDis(),
                                ),

                              if (controller.responseCodeSimilarBook.value ==
                                      200 &&
                                  controller.getSimilarBookModel.value?.books !=
                                      null &&
                                  controller.getSimilarBookModel.value!.books!
                                      .isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: C.margin),
                                  child: listTitleView(
                                    text: C.textSimilarBooks,
                                    onPressed: () =>
                                        controller.clickOnSeeMoreBooks(
                                            id: C.textSimilarBooks),
                                  ),
                                ),
                              if (controller.responseCodeSimilarBook.value ==
                                      200 &&
                                  controller.getSimilarBookModel.value?.books !=
                                      null &&
                                  controller.getSimilarBookModel.value!.books!
                                      .isNotEmpty)
                                listViewBooks(),
                              SizedBox(
                                height: C.margin,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.commonAppBarWithActon(
        wantSelectedLikeButton: controller.isLiked.value,
        wantInfoButton: true,
        clickOnInfoButton: () => controller.clickOnInFoButton(),
        clickOnBackButton: () => controller.clickOnBackButton(),
        clickOnLikeButton: () => controller.clickOnLikeAppBarButton(),
        clickOnShareButton: () => controller.clickOnShareButton(),
      );

  Widget textViewOverView() => Text(
        C.textOverview,
        style: CT.openSansBodyMedium(),
        textAlign: TextAlign.start,
      );

  Widget textViewOverViewDis() {
    return CW.commonReadMoreText(
      value: CM.parseHtmlString(
          controller.getVideoBook.value?.book?.bookDescription ?? ""),
      maxLine: 7,
    );
  }

  Widget listTitleView(
          {required String text, required VoidCallback onPressed}) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 3.px,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textViewTitle(text: text),
            buttonViewSeeMore(onPressed: onPressed),
          ],
        ),
      );

  Widget textViewTitle({required String text}) => Text(
        text,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget buttonViewSeeMore({required VoidCallback onPressed}) =>
      CW.commonTextButton(onPressed: onPressed, child: textviewSeeMore());

  Widget textviewSeeMore() => Text(
        C.textSeeMore,
        style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
            fontSize: 12.px,
            fontFamily: C.fontOpenSans,
            fontWeight: FontWeight.w700),
      );

  Widget listViewBooks() => Container(
    height: C.bookHorizontalListCardHeight,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.only(left: C.margin),
    child: ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => controller.clickOnParticularBookForList(
          index: index,
        ),
        child: Container(
            height: C.bookHorizontalListCardHeight,
            width: C.bookHorizontalListCardWidth,
            margin: EdgeInsets.only(right: C.bookHorizontalListMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: C.bookHorizontalListHeight,
                        width: C.bookHorizontalListWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(C.bookHorizontalListRadius),
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: C.bookHorizontalListHeight,
                              width:C.bookHorizontalListWidth,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(C.bookHorizontalListRadius),
                                child: imageViewBookForList(
                                    value: controller
                                        .bookList[index].bookThumbnail),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.px),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (controller.bookList[index].isAudio !=
                                      null &&
                                      controller.bookList[index].isAudio ==
                                          "1")
                                    SizedBox(
                                      height: 25.px,
                                      width: 25.px,
                                      child: buttonViewSound(index: index),
                                    ),
                                  if (controller.bookList[index].isAudio !=
                                      null &&
                                      controller.bookList[index].isAudio ==
                                          "1")
                                    SizedBox(
                                      width: 5.px,
                                    ),
                                  if (controller.getSimilarBookModel.value
                                      ?.favorite !=
                                      null &&
                                      controller.getSimilarBookModel.value!
                                          .favorite!
                                          .contains(controller
                                          .bookList[index].id
                                          .toString()))
                                    SizedBox(
                                      height: 25.px,
                                      width: 25.px,
                                      child: buttonViewLike(index: index),
                                    )
                                ],
                              ),
                            ),
                          ],
                        )),
                    CW.commonPaddingForBookContent(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.px,
                          ),
                          if (controller
                              .bookList[index].title !=
                              null)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textViewBookNameForBookList(
                                    value: controller.bookList[index]
                                        .title ??
                                        "")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (controller.bookList[index].rating !=
                                  null)
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 2.px, right: 4.px),
                                      child: imageViewStar(),
                                    ),
                                    textViewRatting(
                                        value: controller.bookList[index]
                                            .rating ??
                                            "")
                                  ],
                                ),
                              if (controller.bookList[index].rating !=
                                  null)
                                SizedBox(
                                  width: 10.px,
                                ),
                              if (controller.bookList[index].views !=
                                  null)
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding:
                                        EdgeInsets.only(right: 4.px),
                                        child: imageViewEye()),
                                    textViewViewers(
                                        value: controller.bookList[index]
                                            .views ??
                                            ''),
                                  ],
                                )
                            ],
                          ),
                          if (controller.bookList[index].authorName !=
                              null)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: textViewAuthorNameForBookList(
                                  value: controller.bookList[index]
                                      .authorName ??
                                      ''),
                            ),
                        ],
                      ),
                    )
                    /*  SizedBox(
                          height: 5.px,
                        ),
                        if (controller.bookList[index].title != null)
                          textViewBookNameForBookList(
                              value: controller.bookList[index].title ?? ""),
                        if (controller.bookList[index].title != null)
                          SizedBox(
                            height: 5.px,
                          ),
                        if (controller.bookList[index].authorName != null)
                          textViewAuthorNameForBookList(
                              value:
                                  controller.bookList[index].authorName ?? ""),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (controller.bookList[index].rating != null)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 2.px),
                                    child: imageViewStar(),
                                  ),
                                if (controller.bookList[index].rating != null)
                                  textViewRatting(
                                      value:
                                          controller.bookList[index].rating ??
                                              "")
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (controller.bookList[index].views != null)
                                  imageViewEye(),
                                if (controller.bookList[index].views != null)
                                  textViewViewers(
                                      value: controller.bookList[index].views ??
                                          ""),
                              ],
                            )
                          ],
                        )*/
                  ],
                ),
              ],
            )),
      ),
      itemCount: controller.bookList.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
    ),
  );

  Widget imageViewBookForList({String? value}) {
    if (value != null) {
      return Image.network(
        CM.getImageUrl(value: value),
        fit: BoxFit.fill,
        height:C.bookHorizontalListHeight,
        width: C.bookHorizontalListWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height:C.bookHorizontalListHeight, width: C.bookHorizontalListWidth, radius:C.bookHorizontalListRadius);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageBookImage,
            fit: BoxFit.fill,
            height: C.bookHorizontalListHeight,
            width: C.bookHorizontalListWidth,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        fit: BoxFit.fill,
        height: C.bookHorizontalListHeight,
        width:  C.bookHorizontalListWidth,
      );
    }
  }

  Widget buttonViewSound({required int index}) => FloatingActionButton(
        onPressed: () => controller.clickOnSoundButton(index: index),
        heroTag: null,
        backgroundColor: Col.inverseSecondary,
        child: imageViewSound(index: index),
      );

  Widget imageViewSound({required int index}) => Image.asset(
        C.imageSoundLogo,
        height: 13.px,
        width: 15.px,
      );

  Widget buttonViewLike({required int index}) => FloatingActionButton(
        onPressed: () => controller.clickOnLikeButton(index: index),
        heroTag: null,
        backgroundColor: Col.inverseSecondary,
        child: imageViewLike(index: index),
      );

  Widget imageViewLike({required int index}) => Image.asset(
        C.imageBookLikeLogo,
        height: 15.px,
        width: 15.px,
      );

  Widget textViewBookNameForBookList({required String value}) => Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaBodySmall(),
    textAlign: TextAlign.start,

  );

  Widget textViewAuthorNameForBookList({required String value}) => Text(
        value,
        maxLines: 1,
        style: CT.alegreyaBodySmall(),
        textAlign: TextAlign.start,
      );

  Widget imageViewStar() => Image.asset(
        C.imageStarLogo,
        height: 15.px,
        width: 17.px,
      );

  Widget textViewRatting({required String value}) => Text(
        value,
        style: CT.openSansTitleSmall(),
      );

  Widget imageViewEye() => Image.asset(
        C.imageEyeLogo,
        height: 25.px,
        width: 20.px,
      );

  Widget textViewViewers({required String value}) =>
      Text(value, style: CT.openSansTitleSmall());
}
