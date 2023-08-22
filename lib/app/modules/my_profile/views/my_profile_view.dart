import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/my_profile_controller.dart';

class MyProfileView extends GetView<MyProfileController> {
  const MyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .scaffoldBackgroundColor,
          body: Column(
            children: [
              appBarView(),
              Obx(() {
                if (AppController.isConnect.value) {
                  return Expanded(
                      child: ScrollConfiguration(
                        behavior: ListScrollBehaviour(),
                        child: CW.commonRefreshIndicator(
                          onRefresh: () => controller.onRefresh(),
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            children: [
                              SizedBox(
                                height: 35.px,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: C.margin),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            50.px),
                                        child: imageViewUserProfile()),
                                    SizedBox(
                                      width: 20.px,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          textViewUserName(),
                                          buttonViewEditProfile()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 29.px,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: C.margin),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        textViewCount(
                                            value:
                                            controller.userOnGoingCount ?? ""),
                                        SizedBox(
                                          height: 2.px,
                                        ),
                                        textViewCommon(value: C.textOnGoing)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        textViewCount(
                                            value: controller
                                                .userOnCompleteCount ??
                                                ""),
                                        SizedBox(
                                          height: 2.px,
                                        ),
                                        textViewCommon(value: C.textCompleted)
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        textViewCount(
                                            value: controller
                                                .userOnMyCollectionCount ??
                                                ""),
                                        SizedBox(
                                          height: 2.px,
                                        ),
                                        textViewCommon(
                                            value: C.textMyCollection)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.px,
                              ),
                              Divider(
                                height: 0.px,
                                color: Col.borderColor,
                                thickness: 2.px,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 25.px,
                                    bottom: 10.px,
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
                              listView(),
                              buttonViewLogout(),


                              /*Container(
                                padding: EdgeInsets.symmetric(vertical: 10.px),
                                margin: EdgeInsets.symmetric(
                                    horizontal: C.margin),
                                decoration: BoxDecoration(
                                    color: Col.borderColor,
                                    border: Border.all(
                                        color: Col.secondary, width:
                                    1.px),
                                    borderRadius: BorderRadius.circular(10.px)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: C.margin),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          textViewCommonForSlider("80"),
                                          textViewCommonForSlider("85"),
                                          textViewCommonForSlider(" 90"),
                                          textViewCommonForSlider("100"),
                                          textViewCommonForSlider("105"),
                                          textViewCommonForSlider("110"),
                                          textViewCommonForSlider("115"),
                                          textViewCommonForSlider("120"),
                                        ],
                                      ),
                                    ),
                                    Obx(
                                          () =>
                                          Padding(
                                            padding:
                                            EdgeInsets.symmetric(
                                                vertical: 3.px),
                                            child: SizedBox(
                                              height: 20.px,
                                              child: Slider(
                                                value: controller.value.value,
                                                min: 0,
                                                max: 8.0,
                                                divisions: 7,
                                                label: getProgress(
                                                    controller.value.value
                                                        .toInt()),
                                                onChanged: (double value) {
                                                  controller.value.value =
                                                      value;
                                                },
                                              ),
                                            ),
                                          ),
                                    ),
                                    Text(
                                      "Click on Bar to Choose Listening Speed : Speed = ${getProgress(
                                          controller.value.value.toInt())}",
                                      style:CT.openSansTitleSmall(),
                                    textAlign: TextAlign.center,)
                                  ],
                                ),
                              )*/
                            ],
                          ),
                        ),
                      ));
                } else {
                  return CW.commonNoInternetImage(
                    onRefresh: () => controller.onRefresh(),
                  );
                }
              })
            ],
          ),
        ),
      );
    });
  }

  Widget textViewCommonForSlider(String value) {
    return Text(
      value,
      style: Theme
          .of(Get.context!)
          .textTheme
          .titleSmall
          ?.copyWith(fontFamily: C.fontOpenSans, fontSize: 12.px),
    );
  }

  String getProgress(int value) {
    if (value == 0) {
      return "0.8";
    } else if (value == 1) {
      return "0.85";
    } else if (value == 2) {
      return "0.9";
    } else if (value == 3) {
      return "1.0";
    } else if (value == 4) {
      return "1.05";
    } else if (value == 5) {
      return "1.1";
    } else if (value == 6) {
      return "1.15";
    } else if (value == 8) {
      return "1.2";
    } else {
      return "";
    }
  }

  Widget appBarView() =>
      CW.commonAppBarWithoutActon(
          title: C.textMyProfile, wantBackButton: false);

  Widget imageViewUserProfile() {
    if (controller.userProfilePicture != null &&
        controller.userProfilePicture != "null" &&
        controller.userProfilePicture!.isNotEmpty) {
      return Image.network(
        CM.getImageUrl(value: controller.userProfilePicture ?? ""),
        height: 86.px,
        width: 80.px,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 86.px, width: 80.px, radius: 50.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageUserProfile,
            height: 86.px,
            width: 80.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageUserProfile,
        height: 86.px,
        width: 80.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textViewUserName() =>
      Text(
        controller.userName ?? "",
        overflow: TextOverflow.ellipsis,
        style: Theme
            .of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(fontFamily: C.fontAlegreya, fontSize: 32.px),
      );

  Widget buttonViewEditProfile() =>
      CW.commonElevatedButton(
          onPressed: () => controller.clickOnEditProfileButton(),
          child: textViewEditProfile(),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 53.px, vertical: 5.px),
          buttonColor: Col.primaryColor);

  Widget textViewEditProfile() =>
      Text(
        C.textEditProfile,
        style: CT.openSansBodyMedium(),
      );

  Widget textViewCount({required String value}) =>
      Text(
        value,
        style: CT.openSansBodyMedium(),
      );

  Widget textViewCommon({required String value}) =>
      Text(value,
          style: Theme
              .of(Get.context!)
              .textTheme
              .bodyMedium
              ?.copyWith(
            fontFamily: C.fontOpenSans,
            color: Col.textGrayColor,
          ));

  Widget textViewGetPremium() =>
      Text(
        C.textGetPremium,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget textViewDownload() =>
      Text(
        C.textDownloadNowAnd,
        style: CT.openSansBodySmall(),
      );

  Widget imageViewPremium() =>
      Image.asset(
        C.imageGetPremium,
        height: 100.px,
        width: 100.px,
      );

  Widget listView() =>
      ListView.builder(
        itemBuilder: (context, index) =>
            Container(
              height: 60.px,
              margin: EdgeInsets.symmetric(vertical: 10.px),
              decoration: BoxDecoration(
                color: Col.inverseSecondary,
                border: Border.all(color: Col.borderColor, width: 3.px),
                borderRadius: BorderRadius.circular(5.px),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.px),
                onTap: () => controller.clickOnParticularItem(index: index),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: C.margin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textViewTitle(index: index),
                      imageViewArrow(),
                    ],
                  ),
                ),
              ),
            ),
        itemCount: controller.listOfTitles.length,
        padding: EdgeInsets.symmetric(horizontal: C.margin),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      );

  Widget textViewTitle({required int index}) =>
      Text(
        controller.listOfTitles[index],
        style: CT.alegreyaDisplaySmall(),
      );

  Widget imageViewArrow() =>
      Image.asset(
        C.imageArrowForwordLogo,
        width: 6.px,
        height: 15.px,
      );

  Widget buttonViewLogout() =>
      CW.commonElevatedButton(
          onPressed: () => controller.clickOnLogOutButton(),
          child: textViewLogOut(),
          wantContentSizeButton: false,
          buttonMargin: EdgeInsets.only(
              left: C.margin,
              right: C.margin,
              top: 10.px,
              bottom: C.margin + C.margin),
          borderRadius: 5.px,
          buttonColor: Col.primaryColor);

  Widget textViewLogOut() =>
      Text(
        C.textLogout,
        style: CT.alegreyaDisplaySmall(),
      );
}
