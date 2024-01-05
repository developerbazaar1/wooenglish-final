// @dart=2.12
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/search_screen_controller.dart';

class SearchScreenView extends GetView<SearchScreenController> {
  const SearchScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(children: [
              appBarView(),
              Obx(() {
                if (AppController.isConnect.value) {
                  if (controller.responseCode.value == 200 ||
                      controller.getDataNewReleaseBook.value != null ||
                      controller.responseCodeForCategory.value == 200 ||
                      controller.getDataForCategory.value != null) {
                    if (controller.bookList.isNotEmpty ||
                        controller.categoryList.isNotEmpty) {
                      return ScrollConfiguration(
                        behavior: ListScrollBehaviour(),
                        child: Expanded(
                          child: CW.commonRefreshIndicator(
                            onRefresh: () => controller.onRefresh(),
                            child: ListView(
                              padding:
                                  EdgeInsets.symmetric(horizontal: C.margin),
                              children: [
                                SizedBox(
                                  height: 10.px,
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () => controller.clickOnSearch(),
                                    borderRadius: BorderRadius.circular(10.px),
                                    child: Container(
                                      height: 50.px,
                                      decoration: BoxDecoration(
                                        color: Col.cardBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.px),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: C.margin - 4.px),
                                            child: imageViewSearch(),
                                          ),
                                          textViewSearch(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 37.px,
                                ),
                                if (controller.bookList.isNotEmpty)
                                  textViewBooksForYou(),
                                if (controller.bookList.isNotEmpty)
                                  SizedBox(
                                    height: 15.px,
                                  ),
                                if (controller.bookList.isNotEmpty)
                                  SizedBox(
                                    height: 117.px,
                                    child: listViewBooks(),
                                  ),
                                if (controller.bookList.isNotEmpty)
                                  SizedBox(
                                    height: 40.px,
                                  ),
                                if (controller.categoryList.isNotEmpty)
                                  textViewBrowsAll(),
                                if (controller.categoryList.isNotEmpty)
                                  listViewBrowsAll()
                              ],
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
                    if (controller.responseCode.value == 0 &&
                        controller.responseCodeForCategory.value == 0) {
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


            ])),
      );
    });
  }

  Widget appBarView() =>
      CW.commonAppBarWithoutActon(title: C.textSearch, wantBackButton: false);

  Widget imageViewSearch() => Image.asset(
        C.imageSearchPageLogo,
        height: 30.px,
        width: 30.px,
      );

  Widget textViewSearch() => Text(
        C.textSearch,
        style: CT.alegreyaBodySmall(),
      );

  Widget textViewBooksForYou() => Text(
        C.textTopBooks,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget listViewBooks() => ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => controller.clickOnParticularBook(index: index),
          child: Container(
            height: 117.px,
            width: 90.px,
            margin: EdgeInsets.only(right: C.margin),
            child: Column(
              children: [
                Container(
                  height: 94.px,
                  width: 90.px,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.px),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.px),
                    child: imageViewBookImage(index: index),
                  ),
                ),
                if (controller.bookList[index].title != null)
                  SizedBox(
                    height: 5.px,
                  ),
                if (controller.bookList[index].title != null)
                  textViewBookName(index: index)
              ],
            ),
          ),
        ),
        itemCount: controller.bookList.length,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      );

  Widget imageViewBookImage({required int index}) {
    if (controller.bookList[index].bookThumbnail != null) {
      return Image.network(
        CM.getImageUrl(value: controller.bookList[index].bookThumbnail ?? ""),
        fit: BoxFit.cover,
        height: 94.px,
        width: 90.px,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 94.px, width: 90.px, radius: 15.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageBookImage,
            fit: BoxFit.cover,
            height: 94.px,
            width: 90.px,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        fit: BoxFit.cover,
        height: 94.px,
        width: 90.px,
      );
    }
  }

  Widget textViewBookName({required int index}) => Text(
        controller.bookList[index].title ?? '',
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
              fontFamily: C.fontAlegreya,
              fontSize: 12.px,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  Widget textViewBrowsAll() => Text(
        C.textBrowserAll,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget listViewBrowsAll() => Wrap(
        children: List.generate(
            controller.categoryList.length,
            (index) => controller.categoryList[index].name != null &&
                    controller.categoryList[index].name!.isNotEmpty
                ? CW.commonElevatedButton(
                    onPressed: () =>
                        controller.clickOnParticularBrowsText(index: index),
                    child: textViewBrowsTitle(index: index),
                    buttonColor: Col.lightBlue,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.px,
                      vertical: 3.px,
                    ),
                    borderRadius: 10.px,
                    buttonMargin: EdgeInsets.only(
                      right: 20.px,
                    ))
                : const SizedBox()),
      );

  Widget textViewBrowsTitle({required int index}) => Text(
        "#${controller.categoryList[index].name ?? ""}",
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: C.fontAlegreya, fontSize: 12.px),
      );
}
