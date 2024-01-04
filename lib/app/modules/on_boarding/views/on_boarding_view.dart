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

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: SafeArea(
          child: Obx(() {
            controller.selectedIndex.value;
            if (AppController.isConnect.value) {
              if (controller.responseCode.value == 200) {
                if (controller.pages.isNotEmpty) {
                  return Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(C.imageSplashScreenBackground),
                            fit: BoxFit.cover)),
                    child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Stack(
                          children: [
                            PageView.builder(
                              controller: controller.pageController,
                              itemBuilder: (context, index) =>
                                  ScrollConfiguration(
                                behavior: ListScrollBehaviour(),
                                child: ListView(
                                  children: [
                                    SizedBox(
                                      height: CM.getDeviceSize(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: C.margin),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            imageViewOnBoarding(index: index),
                                            SizedBox(
                                              height: 20.px,
                                            ),
                                            textViewOnBoardingTitle(
                                                index: index),
                                            SizedBox(
                                              height: 11.px,
                                            ),
                                            textViewOnBoardingDescription(
                                                index: index),
                                            SizedBox(
                                              height: 35.px,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              itemCount: controller.imageList.length,
                              onPageChanged: (value) =>
                                  {controller.selectedIndex.value = value},
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30.px,
                                  ),
                                  buttonViewSkip(),
                                ],
                              ),
                            ),
                            Align(
                              child: Column(
                                children: [
                                  const Expanded(child: SizedBox.shrink()),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: C.margin),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            circleDotView(circleIndex: 0),
                                            SizedBox(
                                              width: 4.px,
                                            ),
                                            circleDotView(circleIndex: 1),
                                            SizedBox(
                                              width: 4.px,
                                            ),
                                            circleDotView(circleIndex: 2),
                                          ],
                                        ),
                                        buttonViewNext(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.px,
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Col.scaffoldBackgroundColor,
                    body: Column(
                      children: [
                        CW.commonNoDataFoundImage(
                          onRefresh: () => controller.onRefresh(),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                if (controller.responseCode.value == 0) {
                  return Scaffold(
                    backgroundColor: Col.scaffoldBackgroundColor,
                  );
                }
                return Scaffold(
                  backgroundColor: Col.scaffoldBackgroundColor,
                  body: Column(
                    children: [
                      CW.commonSomethingWentWrongImage(
                          onRefresh: () => controller.onRefresh()),
                    ],
                  ),
                );
              }
            } else {
              return Scaffold(
                backgroundColor: Col.scaffoldBackgroundColor,
                body: Column(
                  children: [
                    CW.commonNoInternetImage(
                        onRefresh: () => controller.onRefresh()),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget imageViewOnBoarding({required int index}) {
    if (controller.pages[index].image != null) {
      return Image.network(
        CM.getImageUrl(value: controller.pages[index].image ?? ""),
        height: 300.px,
        width: 300.px,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            controller.imageList[0],
            height: 300.px,
            width: 300.px,
            fit: BoxFit.cover,
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
            height: 300.px,
            width: 300.px,
          );
        },
      );
    } else {
      return Image.asset(
        controller.imageList[0],
        height: 300.px,
        width: 300.px,
      );
    }
  }

  Widget textViewOnBoardingTitle({required int index}) => Text(
        controller.pages[index].pageName ?? "",
        style: CT.playfairHeadLineSmall(),
    textAlign: TextAlign.center,
      );

  Widget textViewOnBoardingDescription({required int index}) => Text(
        CM.parseHtmlString(controller.pages[index].pageDescription ?? ""),
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(color: Col.darkBlue, fontFamily: C.fontOpenSans),
        textAlign: TextAlign.center,
      );

  Widget circleDotView({required int circleIndex}) => Container(
        height: 10.px,
        width: 10.px,
        decoration: BoxDecoration(
            color: circleIndex == controller.selectedIndex.value
                ? Col.textGrayColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.px),
            border: Border.all(
                color: circleIndex == controller.selectedIndex.value
                    ? Col.textGrayColor
                    : Col.textGrayColor)),
      );

  Widget buttonViewNext() => CW.commonElevatedButton(
      onPressed: () => controller.clickOnNextButton(),
      child: textViewNext(),
      height: 45.px,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.px,
      ),
      buttonMargin: EdgeInsets.zero,
      buttonColor: Col.darkBlue);

  Widget textViewNext() => Text(
        C.textNext,
        style: CT.openSansDisplayLarge(),
      );

  Widget buttonViewSkip() => CW.commonTextButton(
      child: textViewSkip(), onPressed: () => controller.clickOnSkipButton());

  Widget textViewSkip() => Text(
        C.textSkip,
        style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(
            fontFamily: C.fontLato, color: Col.darkBlue, fontSize: 20.px),
      );
}
