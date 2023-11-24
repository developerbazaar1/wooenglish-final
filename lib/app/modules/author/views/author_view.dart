import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/modules/author/tab/books_view.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../../../theme/constants/constants.dart';
import '../controllers/author_controller.dart';
import '../tab/reviews_view.dart';

class AuthorView extends GetView<AuthorController> {
  const AuthorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: WillPopScope(
          onWillPop: () => controller.clickOnBackButton(),
          child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  appBarView(),
                  Obx(() {
                    if (AppController.isConnect.value) {
                      if (controller.statusCode.value == 200 ||
                          controller.getAuthorDetailsModel.value != null) {
                          return Expanded(
                            child: Column(
                              children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.px, vertical: 10.px),
                                    margin: EdgeInsets.only(
                                        left: C.margin, right: C.margin, top: C.margin),
                                    decoration: BoxDecoration(
                                      color: Col.inverseSecondary,
                                      borderRadius: BorderRadius.circular(20.px),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10.px),
                                              child: imageViewAuthor(),
                                            ),
                                            SizedBox(
                                              width: 20.px,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (controller.getAuthorDetailsModel.value
                                                      ?.author?.name !=
                                                      null)
                                                    textviewAuthorName(),
                                                  SizedBox(
                                                    height: 7.px,
                                                  ),
                                                  textViewAuthorCountry()
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10.px),
                                          child: MySeparator(
                                            height: 2.px,
                                            color: Col.primary,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                if (controller.getAuthorDetailsModel.value
                                                    ?.noOfAuthorBooks !=
                                                    null)
                                                  Column(
                                                    children: [
                                                      textViewBooksCount(),
                                                      textViewCommon(value: C.textBooks),
                                                    ],
                                                  ),
                                                if (controller.getAuthorDetailsModel.value
                                                    ?.noOfAuthorBooks !=
                                                    null &&
                                                    controller.getAuthorDetailsModel.value
                                                        ?.noOfFollowers !=
                                                        null)
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: 46.px,
                                                        width: 2.px,
                                                        color: Col.primary,
                                                        margin: EdgeInsets.symmetric(
                                                            horizontal: 17.px),
                                                      )
                                                    ],
                                                  ),
                                                if (controller.getAuthorDetailsModel.value
                                                    ?.noOfFollowers !=
                                                    null)
                                                  Column(
                                                    children: [
                                                      textViewFollowerCount(),
                                                      textViewCommon(value: C.textFollowers),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                            Row(
                                              children: [buttonViewFollow()],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: C.margin,
                                        right: C.margin,
                                        top: 7.px,
                                        bottom: 15.px),
                                    child: ColoredBox(
                                      color: Col.inverseSecondary,
                                      child: TabBar(
                                        indicatorColor: Col.primary,
                                        indicatorPadding: EdgeInsets.only(bottom: 5.px),
                                        tabs: controller.tabs,
                                        controller: controller.tabController,
                                        labelStyle: Theme.of(Get.context!)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontFamily: C.fontOpenSans, color: Col.primary),
                                        labelColor: Col.primary,
                                        unselectedLabelStyle: Theme.of(Get.context!)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontFamily: C.fontOpenSans,
                                            color: Col.textGrayColor),
                                        unselectedLabelColor: Col.textGrayColor,
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                        controller: controller.tabController,
                                        children: const [
                                          BooksView(),
                                          ReviewsView(),
                                        ]),
                                  )
                              ],
                            ),
                          );
                      } else {
                        if(controller.statusCode.value==0)
                        {
                          return const SizedBox();
                        }
                        return CW.commonSomethingWentWrongImage(                              onRefresh: () => controller.onRefresh(),
);
                      }
                    } else {
                      return CW.commonNoInternetImage(                              onRefresh: () => controller.onRefresh(),
);
                    }
                  })

                ],
              )),
        ),
      ),
    );
  }

  Widget appBarView() => CW.commonAppBarWithActon(
      title: controller.title,
      clickOnBackButton: () => controller.clickOnBackButton(),
      clickOnInfoButton: () => controller.clickOnInfoButton(),
      clickOnShareButton: () => controller.clickOnShareButton(),
      wantTitle: true,
      wantLikeButton: false);

  Widget imageViewAuthor() {
    if (controller.getAuthorDetailsModel.value?.author?.authorImage != null) {
      return Image.network(
        CM.getImageUrl(
            value:
                controller.getAuthorDetailsModel.value?.author?.authorImage ??
                    ""),
        loadingBuilder:
            (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 100.px,
              width: 100.px,
              radius: 10.px);
        },
        height: 100.px,
        width: 100.px,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageAuthorProfile,
            height: 100.px,
            width: 100.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageAuthorProfile,
        height: 100.px,
        width: 100.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textviewAuthorName() => Text(
        controller.getAuthorDetailsModel.value?.author?.name ?? "",
        maxLines: 2,
        style: CT.alegreyaDisplaySmall(),
        overflow: TextOverflow.ellipsis,
      );

  Widget textViewAuthorCountry() => Text(
        C.textAuthorCountry,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: CT.openSansBodySmall(),
      );

  Widget textViewBooksCount() => Text(
        controller.getAuthorDetailsModel.value?.noOfAuthorBooks.toString() ??
            "",
        style: CT.openSansBodyMedium(),
      );

  Widget textViewCommon({required String value}) => Text(
        value,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.textGrayColor),
      );

  Widget textViewFollowerCount() => Text(
      controller.followersCount.value.toString(),
      style: CT.openSansBodyMedium());

  Widget buttonViewFollow() => CW.commonElevatedButton(
      onPressed: () => controller.clickOnFollowButton(),
      child: textViewFollow(),
      buttonColor: Col.primaryColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 5.px),
      borderRadius: 20.px);

  Widget textViewFollow() => Text(
        controller.isFollow.value ?C.textUnFollow: C.textFollow  ,
        style: CT.openSansBodyMedium(),
      );
}
