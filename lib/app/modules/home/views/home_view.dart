import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';
import '../../splash/controllers/splash_controller.dart';
import '../../subscription/controllers/subscription_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SubscriptionController _controller = Get.put(SubscriptionController());

    return Obx(
      () {
        controller.count.value;
        return ModalProgress(
          inAsyncCall: controller.inAsyncCall.value,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Stack(
              children: [
                Column(
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
                                  padding: EdgeInsets.only(top: 20.px),
                                  children: [
                                    if (isUserSubscribed == null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: C.margin - 9.px,
                                            right: C.margin - 9.px),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.px),
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 20),
                                              padding: EdgeInsets.only(
                                                  right: 15,
                                                  top: 15,
                                                  left: 15,
                                                  bottom: 0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xffDB7E2E),
                                                      Color(0xffDB972D),
                                                    ],
                                                  )),
                                              height: 165.px,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        C.textGetPremium,
                                                        style: TextStyle(
                                                          color: Col
                                                              .inverseSecondary,
                                                          fontSize: 28,
                                                          fontFamily:
                                                              'BeausiteClassic',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 0.8,
                                                        ),
                                                      ),
                                                      Text(
                                                          'Download and listen',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Col
                                                                  .inverseSecondary,
                                                              height: 1.5,
                                                              letterSpacing:
                                                                  0.8)),
                                                      Text(
                                                        'your book',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Col
                                                                .inverseSecondary,
                                                            height: 1.5,
                                                            letterSpacing: 0.8),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 14),
                                                        height: 35,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xffDB7E2E),
                                                            border: Border.all(
                                                                color: Col
                                                                    .inverseSecondary,
                                                                width: 1.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 10,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              shadowColor: Colors
                                                                  .transparent,
                                                            ),
                                                            onPressed: () {
                                                              controller
                                                                  .clickOnSubscription();
                                                            },
                                                            child: Text(
                                                              "Subscribe Now",
                                                              style: TextStyle(
                                                                color: Col
                                                                    .inverseSecondary,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    0.5,
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                  Image(
                                                      image: AssetImage(
                                                          'assets/images/Girl.png'))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (isUserSubscribed == null)
                                      Obx(() {
                                        return controller.isload.value == true
                                            ? bannerAdWidget()
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 20,
                                                    left: 20,
                                                    right: 20),
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/Admob.jpg'),
                                                ),
                                              );
                                      }),
                                    if (controller
                                                .getDashBoarDataForContinueBooks
                                                .value !=
                                            null &&
                                        controller
                                                .getDashBoarDataForContinueBooks
                                                .value
                                                ?.book !=
                                            null)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: C.margin),
                                        child: SizedBox(
                                          height: 128.px,
                                          child: Card(
                                            margin: EdgeInsets.zero,
                                            color: Col.cardBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        C.buttonRadius / 2)),
                                            child: InkWell(
                                              onTap: () => controller
                                                  .clickOnContinueBook(),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      C.buttonRadius / 2),
                                              child: Padding(
                                                padding: EdgeInsets.all(6.px),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 110.px,
                                                          width: 100.px,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.px),
                                                            child:
                                                                imageViewContinueBook(),
                                                          ),
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
                                                          SizedBox(
                                                              height: 5.px),
                                                          if (controller
                                                                  .getDashBoarDataForContinueBooks
                                                                  .value
                                                                  ?.book
                                                                  ?.bookdetails
                                                                  ?.title !=
                                                              null)
                                                            textBookNameTextView(),
                                                          SizedBox(
                                                              height: 5.px),
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
                                                          SizedBox(
                                                              height: 8.px),
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
                                        if (controller
                                                    .getDashBoarDataForPopularBooks
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
                                        if (controller
                                                    .getDashBoarDataForPopularBooks
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
                                                      id: C
                                                          .textRecommendedForYou)),
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
                                        if (isUserSubscribed == true)
                                          Column(
                                            children: [
                                              if (controller
                                                          .getDashBoarDataForMemberBooks
                                                          .value !=
                                                      null &&
                                                  controller
                                                          .getDashBoarDataForMemberBooks
                                                          .value
                                                          ?.books !=
                                                      null &&
                                                  controller
                                                      .getDashBoarDataForMemberBooks
                                                      .value!
                                                      .books!
                                                      .isNotEmpty)
                                                listTitleView(
                                                    text: C.textMemberOnlyBooks,
                                                    onPressed: () => controller
                                                        .clickOnSeeMore(
                                                            id: C
                                                                .textMemberOnlyBooks)),
                                              if (controller
                                                          .getDashBoarDataForMemberBooks
                                                          .value !=
                                                      null &&
                                                  controller
                                                          .getDashBoarDataForMemberBooks
                                                          .value
                                                          ?.books !=
                                                      null &&
                                                  controller
                                                      .getDashBoarDataForMemberBooks
                                                      .value!
                                                      .books!
                                                      .isNotEmpty)
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
                                            ],
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
                                        if (controller.getDashBoarDataAuthors
                                                    .value !=
                                                null &&
                                            controller.getDashBoarDataAuthors
                                                    .value?.authors !=
                                                null &&
                                            controller.getDashBoarDataAuthors
                                                .value!.authors!.isNotEmpty)
                                          listTitleView(
                                              text: C.textFamousAuthors,
                                              onPressed: () => controller
                                                  .clickOnAuthorSeeMore(
                                                      id: C.textFamousAuthors)),
                                        if (controller.getDashBoarDataAuthors
                                                    .value !=
                                                null &&
                                            controller.getDashBoarDataAuthors
                                                    .value?.authors !=
                                                null &&
                                            controller.getDashBoarDataAuthors
                                                .value!.authors!.isNotEmpty)
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
                 if(controller.firstPopUp.value == 0)

                FutureBuilder<bool>(
                  future: controller.shouldShowPopup(),
                  builder: (context, snapshot) {
                    if (isUserLogin.isEmpty) {
                      // Show your popup here
                      return AlertDialog(

                        alignment: Alignment.bottomRight,
                        shape: RoundedRectangleBorder(),
                        contentPadding: EdgeInsets.zero,
                        elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        content: Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(top: 10,left: 5,right: 0),
                          height: 125,
                          width: 100,
                          child: Column(
                            children: [
                              widgetRow( Icon(Icons.search,size: 20,weight: 2), 'Tap to go to the search page.'),
                              SizedBox(height: 8,),
                              widgetRow( Icon(Icons.heart_broken_outlined,size: 20,), 'Access your personal book collection'),
                              SizedBox(height: 8,),
                              widgetRow( Icon(Icons.person_outline_outlined,size: 20,), ''
                                  'Manage your profile settings.'),
                              Center(
                                child: TextButton(
                                  style:TextButton.styleFrom(
                                    padding: EdgeInsets.zero,

                                  ),

                                  onPressed: () {
                                    controller.firstPopUp.value++;
                                  },
                                  child: Text('Got It'),
                                ),
                              ),
                            ],
                          ),
                        ),

                      );
                    } else {
                      // Loading indicator or placeholder
                      return SizedBox();
                    }
                  },
                ),
                if(controller.firstPopUp.value == 1)

                FutureBuilder<bool>(
                  future: controller.shouldShowPopup(),
                  builder: (context, snapshot) {
                    if (isUserLogin.isEmpty) {
                      // Show your popup here
                      return Container(
                        margin: EdgeInsets.only(bottom: 100),
                        child: AlertDialog(


                          alignment: Alignment.bottomLeft,
                          shape: RoundedRectangleBorder(),
                          contentPadding: EdgeInsets.zero,
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          content: Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 10,left: 5,right: 0),
                            padding: EdgeInsets.only(top: 10),
                            height: 90.px,
                            width: 80.px,
                            child: Column(
                              children: [

                               Flexible(child: Text('Tap on a book to open its page.',
                                   style: TextStyle(
                                     color: Colors.black,
                                     fontFamily: "Open Sans",
                                     fontSize: 14,

                                     fontWeight:FontWeight.w400,


                                   ))),
                                Center(
                                  child: TextButton(
                                    style:TextButton.styleFrom(
                                      padding: EdgeInsets.zero,

                                    ),

                                    onPressed: () {
                                      controller.firstPopUp.value++;
                                    },
                                    child: Text('Got It'),
                                  ),
                                ),
                              ],
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
          ),
        );
      },
    );
  }

  Row widgetRow(Icon icon, String text) {
    return Row(
                              children: [
                               icon,
                                SizedBox(width: 10,),
                                Flexible(
                                  child: Text(
                                   text,
                                    style: TextStyle(
                                        color: Colors.black,
                                    fontFamily: "Open Sans",
                                    fontSize: 14,

                                    fontWeight:FontWeight.w400,


                                    ),
                                  ),
                                )
                              ],
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
              if (controller.getUserDataModel != null)
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      buttonViewUserProfile(),
                      if (isUserSubscribed == true)
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(left: 30, top: 12),
                            child: Image.asset(
                              C.imageUserVerified,
                              height: 15.px,
                              width: 15.px,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
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
        "${controller.greeting},  ${controller.SlplitScreen.value[0] ?? ""}",
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

  Widget imageViewNotification() =>
      Icon(Icons.notifications_none, weight: 22.px);

  // Image.asset(
  //   C.imageNotificationLogo,
  //   height: 26.px,
  //   width: 22.px,
  // );

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
        height: 70.px,
        width: 70.px,
      );

  Widget imageViewContinueBook() => Image.network(
        CM.getImageUrl(
            value: controller.getDashBoarDataForContinueBooks.value?.book
                    ?.bookdetails?.bookThumbnail ??
                ""),
        height: 110.px,
        width: 100.px,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 110.px, width: 100.px, radius: 15.px);
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
        style: CT.alegreyaDisplayLarge(),
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
        height: C.bookHorizontalListCardHeight,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: C.margin),
        child: ListView.builder(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => controller.clickOnParticularBook(
                index: index, id: id, getDashBoardBooksModel: dashBoardModel),
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
                              borderRadius: BorderRadius.circular(
                                  C.bookHorizontalListRadius),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: C.bookHorizontalListHeight,
                                  width: C.bookHorizontalListWidth,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        C.bookHorizontalListRadius),
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
                        CW.commonPaddingForBookContent(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.px,
                              ),
                              if (listOfBooks[index].title != null)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: textViewBookName(
                                        value: listOfBooks[index].title ?? "")),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (listOfBooks[index].rating != null)
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
                                            value:
                                                listOfBooks[index].rating ?? "")
                                      ],
                                    ),
                                  if (listOfBooks[index].rating != null)
                                    SizedBox(
                                      width: 10.px,
                                    ),
                                  if (listOfBooks[index].views != null)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 4.px),
                                            child: imageViewEye()),
                                        textViewViewers(
                                            value:
                                                listOfBooks[index].views ?? ''),
                                      ],
                                    )
                                ],
                              ),
                              if (listOfBooks[index].authorName != null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textViewAuthorName(
                                      value:
                                          listOfBooks[index].authorName ?? ''),
                                ),
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

  Widget listViewFavBooks({
    required List<Books> listOfBooks,
    required String id,
  }) =>
      Container(
        height: C.bookHorizontalListCardHeight,
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
                              borderRadius: BorderRadius.circular(
                                  C.bookHorizontalListRadius),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: C.bookHorizontalListHeight,
                                  width: C.bookHorizontalListWidth,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        C.bookHorizontalListRadius),
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
                        CW.commonPaddingForBookContent(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5.px,
                              ),
                              if (listOfBooks[index].bookdetails?.title != null)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: textViewBookName(
                                        value: listOfBooks[index]
                                                .bookdetails
                                                ?.title ??
                                            "")),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (listOfBooks[index].bookdetails?.rating !=
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
                                            value: listOfBooks[index]
                                                    .bookdetails
                                                    ?.rating ??
                                                "")
                                      ],
                                    ),
                                  if (listOfBooks[index].bookdetails?.rating !=
                                      null)
                                    SizedBox(
                                      width: 10.px,
                                    ),
                                  if (listOfBooks[index].bookdetails?.views !=
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
                                            value: listOfBooks[index]
                                                    .bookdetails
                                                    ?.views ??
                                                ''),
                                      ],
                                    )
                                ],
                              ),
                              if (listOfBooks[index].bookdetails?.authorName !=
                                  null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textViewAuthorName(
                                      value: listOfBooks[index]
                                              .bookdetails
                                              ?.authorName ??
                                          ''),
                                ),
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
        height: C.bookHorizontalListHeight,
        width: C.bookHorizontalListWidth,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: C.bookHorizontalListHeight,
              width: C.bookHorizontalListWidth,
              radius: C.bookHorizontalListRadius);
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        fit: BoxFit.fill,
        height: C.bookHorizontalListHeight,
        width: C.bookHorizontalListWidth,
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
        style: CT.alegreyaBodyLarge(),
        textAlign: TextAlign.start,
      );

  Widget textViewAuthorName({required String value}) => Text(
        "By " + value,
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

  Widget bannerAdWidget() {
    return StatefulBuilder(
      builder: (context, setState) => Center(
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: controller.bannerAdd!.size.width.toDouble(),
          height: controller.bannerAdd!.size.height.toDouble(),
          child: AdWidget(ad: controller.bannerAdd!),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
