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

import '../../../../load_more/load_more.dart';
import '../controllers/all_reviews_controller.dart';

// ignore: must_be_immutable
class AllReviewsView extends GetView<AllReviewsController> {
  @override
  // ignore: overridden_fields
  String? tag;
  String? bookId;
  String? isAudio;
  @override
  late AllReviewsController controller;

  @override
  AllReviewsView({super.key, Key? k, this.tag, this.bookId,this.isAudio}) {
    controller = Get.find(tag: tag);

    if (controller.intValue == 1) {
      controller.id = tag ?? "";
      controller.bookId = bookId ?? "";
      controller.intValue = 0;
      controller.myOnInit();
    }
  }

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
                      if (controller.reviewsList.isNotEmpty) {
                        return Expanded(
                          child: ScrollConfiguration(
                            behavior: ListScrollBehaviour(),
                            child: CW.commonRefreshIndicator(
                              onRefresh: () => controller.onRefresh(),
                              child: RefreshLoadMore(
                                isLastPage: controller.isLastPage.value,
                                onLoadMore: () => controller.onLoadMore(),
                                child: listViewReviewList(),
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
                })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      onPressed: () => controller.clickOnBackButton(), title: C.textReviews);

  Widget listViewReviewList() => ListView.builder(
        itemBuilder: (context, index) => Padding(
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
                              Row(
                                children: [
                                  textViewReviewUserForList(
                                      value: controller.reviewsList[index]
                                              .userdetails?.name ??
                                          ''),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  if (controller.reviewsList[index].userdetails
                                      ?.status ==
                                      "active")
                                    Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Image(
                                          image:
                                          AssetImage(C.imageUserVerified),
                                          width: 15,
                                          height: 15,
                                        ))
                                ],
                              ),
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
        padding: EdgeInsets.only(top: 17.px),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageUserProfile,
            height: 50.px,
            width: 50.px,
            fit: BoxFit.cover,
          );
        },
        fit: BoxFit.cover,
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
}
