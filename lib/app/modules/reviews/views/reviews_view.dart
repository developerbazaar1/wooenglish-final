import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/load_more/load_more.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';
import 'package:woo_english/slide_menu/slide_menu.dart';

import '../controllers/reviews_controller.dart';

class ReviewsView extends GetView<ReviewsController> {
  const ReviewsView({Key? key}) : super(key: key);

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
                      if (controller.reviewList.isNotEmpty) {
                        return Expanded(
                          child: ScrollConfiguration(
                            behavior: ListScrollBehaviour(),
                            child: CW.commonRefreshIndicator(
                              onRefresh: () => controller.onRefresh(),
                              child: RefreshLoadMore(
                                isLastPage: controller.isLastPage.value,
                                onLoadMore: () => controller.onLoadMore(),
                                child: listView(),
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
      title: C.textMyReview, onPressed: () => controller.clickOnBackButton());

  Widget listView() => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 15.px),
          decoration: BoxDecoration(
              border: Border.all(color: Col.borderColor, width: 3.px),
              borderRadius: BorderRadius.circular(5.px),
              color: Col.inverseSecondary),
          child: SlideMenu(
            menuItems: [
              IconButton(
                  onPressed: () => controller.clickOnDeleteButton(index: index),
                  icon: Icon(
                    Icons.delete,
                    color: Col.error,
                  ))
            ],
            child: InkWell(
              onTap: () => controller.clickOnParticularBook(index: index),
              borderRadius: BorderRadius.circular(5.px),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 8.px, horizontal: 10.px),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5.px),
                        child: imageViewBook(index: index)),
                    SizedBox(
                      width: 17.px,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.reviewList[index].bookdetails?.title !=
                            null)
                          textBookName(
                              value: controller
                                      .reviewList[index].bookdetails?.title ??
                                  ''),
                        if (controller.reviewList[index].bookdetails
                                ?.bookDescription !=
                            null)
                          textBookDis(
                              value: controller.reviewList[index].bookdetails
                                      ?.bookDescription ??
                                  ""),
                        if (controller.reviewList[index].rating != null)
                          rattingView(
                              value: double.parse(double.parse(
                                      controller.reviewList[index].rating ??
                                          "0.0")
                                  .toStringAsFixed(2))),
                      ],
                    )),
                    Padding(
                      padding: EdgeInsets.only(left: 15.px),
                      child: imageViewArrow(index: index),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        itemCount: controller.reviewList.length,
        padding: EdgeInsets.only(left: C.margin, right: C.margin, top: 17.px),
      );

  Widget imageViewBook({required int index}) {
    if (controller.reviewList[index].bookdetails?.bookThumbnail != null) {
      return Image.network(
        CM.getImageUrl(
            value:
                controller.reviewList[index].bookdetails?.bookThumbnail ?? ""),
        height: 83.px,
        width: 60.px,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 83.px, width: 60.px, radius: 5.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageBookImage,
            height: 83.px,
            width: 60.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        height: 83.px,
        width: 60.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textBookName({required String value}) => Text(
        value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget textBookDis({required String value}) => Text(
        CM.parseHtmlString(value),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(fontSize: 12.px, fontFamily: C.fontOpenSans),
      );

  Widget rattingView({required double value}) =>
      CW.commonRattingView(rating: value, size: 20.px);

  Widget imageViewArrow({required int index}) => Image.asset(
        C.imageArrowForwordDark,
        height: 15.px,
        width: 6.px,
      );
}
