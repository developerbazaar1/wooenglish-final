import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/load_more/load_more.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../../../theme/constants/constants.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);

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
                    if (controller.responseCode.value == 200 ||
                        controller.getDataModel.value != null) {
                      if (controller.notificationList.isNotEmpty) {
                        return Expanded(
                          child: ScrollConfiguration(
                            behavior: ListScrollBehaviour(),
                            child: CW.commonRefreshIndicator(
                              onRefresh: () => controller.onRefresh(),
                              child: RefreshLoadMore(
                                isLastPage: controller.isLastPage.value,
                                onLoadMore: () => controller.onLoadMore(),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => Card(
                                    color: Col.inverseSecondary,
                                    margin: EdgeInsets.only(bottom: 15.px),
                                    elevation: 0.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.px),
                                    ),
                                    child: Ink(
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.px),
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(10.px),
                                        onTap: () => controller
                                            .clickOnParticularNotification(
                                                index: index),
                                        child: Padding(
                                          padding: EdgeInsets.all(10.px),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 30.px,
                                                child:
                                                    imageViewNotificationLogo(
                                                        index: index),
                                              ),
                                              SizedBox(
                                                width: 10.px,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        if (controller
                                                                .notificationList[
                                                                    index]
                                                                .notificationName !=
                                                            null)
                                                          Expanded(
                                                              child: textViewTitle(
                                                                  value: controller
                                                                          .notificationList[
                                                                              index]
                                                                          .notificationName ??
                                                                      "")),
                                                        /* Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10.px),
                                                          child: Ink(
                                                            height: 25.px,
                                                            width: 25.px,
                                                            child: InkWell(
                                                              onTap: () => controller
                                                                  .clickOnCrossIcon(
                                                                      index:
                                                                          index),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15.px),
                                                              child:
                                                                  imageViewCrossIcon(
                                                                      index:
                                                                          index),
                                                            ),
                                                          ),
                                                        )*/
                                                      ],
                                                    ),
                                                    if (controller
                                                            .notificationList[
                                                                index]
                                                            .notificationDescription !=
                                                        null)
                                                      textViewDis(
                                                          value: controller
                                                                  .notificationList[
                                                                      index]
                                                                  .notificationDescription ??
                                                              ""),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  itemCount: controller.notificationList.length,
                                  padding: EdgeInsets.only(
                                      left: C.margin,
                                      right: C.margin,
                                      top: C.margin + 4),
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
      },
    );
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      onPressed: () => controller.clickOnBackButton(),
      title: C.textNotification,
      wantClearButton: false,
      clickOnClearButton: () => controller.clickOnClearButton());

  Widget imageViewNotificationLogo({required int index}) => Image.asset(
        C.imageWooEnglishAppLogo,
        height: 60.px,
        width: 60.px,
      );

  Widget textViewTitle({required String value}) => Text(
        value,
        style: CT.openSansBodyMedium(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget imageViewCrossIcon({required int index}) => Image.asset(
        C.imageCrossLogo,
        height: 20.px,
        width: 20.px,
      );

  Widget textViewDis({required String value}) => Text(
        value,
        style: CT.openSansBodySmall(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
}
