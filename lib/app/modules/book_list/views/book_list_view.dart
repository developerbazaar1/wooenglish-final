import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/commmon_dropdown_menu.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/load_more/load_more.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/book_list_controller.dart';

// ignore: must_be_immutable
class BookListView extends GetView<BookListController> {
  @override
  // ignore: overridden_fields
  String? tag;
  String? title;
  String? categoryId;
  @override
  late BookListController controller;

  BookListView({super.key, Key? k, this.tag, this.title, this.categoryId}) {
    controller = Get.find(tag: tag);
    if (controller.intValue == 1) {
      controller.id = tag ?? "";
      controller.title = title ?? "";
      controller.categoryId = categoryId ?? "";
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

                if (controller.listOfFilter.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.px),
                    child: listViewBookFilter(),
                  ),
                Obx(() {
                  if (AppController.isConnect.value) {
                    if (controller.statusCode.value == 200 ||
                        controller.getBooksModel.value != null) {
                      if (controller.listOfBooks.isNotEmpty) {
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ScrollConfiguration(
                                    behavior: ListScrollBehaviour(),
                                    child: CW.commonRefreshIndicator(
                                        child: RefreshLoadMore(
                                          isLastPage:
                                              controller.isLastPage.value,
                                          onLoadMore: () =>
                                              controller.onLoadMore(),
                                          child: ListView(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding:
                                                EdgeInsets.only(top: 17.px),
                                            children: [
                                              gridView(),
                                            ],
                                          ),
                                        ),
                                        onRefresh: () =>
                                            controller.onRefresh())),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return CW.commonNoDataFoundImage(
                          onRefresh: () => controller.onRefresh(),
                        );
                      }
                    } else {
                      if (controller.statusCode.value == 0) {
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
      onPressed: () => controller.clickOnBackButton(), title: controller.title);

  Widget listViewBookFilter() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 74.px,
              child: ScrollConfiguration(
                behavior: ListScrollBehaviour(),
                child: ListView.builder(
                    itemBuilder: (context, index) => index ==
                            controller.listOfFilter.length
                        ? Column(
                            children: [

                              SizedBox(
                                height: 35.px,
                              ),
                              commonButtonView(
                                  image: controller.isAudio.value
                                      ? C.imageFilterAudioLogo
                                      : C.imageFilterMuteLogo,
                                  onTap: () =>
                                      controller.clickOnSelectAudioFilter()),
                            ],
                          )
                        : Column(
                            children: [

                              Text(
                                controller.listOfFilterTitle[index],
                                style: CT.alegreyaBodyLarge(),
                              ),
                              SizedBox(
                                height: 2.px,
                              ),
                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    height: 32.px,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.px),
                                    margin: EdgeInsets.only(right: 5.px,left: 8.px),
                                    decoration: BoxDecoration(
                                        color: Col.cardBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10.px)),
                                    child: Row(
                                      children: [
                                        textViewFilterTitle(index: index),
                                        SizedBox(
                                          width: 5..px,
                                        ),
                                        iconViewDownIcon(index: index),
                                      ],
                                    ),
                                  ),
                                  buttonViewDropDown(index: index),
                                ],
                              ),
                            ],
                          ),
                    itemCount: controller.listOfFilter.length + 1,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal),
              ),
            ),
          )
        ],
      );

  Widget commonButtonView(
          {required String image, required VoidCallback onTap}) =>
      Padding(
        padding: EdgeInsets.only(right: C.margin / 2),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.px),
          child: Padding(
              padding: EdgeInsets.all(5.px),
              child: Image.asset(
                image,
                height: 20.px,
                width: 20.px,
              )),
        ),
      );

  Widget textViewFilterTitle({required int index}) => Text(
        controller.selectedFilter[index].isEmpty
            ? controller.listOfFilter[index].title ?? ""
            : controller.selectedFilter[index],
        style: CT.alegreyaBodySmall(),
      );

  Widget iconViewDownIcon({required int index}) => Icon(
        Icons.keyboard_arrow_down_outlined,
        color: Col.secondary,
      );

  Widget buttonViewDropDown({required int index}) => PopupMenuButton<Filters>(
        icon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        offset: Offset(0.px, 12.px),
        splashRadius: 20.px,
        tooltip: '',
        position: PopupMenuPosition.under,
        onSelected: (Filters value) async {
          controller.inAsyncCall.value = true;
          if (controller.selectedFilterId[index]
              .contains(value.id.toString() ?? "")) {
            controller.selectedFilterId[index] = "";
            controller.selectedFilter[index] = "";
          } else {
            controller.selectedFilterId[index] = value.id.toString() ?? "";
            controller.selectedFilter[index] = value.name ?? "";
          }

          controller.offset = 0;
          await controller.getBookListApiCalling(
              isUserFavoriteData: controller.title == C.textYourFavorite);
          controller.inAsyncCall.value = false;
        },
        itemBuilder: (BuildContext context) {
          return controller.listOfFilter[index].filterList!
              .map((Filters value) {
            return PopupMenuItem<Filters>(
                value: value,
                child: Text(
                  value.name ?? "",
                  style: TextStyle(
                      color: controller.selectedFilterId[index]
                              .contains(value.id.toString())
                          ? Col.primary
                          : Col.secondary),
                ));
          }).toList();
        },
      );

  /*DropdownButtonHideUnderline(
        child: DropdownButton(
          onChanged: (value) async {
            controller.inAsyncCall.value = true;
            if (controller.selectedFilterId[index]
                .contains(value?.id.toString() ?? "")) {
              controller.selectedFilterId[index] = "";
              controller.selectedFilter[index] = "";
            } else {
              controller.selectedFilterId[index] = value?.id.toString() ?? "";
              controller.selectedFilter[index] = value?.name ?? "";
            }

            controller.offset = 0;
            await controller.getBookListApiCalling(
                isUserFavoriteData: controller.title == C.textYourFavorite);
            controller.inAsyncCall.value = false;
          },
          items:
              controller.listOfFilter[index].filterList?.map((Filters value) {
            return DropdownMenuItem(
                value: value,
                child: Text(
                  value.name ?? "",
                  style: TextStyle(
                      color: controller.selectedFilterId[index]
                              .contains(value.id.toString())
                          ? Col.primary
                          : Col.secondary),
                ));
          }).toList(),
          iconEnabledColor: Colors.transparent,
          iconDisabledColor: Colors.transparent,
        ),
      );*/

  Widget gridView() {
    if (controller.title == C.textYourFavorite) {
      return SingleChildScrollView(
        child: Wrap(
          children: List.generate(controller.listOfBooks.length, (index) {
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
                                        value: controller.listOfBooks[index]
                                            .bookdetails?.bookThumbnail)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (controller.listOfBooks[index]
                                            .bookdetails?.isAudio ==
                                        "1")

                                      SizedBox(
                                        height: 25.px,
                                        width: 25.px,
                                        child: buttonViewSound(index: index),
                                      ),
                                    if (controller.listOfBooks[index]
                                            .bookdetails?.isAudio ==
                                        "1")
                                      SizedBox(
                                        width: 5.px,
                                      ),
                                    if (controller.getBooksModel.value
                                                ?.favorite !=
                                            null &&
                                        controller
                                            .getBooksModel.value!.favorite!
                                            .contains(controller
                                                .listOfBooks[index]
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
                                      .listOfBooks[index].bookdetails?.title !=
                                  null)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: textViewBookName(
                                        value: controller.listOfBooks[index]
                                                .bookdetails?.title ??
                                            "")),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (controller.listOfBooks[index].bookdetails
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
                                            value: controller.listOfBooks[index]
                                                    .bookdetails?.rating ??
                                                "")
                                      ],
                                    ),
                                  if (controller.listOfBooks[index].bookdetails
                                          ?.rating !=
                                      null)
                                    SizedBox(
                                      width: 10.px,
                                    ),
                                  if (controller.listOfBooks[index].bookdetails
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
                                            value: controller.listOfBooks[index]
                                                    .bookdetails?.views ??
                                                ''),
                                      ],
                                    )
                                ],
                              ),
                              if (controller.listOfBooks[index].bookdetails
                                      ?.authorName !=
                                  null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textViewAuthorName(
                                      value: controller.listOfBooks[index]
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
    } else {
      return SingleChildScrollView(
        child: Wrap(
          children: List.generate(controller.listOfBooks.length, (index) {
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
                                        value: controller
                                            .listOfBooks[index].bookThumbnail)),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.px),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (controller.listOfBooks[index].isAudio ==
                                        "1")
                                      SizedBox(
                                        height: 25.px,
                                        width: 25.px,
                                        child: buttonViewSound(index: index),
                                      ),
                                    if (controller.listOfBooks[index].isAudio ==
                                        "1")
                                      SizedBox(
                                        width: 5.px,
                                      ),
                                    if (controller.getBooksModel.value
                                                ?.favorite !=
                                            null &&
                                        controller
                                            .getBooksModel.value!.favorite!
                                            .contains(controller
                                                .listOfBooks[index].id
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
                              if (controller.listOfBooks[index].title != null)
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: textViewBookName(
                                        value: controller
                                                .listOfBooks[index].title ??
                                            "")),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (controller.listOfBooks[index].rating !=
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
                                            value: controller.listOfBooks[index]
                                                    .rating ??
                                                "")
                                      ],
                                    ),
                                  if (controller.listOfBooks[index].rating !=
                                      null)
                                    SizedBox(
                                      width: 10.px,
                                    ),
                                  if (controller.listOfBooks[index].views !=
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
                                            value: controller
                                                    .listOfBooks[index].views ??
                                                ''),
                                      ],
                                    )
                                ],
                              ),
                              if (controller.listOfBooks[index].authorName !=
                                  null)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: textViewAuthorName(
                                      value: controller
                                              .listOfBooks[index].authorName ??
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
    }
  }

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
        "By "+value,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaBodyLarge(),
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
