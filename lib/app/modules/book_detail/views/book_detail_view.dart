import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/modules/Showpopup/showpopup.dart';
import 'package:woo_english/app/modules/subscription/views/subscription_view.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/book_detail_controller.dart';

// ignore: must_be_immutable
class BookDetailView extends GetView<BookDetailController> {
  String? showbookto;
  String? tag;
  bool? isLiked;
  String? bookId;
  String? bookNameId;
  String? categoryId;
  late BookDetailController controller;

  BookDetailView(
      {super.key,
      Key? k,
        this.showbookto,
      this.tag,
      this.isLiked,
      this.bookId,
        this.bookNameId,
      this.categoryId}) {
    controller = Get.find(tag: tag);
    if (controller.intValue == 1) {
      controller.id = tag ?? "";
      controller.bookId = bookId ?? '';
      controller.like = isLiked ?? false;
      controller.categoryId = categoryId ?? "";
      controller.intValue = 0;
      controller.myOnInit();
    }
  }


  @override
  Widget build(BuildContext context) {
    ShowPopup showPopup = ShowPopup();
    return WillPopScope(
      onWillPop: () => controller.clickOnBackButton(),
      child: GestureDetector(
        onTap: () => CM.unFocsKeyBoard(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Obx(() {
            if (AppController.isConnect.value &&
                controller.responseCode.value == 200 &&
                controller.getBookDetailDataModel.value != null) {
              return Container(
                height: 80.px,
                padding: EdgeInsets.symmetric(horizontal: C.margin),
                decoration: BoxDecoration(
                    color: Col.scaffoldBackgroundColor,
                    border: Border(
                        top: BorderSide(
                            color: Col.cardBackgroundColor, width: 2.px))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.px,
                    ),
                    Row(
                      mainAxisAlignment: controller.isVideo.value
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.center,
                      children: [
                        buttonViewBottomBar(
                            title: C.textRead,
                            onPressed: () {
                              print("this is show book to $showbookto");

                              if(isUserSubscribed==null)
                                if(controller.interstitialAd!=null){
                                  controller.interstitialAd!.show();
                                }


                              if(showbookto=='paid_users'&&isUserSubscribed==null){
                                print(bookNameId);
                                _showDialog(context);
                              }else{
                                controller.clickOnReadAndListenButton();
                              }



                            }


                          //
                        ),
                        buttonViewBottomBar(
                            title: C.textListen,
                            onPressed: () {
                              if(isUserSubscribed==null)
                                if(controller.interstitialAd!=null){
                                  controller.interstitialAd!.show();
                                }


                              if(isUserSubscribed==null&&showbookto=='paid_users'){
                                print(bookNameId);
                                _showDialog(context);
                              }else{
                                controller.clickOnReadAndListenButton();
                              }



                            }

                        ),
                        if (controller.isVideo.value)
                          buttonViewBottomBar(
                              title: C.textVideo,
                              onPressed: (){
                                if(isUserSubscribed==null)
                                  if(controller.interstitialAd!=null){
                                    controller.interstitialAd!.show();
                                  }


                               // if(bookNameId==C.textMemberOnlyBooks&& isUserSubscribed==null||showbookto=='paid_users')
                                if(isUserSubscribed==null&&showbookto=='paid_users')
                                {
                                  print(bookNameId);
                                  _showDialog(context);
                                }else{
                                  controller.clickOnVideoButton();
                                }



                              }

                          ),
                      ],
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          }),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Stack(
            children: [
              Column(
                children: [
                  appBarView(),
                  Obx(() {
                    if (AppController.isConnect.value) {
                      if (controller.responseCode.value == 200 ||
                          controller.getBookDetailDataModel.value != null) {
                        return Expanded(
                            child: ScrollConfiguration(
                              behavior: ListScrollBehaviour(),
                              child: CW.commonRefreshIndicator(
                                onRefresh: () => controller.onRefresh(),
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  controller: ScrollController(),
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: C.margin,
                                              vertical: 17.px),
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(20.px),
                                                child: imageViewBook(),
                                              ),
                                              if (controller.getBookDetailDataModel
                                                  .value?.book?.rating !=
                                                  null)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20.px),
                                                  child: rattingViewBooksRatting(),
                                                ),
                                              if (controller.getBookDetailDataModel
                                                  .value?.book?.title !=
                                                  null)
                                                textViewBookName(),
                                              if (controller.getBookDetailDataModel
                                                  .value?.book?.title !=
                                                  null)
                                                SizedBox(
                                                  height: 7.px,
                                                ),
                                              if (controller.getBookDetailDataModel
                                                  .value?.book?.authorName !=
                                                  null)
                                                textViewAuthorName(),
                                              if (controller.getBookDetailDataModel
                                                  .value?.book?.authorName !=
                                                  null)
                                                SizedBox(
                                                  height: 5.px,
                                                ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 50.px,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.px),
                                          decoration: BoxDecoration(
                                            color: Col.borderColor,
                                            borderRadius:
                                            BorderRadius.circular(5.px),
                                            border: Border.all(
                                              color: Col.cardBackgroundColor,
                                              width: 2.px,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [

                                              if (controller.getBookDetailDataModel
                                                  .value?.chapterCount !=
                                                  null)
                                                commonView(
                                                    image: C.imageThreeLineLogo,
                                                    count: controller
                                                        .getBookDetailDataModel
                                                        .value
                                                        ?.chapterCount
                                                        .toString() ??
                                                        ""),
                                              if (controller.getBookDetailDataModel
                                                  .value?.chapterCount !=
                                                  null)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4.px),
                                                  child: VerticalDivider(
                                                    thickness: 2.px,
                                                    color: Col.primary,
                                                  ),
                                                ),
                                              if (controller.getBookDetailDataModel
                                                  .value?.favoriteCount !=
                                                  null)
                                                commonView(
                                                    image:
                                                    C.imageHartLogoBookDetails,
                                                    count: controller
                                                        .getBookDetailDataModel
                                                        .value
                                                        ?.favoriteCount
                                                        .toString() ??
                                                        ""),
                                              if (controller.getBookDetailDataModel
                                                  .value?.favoriteCount !=
                                                  null)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 4.px),
                                                  child: VerticalDivider(
                                                    thickness: 2.px,
                                                    color: Col.primary,
                                                  ),
                                                ),
                                              if (controller.getBookDetailDataModel
                                                  .value?.book?.totalTime !=
                                                  null)
                                                commonView(
                                                  image: C.imageTimeLogo,
                                                  count:
                                                  "${controller.getBookDetailDataModel.value?.book?.totalTime ?? ""} mins",
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.px,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: C.margin),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        if (controller
                                                            .getBookDetailDataModel
                                                            .value
                                                            ?.book
                                                            ?.totalWords !=
                                                            null)
                                                          commonViewTwo(
                                                              value:
                                                              "${C.textTotalWords}${controller.getBookDetailDataModel.value?.book?.totalWords ?? ""}",
                                                              width: 188.px),
                                                        if (controller
                                                            .getBookDetailDataModel
                                                            .value
                                                            ?.book
                                                            ?.genre !=
                                                            null)
                                                          commonViewTwo(
                                                              value:
                                                              "${C.textGenre}${controller.getBookDetailDataModel.value?.book?.genre ?? ""}",
                                                              width: 188.px),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 14.px,
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        if (controller
                                                            .getBookDetailDataModel
                                                            .value
                                                            ?.book
                                                            ?.level !=
                                                            null)
                                                          commonViewTwo(
                                                              value:
                                                              "${C.textLevelBokDetails}${controller.getBookDetailDataModel.value?.book?.level ?? ""}",
                                                              width: 120.px),
                                                        if (controller
                                                            .getBookDetailDataModel
                                                            .value
                                                            ?.book
                                                            ?.englishAccent !=
                                                            null)
                                                          commonViewTwo(
                                                              value:
                                                              "${C.textAccent}${controller.getBookDetailDataModel.value?.book?.englishAccent ?? ""}",
                                                              width: 120.px)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 12.px,
                                              ),
                                              if (controller
                                                  .getBookDetailDataModel
                                                  .value
                                                  ?.book
                                                  ?.bookDescription !=
                                                  null)
                                                textViewOverView(),

                                              if (controller
                                                  .getBookDetailDataModel
                                                  .value
                                                  ?.book
                                                  ?.bookDescription !=
                                                  null)
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.px),
                                                  child: textViewOverViewDis(),
                                                ),
                                              if(isUserSubscribed==null)
                                                Obx(() {
                                                  return controller.isload.value ==true
                                                      ?bannerAdWidget()
                                                      :Container(
                                                    margin: EdgeInsets.only(top: 10,bottom: 15,left: 20,right: 20),
                                                    child: Image(
                                                      image: AssetImage(
                                                          'assets/images/Admob.jpg'
                                                      ),
                                                    ),
                                                  );
                                                })

                                              ,

                                              // Center(
                                              //   child: Container(
                                              //     margin: EdgeInsets.only(top: 10,bottom: 10),
                                              //     width: controller.bannerAd.value.size.width.toDouble(),
                                              //     height: controller.bannerAd.value.size.height.toDouble(),
                                              //     child: controller.isload.value==true?AdWidget(ad: controller.bannerAd.value):SizedBox(),
                                              //   ),
                                              // ),
                                              /*Obx(() {
                                                if (controller
                                                        .addLoadSuccess.value &&
                                                    controller.bannerAd != null) {
                                                  return Container(
                                                      height: controller
                                                              .addLoadSuccess.value
                                                          ? controller.bannerAd!.size
                                                              .height
                                                              .toDouble()
                                                          : 200.px,
                                                      width: controller.addLoadSuccess
                                                              .value
                                                          ? controller
                                                              .bannerAd!.size.width
                                                              .toDouble()
                                                          : double.infinity,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Col.secondary,
                                                              width: 1.5.px),
                                                          color: Col.surface),
                                                      child: AdWidget(
                                                        ad: controller.bannerAd!,
                                                      ));
                                                } else {
                                                  return const SizedBox();
                                                }
                                              }),*/
                                              if (controller.getBookDetailDataModel
                                                  .value?.reviewCount !=
                                                  null &&
                                                  controller.getBookDetailDataModel
                                                      .value?.reviewCount !=
                                                      0)
                                                listTitleView(
                                                    text:
                                                    "${C.textReviews}(${controller.getBookDetailDataModel.value?.reviewCount ?? ""})",
                                                    onPressed: () => controller
                                                        .clickOnSeeMoreReview())
                                              else
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 6.px)),
                                              Container(
                                                height: 62.px,
                                                decoration: BoxDecoration(
                                                  color: Col.onSurface,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4.px),
                                                    topRight: Radius.circular(4.px),
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
                                                        child: imageViewReviewUser(
                                                            image: controller
                                                                .userProfile),
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
                                                            textViewReviewUser(
                                                                value: controller
                                                                    .userName ??
                                                                    ""),
                                                            rattingViewBuilder(),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                        children: [
                                                          SizedBox(
                                                              height: 25.px,
                                                              child:
                                                              buttonViewSubmit())
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 100.px,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(4.px),
                                                      bottomRight:
                                                      Radius.circular(4.px),
                                                    ),
                                                    color: Col.inverseSecondary),
                                                child: textFieldReview(),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.px,
                                    ),
                                    if (controller.reviewsList.isNotEmpty)
                                      listViewReviewList(),
                                    if (controller.responseCodeSimilarBook.value ==
                                        200 &&
                                        controller
                                            .getSimilarBookModel.value?.books !=
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
                                        controller
                                            .getSimilarBookModel.value?.books !=
                                            null &&
                                        controller.getSimilarBookModel.value!.books!
                                            .isNotEmpty)
                                      listViewBooks()
                                    else if (controller
                                        .responseCodeSimilarBook.value !=
                                        200)
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(50.px),
                                          child: CW.commonProgressBarView(),
                                        ),
                                      ),
                                    SizedBox(
                                      height: 90.px,
                                    )
                                  ],
                                ),
                              ),
                            ));
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
                  })
                ],
              ),

              if(controller.popupValue.value==2&&popupvalue==2)
                FutureBuilder<bool>(
                  future:showPopup.shouldShowPopup() ,
                  builder: (context, snapshot) {
                    if (isUserLogin.isEmpty) {
                      // Show your popup here
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        insetPadding: EdgeInsets.only(top: 105,left: 70,right: 10),
                        alignment: Alignment.topRight,
                        elevation: 3.0,
                        backgroundColor: Colors.red,
                        child: CustomPaint(
                          painter: ArrowDialogPainter(

                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            strokeWidth: 1,
                            dashPattern: [10, 7],
                            color: Col.primary,
                            radius: Radius.circular(5 ),
                            padding: EdgeInsets.all(5),

                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  showPopup.widgetRow(  Image.asset('assets/images/bottombar_favorite_logo.png',height: 20,width: 20,), 'Save the book to your favorite.'),
                                  SizedBox(height: 8,),
                                  showPopup.widgetRow( Icon(Icons.share,size: 20,), 'Share the book with friends and others.'),
                                  SizedBox(height: 8,),
                                  showPopup.widgetRow( Icon(Icons.report_gmailerrorred,size: 20,), ''
                                      'Provide feedback or report issues.'),
                                  Center(
                                    child: TextButton(
                                      style:TextButton.styleFrom(
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
                      return  SizedBox();
                    }
                  },
                ),
              if(controller.popupValue.value==3&&popupvalue==2)
                FutureBuilder<bool>(
                  future:showPopup.shouldShowPopup() ,
                  builder: (context, snapshot) {
                    if (isUserLogin.isEmpty) {
                      // Show your popup here
                      return  Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        insetPadding: EdgeInsets.only(bottom: 105,left: 50,right: 50),
                        alignment: Alignment.bottomCenter,
                        elevation: 3.0,
                        backgroundColor: Colors.red,
                        child: CustomPaint(
                          painter: ArrowDialogPainter(

                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            strokeWidth: 1,
                            dashPattern: [10, 7],
                            color: Col.primary,
                            radius: Radius.circular(5 ),
                            padding: EdgeInsets.all(5),

                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(child: Text('Choose to read, listen, or watch a video of the book.',
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
                      return  SizedBox();
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    )
    ;
  }

  Widget appBarView() => CW.commonAppBarWithActon(
        wantSelectedLikeButton: controller.isLiked.value,
        clickOnBackButton: () => controller.clickOnBackButton(),
        clickOnInfoButton: () => controller.clickOnInfoButton(),
        clickOnLikeButton: () => controller.clickOnLikeAppBarButton(),
        clickOnShareButton: () => controller.clickOnShareButton(),
      );

  Widget imageViewBook() {
    if (controller.getBookDetailDataModel.value?.book?.bookThumbnail != null) {
      return Image.network(
        CM.getImageUrl(
            value:
                controller.getBookDetailDataModel.value?.book?.bookThumbnail ??
                    ""),
        height: 250.px,
        width: 200.px,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 250.px, width: 200.px, radius: 20.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageBookImage,
            height: 250.px,
            width: 200.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        height: 250.px,
        width: 200.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget rattingViewBooksRatting() => CW.commonRattingView(
      rating: double.parse(double.parse(
              controller.getBookDetailDataModel.value?.book?.rating ?? "0.0")
          .toStringAsFixed(2)),
      size: 20.px);

  Widget textViewBookName() => Text(
        controller.getBookDetailDataModel.value?.book?.title ?? '',
        style: CT.alegreyaHeadLineLarge(),
      );

  Widget textViewAuthorName() => Text(
        controller.getBookDetailDataModel.value?.book?.authorName ?? "",
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
              color: Col.secondaryContainer,
              fontFamily: C.fontOpenSans,
            ),
      );

  Widget commonView({
    required String image,
    required String count,
    double? height,
    double? width,
  }) {
    return Row(
      children: [
        Image.asset(image),
        SizedBox(
          width: 5.px,
        ),
        Text(
          count,
          style: CT.openSansTitleLarge(),
        ),
      ],
    );
  }

  Widget commonViewTwo({required String value, double? width}) => Container(
        width: width,
        margin: EdgeInsets.symmetric(vertical: 3.px),
        padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 15.px),
        decoration: BoxDecoration(
          color: Col.borderColor,
          borderRadius: BorderRadius.circular(5.px),
          border: Border.all(
            color: Col.cardBackgroundColor,
            width: 2.px,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          value,
          style: CT.openSansTitleLarge(),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );

  Widget textViewOverView() => Text(
        C.textOverview,
        textAlign: TextAlign.start,
        style: CT.openSansBodyMedium(),
      );

  Widget textViewOverViewDis() {
    return CW.commonReadMoreText(
      value: CM.parseHtmlString(
          controller.getBookDetailDataModel.value?.book?.bookDescription ?? ""),
      maxLine: 7,
    );
  }

  Widget textAddShown() => Text(
        "Here will you admob ad shown",
        style: CT.interBodyLargeMedium(),
      );

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

  Widget imageViewReviewUser({String? image}) {
    if (image != null && image.isNotEmpty) {
      return Image.network(
        CM.getImageUrl(value: image),
        height: 50.px,
        width: 50.px,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 50.px, width: 50.px, radius: 30.px);
        },
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageUserProfile,
            height: 50.px,
            width: 50.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageUserProfile,
        height: 50.px,
        width: 50.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textViewReviewUser({required String value}) => Text(
        value,
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(fontSize: 18.px, fontFamily: C.fontAlegreya),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget rattingViewBuilder() => RatingBar.builder(
        initialRating: double.parse(controller.rating),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 0.2.px),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Col.primary,
        ),
        onRatingUpdate: (rating) => controller.onRattingUpdate(rating: rating),
        itemSize: 16.px,
      );

  Widget buttonViewSubmit() => CW.commonElevatedButton(
      onPressed: () => controller.clickOnSubmitButton(),
      child: textViewSubmit(),
      contentPadding: EdgeInsets.symmetric(horizontal: 7.px),
      borderRadius: 5.px,
      buttonColor: Col.primaryColor);

  Widget textViewSubmit() => Text(
        C.textSubmit,
        style: CT.openSansTitleMedium(),
      );

  Widget textFieldReview() => CW.commonTextFieldForWriteSomething(
      wantBorder: false,
      maxHeight: 100.px,
      borderRadius: 0.px,
      elevation: 0.px,
      hintText: C.textWriteYourReview,
      hintStyle: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
            fontFamily: C.fontOpenSans,
            color: Col.textGrayColor,
          ),
      keyboardType: TextInputType.multiline,
      controller: controller.reviewController);

  Widget listViewReviewList() => ListView.builder(
    controller: ScrollController(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
              bottom: index != controller.reviewsList.length - 1 ? 15.px : 0.px,
              left: C.margin,
              right: C.margin),
          child: Column(
            children: [
              Container(
                height: 60.px,
                decoration: BoxDecoration(
                  color: Col.onSurface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.px),
                    topRight: Radius.circular(4.px),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 15.px, top: 5.px, bottom: 5.px),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.px),
                        child: imageViewReviewUserForList(
                            image: controller
                                .reviewsList[index].userdetails?.userImage),
                      ),
                      SizedBox(
                        width: 5.px,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller
                                    .reviewsList[index].userdetails?.name !=
                                null)
                              textViewReviewUserForList(
                                  value: controller.reviewsList[index]
                                          .userdetails?.name ??
                                      ''),
                            if (controller.reviewsList[index].rating != null)
                              imageViewRatting(
                                  count: double.parse(double.parse(controller
                                              .reviewsList[index].rating ??
                                          "0.0")
                                      .toStringAsFixed(2))),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (controller.reviewsList[index].review != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Col.inverseSecondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(4.px),
                      bottomRight: Radius.circular(4.px),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.px, top: 8.px, bottom: 8.px),
                    child: textViewReadMore(
                        value: controller.reviewsList[index].review ?? ''),
                  ),
                ),
            ],
          ),
        ),
        padding: EdgeInsets.zero,
        itemCount: controller.reviewsList.length,
      );

  Widget imageViewReviewUserForList({String? image}) {
    if (image != null) {
      return Image.network(
        CM.getImageUrl(value: image),
        height: 50.px,
        width: 50.px,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 50.px, width: 50.px, radius: 30.px);
        },
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageUserProfile,
            height: 50.px,
            width: 50.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageUserProfile,
        height: 50.px,
        width: 50.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textViewReviewUserForList({required String value}) => Text(
        value,
        style: CT.openSansBodyMedium(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget imageViewRatting({required double count}) =>
      CW.commonRattingView(rating: count);

  Widget textViewReadMore({required String value}) {
    return CW.commonReadMoreText(
      value: value,
    );
  }

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
  void _showDialog(BuildContext context) {
    showDialog(

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,

          content: Text('Please subscribe to access this feature.'),
          actions: <Widget>[

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL',style: TextStyle(
                color: Colors.grey.shade700
              ),
                  ),
            ),
            TextButton(
              onPressed: () {
                Get.off(SubscriptionView());
              },
              child: Text('SUBSCRIBE'
                  ''),
            ),
          ],
        );
      },
    );
  }
  Widget bannerAdWidget() {
    return
    StatefulBuilder(
      builder: (context, setState) => Center(
        child: Container(
          margin: EdgeInsets.only(top: 10,bottom: 10),
          width: controller.bannerAd!.size.width.toDouble(),
          height: controller.bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: controller.bannerAd!
          ),
          alignment: Alignment.center,
        ),
      ),
    );

  }

  Widget textViewViewers({required String value}) =>
      Text(value, style: CT.openSansTitleSmall());

  Widget buttonViewBottomBar(
          {required String title, required VoidCallback onPressed}) =>
      CW.commonElevatedButton(
        onPressed: onPressed,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.px),
        child: Text(
          title,
          style: CT.openSansDisplayMedium(),
        ),
        height: 47.px,
        buttonColor: Col.primaryColor,
      );

}
class ArrowDialogPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(size.width / 2 - 20, 0.0); // Top left corner
    path.lineTo(size.width / 2 + 20, 0.0); // Top right corner
    path.lineTo(size.width / 2 + 30, 15.0); // Arrow tip
    path.lineTo(size.width / 2, 30.0); // Bottom right corner
    path.lineTo(size.width / 2 - 30, 15.0); // Arrow tip
    path.close();

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)),
        Radius.circular(10.0),
      ),
      paint,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}