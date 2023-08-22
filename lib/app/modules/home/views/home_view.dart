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
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.inAsyncCall.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                appBarView(),
                Obx(() {
                  if (AppController.isConnect.value) {
                    if (controller.responseCode.value == 200) {
                      return Expanded(
                        child: ScrollConfiguration(
                          behavior: ListScrollBehaviour(),
                          child: CW.commonRefreshIndicator(
                            onRefresh: () => controller.onRefresh(),
                            child: ListView(
                              padding: controller
                                          .getDashBoarDataForContinueBooks
                                          .value !=
                                      null
                                  ? EdgeInsets.only(top: 20.px)
                                  : EdgeInsets.zero,
                              children: [
                                if (controller.getDashBoarDataForContinueBooks
                                            .value !=
                                        null &&
                                    controller.getDashBoarDataForContinueBooks
                                            .value?.book !=
                                        null)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: C.margin,
                                    ),
                                    child: SizedBox(
                                      height: 170.px,
                                      child: Card(
                                        color: Col.cardBackgroundColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                C.buttonRadius)),
                                        child: InkWell(
                                          onTap: () =>
                                              controller.clickOnContinueBook(),
                                          borderRadius: BorderRadius.circular(
                                              C.buttonRadius),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.px),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 144.px,
                                                      width: 110.px,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.px),
                                                          child:
                                                              imageViewContinueBook()),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10.px,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          textViewContinueReading(),
                                                          imageViewPlayImage(),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10.px),
                                                      if (controller
                                                              .getDashBoarDataForContinueBooks
                                                              .value
                                                              ?.book
                                                              ?.bookdetails
                                                              ?.title !=
                                                          null)
                                                        textBookNameTextView(),
                                                      SizedBox(height: 10.px),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          if (controller
                                                                  .getDashBoarDataForContinueBooks
                                                                  .value
                                                                  ?.book
                                                                  ?.chapter !=
                                                              null)
                                                            textViewChapter(),
                                                          if (controller
                                                                  .getDashBoarDataForContinueBooks
                                                                  .value
                                                                  ?.book
                                                                  ?.percentage !=
                                                              null)
                                                            textViewPercent(),
                                                        ],
                                                      ),
                                                      SizedBox(height: 12.px),
                                                      if (controller
                                                              .getDashBoarDataForContinueBooks
                                                              .value
                                                              ?.book
                                                              ?.percentage !=
                                                          null)
                                                        progressBarView()
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                Column(
                                  children: [
                                    if (controller.getDashBoarDataForPopularBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForPopularBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForPopularBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listTitleView(
                                        text: C.textMostPopularBooks,
                                        onPressed: () =>
                                            controller.clickOnSeeMore(
                                                id: C.textMostPopularBooks),
                                      ),
                                    if (controller.getDashBoarDataForPopularBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForPopularBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForPopularBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listViewBooks(
                                          listOfBooks: controller
                                                  .getDashBoarDataForPopularBooks
                                                  .value
                                                  ?.books ??
                                              [],
                                          id: C.textMostPopularBooks,
                                          dashBoardModel: controller
                                              .getDashBoarDataForPopularBooks
                                              .value!),
                                    if (controller
                                                .getDashBoarDataForRecommendedBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForRecommendedBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForRecommendedBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listTitleView(
                                          text: C.textRecommendedForYou,
                                          onPressed: () =>
                                              controller.clickOnSeeMore(
                                                  id: C.textRecommendedForYou)),
                                    if (controller
                                                .getDashBoarDataForRecommendedBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForRecommendedBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForRecommendedBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listViewBooks(
                                          listOfBooks: controller
                                                  .getDashBoarDataForRecommendedBooks
                                                  .value
                                                  ?.books ??
                                              [],
                                          id: C.textRecommendedForYou,
                                          dashBoardModel: controller
                                              .getDashBoarDataForRecommendedBooks
                                              .value!),
                                    if (controller
                                                .getDashBoarDataForUserFavoriteBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForUserFavoriteBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForUserFavoriteBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listTitleView(
                                        text: C.textYourFavorite,
                                        onPressed: () =>
                                            controller.clickOnSeeMore(
                                                id: C.textYourFavorite),
                                      ),
                                    if (controller
                                                .getDashBoarDataForUserFavoriteBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForUserFavoriteBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForUserFavoriteBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listViewFavBooks(
                                        listOfBooks: controller
                                                .getDashBoarDataForUserFavoriteBooks
                                                .value
                                                ?.books ??
                                            [],
                                        id: C.textYourFavorite,
                                      ),
                                    if (controller
                                                .getDashBoarDataForNewReleaseBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForNewReleaseBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForNewReleaseBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listTitleView(
                                        text: C.textNewRelease,
                                        onPressed: () =>
                                            controller.clickOnSeeMore(
                                                id: C.textNewRelease),
                                      ),
                                    if (controller
                                                .getDashBoarDataForNewReleaseBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForNewReleaseBooks
                                                .value
                                                ?.books !=
                                            null &&
                                        controller
                                            .getDashBoarDataForNewReleaseBooks
                                            .value!
                                            .books!
                                            .isNotEmpty)
                                      listViewBooks(
                                          listOfBooks: controller
                                                  .getDashBoarDataForNewReleaseBooks
                                                  .value
                                                  ?.books ??
                                              [],
                                          id: C.textNewRelease,
                                          dashBoardModel: controller
                                              .getDashBoarDataForNewReleaseBooks
                                              .value!),
                                    if (controller.getDashBoarDataForMemberBooks
                                                .value !=
                                            null &&
                                        controller.getDashBoarDataForMemberBooks
                                                .value?.books !=
                                            null &&
                                        controller.getDashBoarDataForMemberBooks
                                            .value!.books!.isNotEmpty)
                                      listTitleView(
                                          text: C.textMemberOnlyBooks,
                                          onPressed: () =>
                                              controller.clickOnSeeMore(
                                                  id: C.textMemberOnlyBooks)),
                                    if (controller.getDashBoarDataForMemberBooks
                                                .value !=
                                            null &&
                                        controller.getDashBoarDataForMemberBooks
                                                .value?.books !=
                                            null &&
                                        controller.getDashBoarDataForMemberBooks
                                            .value!.books!.isNotEmpty)
                                      listViewBooks(
                                          listOfBooks: controller
                                                  .getDashBoarDataForMemberBooks
                                                  .value
                                                  ?.books ??
                                              [],
                                          id: C.textMemberOnlyBooks,
                                          dashBoardModel: controller
                                              .getDashBoarDataForMemberBooks
                                              .value!),
                                    if (controller.getDashBoarDataAuthors.value != null &&
                                        controller.getDashBoarDataAuthors.value
                                                ?.authors !=
                                            null &&
                                        controller.getDashBoarDataAuthors.value!
                                            .authors!.isNotEmpty)
                                      listTitleView(
                                          text: C.textFamousAuthors,
                                          onPressed: () =>
                                              controller.clickOnAuthorSeeMore(
                                                  id: C.textFamousAuthors)),
                                    if (controller.getDashBoarDataAuthors.value != null &&
                                        controller.getDashBoarDataAuthors.value
                                                ?.authors !=
                                            null &&
                                        controller.getDashBoarDataAuthors.value!
                                            .authors!.isNotEmpty)
                                      listViewAuthor(),
                                    if (controller.isLoading.value)
                                      Padding(
                                        padding: EdgeInsets.all(50.px),
                                        child: CW.commonProgressBarView(),
                                      ),
                                    SizedBox(
                                      height: C.margin,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
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
      },
    );
  }

  Widget appBarView() {
    return Column(
      children: [
        Container(
          height: CM.getAppBarSize(),
          margin: EdgeInsets.only(top: CM.getToolBarSize()),
          padding: EdgeInsets.symmetric(horizontal: C.margin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (controller.getUserDataModel != null) buttonViewUserProfile(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.getUserDataModel?.user?.name != null)
                        textViewGoodMorning(),
                      if (controller.getUserDataModel?.user?.name != null)
                        textViewItsTimeToRead()
                    ],
                  ),
                ),
              ),
              buttonViewNotification()
            ],
          ),
        ),
        Divider(
          color: Col.borderColor,
          thickness: 2.px,
          height: 0.px,
        ),
      ],
    );
  }

  Widget buttonViewUserProfile() => InkWell(
        onTap: () => controller.clickOnUserProfileButton(),
        borderRadius: BorderRadius.circular(20.px),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.px),
          child: imageViewUserProfile(),
        ),
      );

  Widget imageViewUserProfile() {
    if (controller.getUserDataModel?.user?.userImage != null) {
      return Image.network(
        CM.getImageUrl(
            value: controller.getUserDataModel?.user?.userImage ?? ""),
        height: 40.px,
        width: 40.px,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 40.px, width: 40.px, radius: 20.px);
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

  Widget textViewGoodMorning() => Text(
        "${controller.greeting},${controller.getUserDataModel?.user?.name ?? ""}",
        style: Theme.of(Get.context!)
            .textTheme
            .displaySmall
            ?.copyWith(fontSize: 18.px, fontFamily: C.fontPlayfairDisplay),
        overflow: TextOverflow.ellipsis,
      );

  Widget textViewItsTimeToRead() => Text(
        C.textItsTimeToRead,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
              color: Col.onSecondary,
              fontFamily: C.fontAlegreya,
            ),
      );

  Widget buttonViewNotification() => IconButton(
        onPressed: () => controller.clickOnNotificationButton(),
        icon: imageViewNotification(),
        splashRadius: C.iconButtonRadius,
        padding: EdgeInsets.zero,
      );

  Widget imageViewNotification() => Image.asset(
        C.imageNotificationLogo,
        height: 26.px,
        width: 22.px,
      );

  Widget imageViewContinueBook() => Image.network(
        CM.getImageUrl(
            value: controller.getDashBoarDataForContinueBooks.value?.book
                    ?.bookdetails?.bookThumbnail ??
                ""),
        height: 144.px,
        width: 110.px,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 144.px, width: 110.px, radius: 15.px);
        },
        fit: BoxFit.cover,
      );

  Widget textViewContinueReading() => Text(
        C.textContinueReading,
        style: Theme.of(Get.context!)
            .textTheme
            .displaySmall
            ?.copyWith(fontSize: 18.px, fontFamily: C.fontAlegreya),
      );

  Widget imageViewPlayImage() => Image.asset(
        C.imagePlayLogo,
        height: 15.px,
        width: 13.px,
      );

  Widget textBookNameTextView() => Text(
        controller.getDashBoarDataForContinueBooks.value?.book?.bookdetails
                ?.title ??
            "",
        style: CT.playfairDisplayDisplaySmall(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );

  Widget textViewChapter() => Text(
        "${C.textChapter}: ${controller.getDashBoarDataForContinueBooks.value?.book?.chapter}",
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: C.fontAlegreya, fontSize: 12.px),
      );

  Widget textViewPercent() => Text(
        "${double.parse(
          double.parse(controller.getDashBoarDataForContinueBooks.value?.book!
                      .percentage ??
                  "0.0")
              .toStringAsFixed(2),
        )}%",
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: C.fontAlegreya, fontSize: 12.px),
      );

  Widget progressBarView() => CW.commonLinearProgressBar(
      value: double.parse(controller
                  .getDashBoarDataForContinueBooks.value?.book?.percentage ??
              "0.0") /
          100);

  Widget listTitleView(
          {required String text, required VoidCallback onPressed}) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 15.px, horizontal: C.margin),
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

  Widget listViewBooks(
          {required List<Books> listOfBooks,
          required String id,
          required GetDashBoardBooksModel dashBoardModel}) =>
      Container(
        height: 227.px,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: C.margin),
        child: ListView.builder(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => controller.clickOnParticularBook(
                index: index, id: id, getDashBoardBooksModel: dashBoardModel),
            child: Container(
                height: 227.px,
                width: 130.px,
                margin: EdgeInsets.only(right: C.margin / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 144.px,
                            width: 130.px,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 144.px,
                                  width: 130.px,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.px),
                                    child: imageViewBook(
                                        value:
                                            listOfBooks[index].bookThumbnail),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.px),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (listOfBooks[index].isAudio != null &&
                                          listOfBooks[index].isAudio == "1")
                                        SizedBox(
                                          height: 25.px,
                                          width: 25.px,
                                          child: buttonViewSound(index: index),
                                        ),
                                      if (listOfBooks[index].isAudio != null &&
                                          listOfBooks[index].isAudio == "1")
                                        SizedBox(
                                          width: 5.px,
                                        ),
                                      if (dashBoardModel.favorite != null &&
                                          dashBoardModel.favorite!.contains(
                                              listOfBooks[index].id.toString()))
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
                        SizedBox(
                          height: 5.px,
                        ),
                        if (listOfBooks[index].title != null)
                          textViewBookName(
                              value: listOfBooks[index].title ?? ""),
                        if (listOfBooks[index].title != null)
                          SizedBox(
                            height: 5.px,
                          ),
                        if (listOfBooks[index].authorName != null)
                          textViewAuthorName(
                              value: listOfBooks[index].authorName ?? ""),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (listOfBooks[index].rating != null)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.px),
                                      child: imageViewStar(),
                                    ),
                                  if (listOfBooks[index].rating != null)
                                    textViewRatting(
                                        value: listOfBooks[index].rating ?? "")
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (listOfBooks[index].views != null)
                                    imageViewEye(),
                                  if (listOfBooks[index].views != null)
                                    textViewViewers(
                                        value: listOfBooks[index].views ?? ""),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          itemCount: listOfBooks.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget listViewFavBooks({
    required List<Books> listOfBooks,
    required String id,
  }) =>
      Container(
        height: 227.px,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: C.margin),
        child: ListView.builder(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => controller.clickOnParticularBook(
                index: index,
                id: id,
                getDashBoardBooksModel:
                    controller.getDashBoarDataForUserFavoriteBooks.value!),
            child: Container(
                height: 227.px,
                width: 130.px,
                margin: EdgeInsets.only(right: C.margin / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 144.px,
                            width: 130.px,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.px),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 144.px,
                                  width: 130.px,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25.px),
                                    child: imageViewBook(
                                        value: listOfBooks[index]
                                            .bookdetails
                                            ?.bookThumbnail),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.px),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (listOfBooks[index]
                                                  .bookdetails
                                                  ?.isAudio !=
                                              null &&
                                          listOfBooks[index]
                                                  .bookdetails
                                                  ?.isAudio ==
                                              "1")
                                        SizedBox(
                                          height: 25.px,
                                          width: 25.px,
                                          child: buttonViewSound(index: index),
                                        ),
                                      if (listOfBooks[index]
                                                  .bookdetails
                                                  ?.isAudio !=
                                              null &&
                                          listOfBooks[index]
                                                  .bookdetails
                                                  ?.isAudio ==
                                              "1")
                                        SizedBox(
                                          width: 5.px,
                                        ),
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
                        SizedBox(
                          height: 5.px,
                        ),
                        if (listOfBooks[index].bookdetails?.title != null)
                          textViewBookName(
                              value:
                                  listOfBooks[index].bookdetails?.title ?? ""),
                        if (listOfBooks[index].bookdetails?.title != null)
                          SizedBox(
                            height: 5.px,
                          ),
                        if (listOfBooks[index].bookdetails?.authorName != null)
                          textViewAuthorName(
                              value:
                                  listOfBooks[index].bookdetails?.authorName ??
                                      ""),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.px),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (listOfBooks[index].bookdetails?.rating != null)
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 2.px),
                                      child: imageViewStar(),
                                    ),
                                  if (listOfBooks[index].bookdetails?.rating != null)
                                    textViewRatting(
                                        value: listOfBooks[index].bookdetails?.rating ?? "")
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (listOfBooks[index].bookdetails?.views != null)
                                    imageViewEye(),
                                  if (listOfBooks[index].bookdetails?.views != null)
                                    textViewViewers(
                                        value: listOfBooks[index].bookdetails?.views ?? ""),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
          itemCount: listOfBooks.length,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      );

  Widget imageViewBook({String? value}) {
    if (value != null) {
      return Image.network(
        CM.getImageUrl(value: value),
        fit: BoxFit.fill,
        height: 144.px,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 144.px, width: 130.px, radius: 25.px);
        },
        width: 130.px,
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        fit: BoxFit.fill,
        height: 144.px,
        width: 130.px,
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

  Widget textViewBookName({required String value}) => Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaBodySmall(),
      );

  Widget textViewAuthorName({required String value}) => Text(
        value,
        maxLines: 1,
        style: CT.alegreyaBodySmall(),
        textAlign: TextAlign.center,
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

  Widget listViewAuthor() {
    return Container(
      height: 134.px,
      margin: EdgeInsets.only(left: C.margin),
      child: ListView.builder(
        itemBuilder: (context, index) => Container(
          height: 134.px,
          width: 100.px,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: C.margin / 2),
          child: GestureDetector(
            onTap: () => controller.clickOnParticularAuthor(index: index),
            child: Column(
              children: [
                Container(
                  height: 100.px,
                  width: 100.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.px),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.px),
                      child: controller.getDashBoarDataAuthors.value!
                                  .authors?[index].authorImage !=
                              null
                          ? Image.network(
                              CM.getImageUrl(
                                  value: controller.getDashBoarDataAuthors
                                          .value!.authors?[index].authorImage ??
                                      ""),
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return CW.commonShimmerViewForImage(
                                    height: 100.px,
                                    width: 100.px,
                                    radius: 50.px);
                              },
                            )
                          : Image.asset(
                              C.imageAuthorProfile,
                              height: 100.px,
                              width: 100.px,
                              fit: BoxFit.cover,
                            )),
                ),
                SizedBox(
                  height: 10.px,
                ),
                textViewAuthorName(
                    value: controller.getDashBoarDataAuthors.value!
                            .authors?[index].name ??
                        ""),
              ],
            ),
          ),
        ),
        itemCount: controller.getDashBoarDataAuthors.value?.authors?.length,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }
}
