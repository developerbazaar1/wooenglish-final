import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../load_more/load_more.dart';
import '../../../../model_progress_bar/model_progress_bar.dart';
import '../../../app_controller/app_controller.dart';
import '../../../common/common_method/common_method.dart';
import '../../../common/common_text_styles/common_text_styles.dart';
import '../../../common/common_widget/common_widget.dart';
import '../../../theme/colors/colors.dart';
import '../../../theme/constants/constants.dart';
import '../controllers/on_going_controller.dart';
class OnGoing extends GetView<OnGoingController>{
  @override
  Widget build(BuildContext context) {
 return Obx(() {
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
                height: C.bookCardInGridHeight,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(10.px),
                margin: EdgeInsets.only(
                    left: index % 2 == 0 ? 16.px : 10.px,
                    right: index % 2 == 0 ? 10.px : 16.px,
                    bottom: 16.px),
                decoration: BoxDecoration(
                    color: Col.inverseSecondary,
                    borderRadius:
                    BorderRadius.circular(C.bookCardInGridRadius)),
                child: Column(
                  children: [
                    Container(
                      height: C.bookImageInGridHeight,
                      width: C.bookImageInGridWidth,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(C.bookImageInGridRadius),
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: C.bookImageInGridHeight,
                            width: C.bookImageInGridWidth,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    C.bookImageInGridRadius),
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
                    CW.commonPaddingForBookContent(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.px,
                          ),
                          if (controller
                              .booksList[index].bookdetails?.title !=
                              null)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: textViewBookName(
                                    value: controller.booksList[index]
                                        .bookdetails?.title ??
                                        "")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (controller.booksList[index].bookdetails
                                  ?.rating !=
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
                                        value: controller.booksList[index]
                                            .bookdetails?.rating ??
                                            "")
                                  ],
                                ),
                              if (controller.booksList[index].bookdetails
                                  ?.rating !=
                                  null)
                                SizedBox(
                                  width: 10.px,
                                ),
                              if (controller.booksList[index].bookdetails
                                  ?.views !=
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
                                        value: controller.booksList[index]
                                            .bookdetails?.views ??
                                            ''),
                                  ],
                                )
                            ],
                          ),
                          if (controller.booksList[index].bookdetails
                              ?.authorName !=
                              null)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: textViewAuthorName(
                                  value: controller.booksList[index]
                                      .bookdetails?.authorName ??
                                      ''),
                            ),
                        ],
                      ),
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
              height: C.bookImageInGridHeight,
              width: C.bookImageInGridWidth,
              radius: C.bookImageInGridRadius);
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

  Widget textViewBookName({required String value}) => Text(
    value,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: CT.alegreyaBodySmall(),
  );


  Widget appBarView() => CW.commonAppBarWithoutActon(
      title: C.textOngoing,
      onPressed: () => controller.clickOnBackButton());

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

  Widget textViewViewers({required String value}) => Text(
    value,
    style: CT.openSansTitleSmall(),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );

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

}
