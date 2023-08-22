import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/load_more/load_more.dart';

import '../controllers/e_book_controller.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

class EBookView extends GetView<EBookController> {
  const EBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                    if (controller.booksList.isNotEmpty) {
                      return Expanded(
                          child: ScrollConfiguration(
                        behavior: ListScrollBehaviour(),
                        child: CW.commonRefreshIndicator(
                          onRefresh: () => controller.onRefresh(),
                          child: RefreshLoadMore(
                            isLastPage: controller.isLastPage.value,
                            onLoadMore: () => controller.onLoadMore(),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(top: 17.px),
                              children: [
                                gridView(),
                              ],
                            ),
                          ),
                        ),
                      ));
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
    });
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      onPressed: () => controller.clickOnBackButton(), title: C.textMyeBooks);

  Widget gridView() => SingleChildScrollView(
        child: Wrap(
          children: List.generate(controller.booksList.length, (index) {
            final cellWidth = MediaQuery.of(Get.context!).size.width /
                2; // Every cell's `width` will be set to 1/2 of the screen width.
            return SizedBox(
              width: cellWidth,
              child: GestureDetector(
                onTap: () => controller.clickOnParticularBook(index: index),
                child: Container(
                    width: cellWidth,
                    height: 248.px,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(10.px),
                    margin: EdgeInsets.only(
                        left: index % 2 == 0 ? 16.px : 10.px,
                        right: index % 2 == 0 ? 10.px : 16.px,
                        bottom: 16.px),
                    decoration: BoxDecoration(
                        color: Col.inverseSecondary,
                        borderRadius: BorderRadius.circular(10.px)),
                    child: Column(
                      children: [
                        Container(
                          height: 144.px,
                          width: 148.px,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.px),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 144.px,
                                width: 148.px,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15.px),
                                    child: imageViewBook(
                                        value: controller.booksList[index]
                                            .bookdetails?.bookThumbnail)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (controller.booksList[index].bookdetails
                                            ?.isAudio ==
                                        "1")
                                      SizedBox(
                                        height: 25.px,
                                        width: 25.px,
                                        child: buttonViewSound(index: index),
                                      ),
                                    if (controller.booksList[index].bookdetails
                                            ?.isAudio ==
                                        "1")
                                      SizedBox(
                                        width: 5.px,
                                      ),
                                    if (controller
                                                .getDataModel.value?.favorite !=
                                            null &&
                                        controller.getDataModel.value!.favorite!
                                            .contains(controller
                                                .booksList[index]
                                                .bookdetails
                                                ?.id
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
                          ),
                        ),
                        SizedBox(
                          height: 5.px,
                        ),
                        if (controller.booksList[index].bookdetails?.title !=
                            null)
                          Align(
                              alignment: Alignment.centerLeft,
                              child: textViewBookName(
                                  value: controller.booksList[index].bookdetails
                                          ?.title ??
                                      "")),
                        if (controller.booksList[index].bookdetails?.title !=
                            null)
                          SizedBox(
                            height: 5.px,
                          ),
                        if (controller
                                .booksList[index].bookdetails?.authorName !=
                            null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: textViewAuthorName(
                                value: controller.booksList[index].bookdetails
                                        ?.authorName ??
                                    ''),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (controller
                                    .booksList[index].bookdetails?.rating !=
                                null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 2.px),
                                    child: imageViewStar(),
                                  ),
                                  textViewRatting(
                                      value: controller.booksList[index]
                                              .bookdetails?.rating ??
                                          "")
                                ],
                              ),
                            if (controller
                                    .booksList[index].bookdetails?.views !=
                                null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  imageViewEye(),
                                  textViewViewers(
                                      value: controller.booksList[index]
                                              .bookdetails?.views ??
                                          ''),
                                ],
                              )
                          ],
                        )
                      ],
                    )),
              ),
            );
          }),
        ),
      );

  Widget imageViewBook({String? value}) {
    if (value != null) {
      return Image.network(
        CM.getImageUrl(value: value),
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 144.px, width: 148.px, radius: 15.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageBookImage,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        fit: BoxFit.cover,
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
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaBodySmall(),
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
