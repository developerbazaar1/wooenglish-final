import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../../../common/common_method/common_method.dart';
import '../controllers/search_suggestion_list_controller.dart';

class SearchSuggestionListView extends GetView<SearchSuggestionListController> {
  const SearchSuggestionListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgress(
          inAsyncCall: controller.inAsyncCall.value,
          child: GestureDetector(
            onTap: () => CM.unFocsKeyBoard(),
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                children: [
                  appBarView(),
                  SizedBox(
                    height: 10.px,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: C.margin),
                    child: CW.commonTextFieldForSearch(
                        controller: controller.searchController,
                        textInputAction: TextInputAction.search,
                        fillColor: Col.cardBackgroundColor,
                        onChanged: (value) => controller.onChange(value: value),
                        onFieldSubmitted: (value) =>
                            controller.isSearchShow.value
                                ? controller.clickOnSearchKeyBordButton(
                                    value: value)
                                : null,
                        hintText: C.textSearch,
                        clickOnFilterIcon: () =>
                            controller.clickOnFilterButton(),
                        clickOnSearchIcon: () =>
                            controller.clickOnSearchIcon()),
                  ),
                  Obx(() {
                    if (AppController.isConnect.value) {
                      if (controller.responseCode.value == 200 ||
                          controller.getDataNewReleaseBook.value != null) {
                        if (controller.bookList.isNotEmpty) {
                          return ScrollConfiguration(
                              behavior: ListScrollBehaviour(),
                              child: controller.loaderForSearch.value
                                  ? Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [CW.commonProgressBarView()],
                                      ),
                                    )
                                  : Expanded(child: listViewSuggestionBooks()));
                        } else {
                          if (controller.loaderForSearch.value) {
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [CW.commonProgressBarView()],
                              ),
                            );
                          } else {
                            return Expanded(
                              child: ScrollConfiguration(
                                behavior: ListScrollBehaviour(),
                                child: ListView(
                                  children: [
                                    Image.asset(C.imageNoDataFound),
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                      } else {
                        if (controller.responseCode.value == 0) {
                          return const SizedBox();
                        }
                        return Expanded(
                          child: ScrollConfiguration(
                            behavior: ListScrollBehaviour(),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Image.asset(C.imageSomethingWentWrong),
                              ],
                            ),
                          ),
                        );
                      }
                    } else {
                      return Expanded(
                        child: ScrollConfiguration(
                          behavior: ListScrollBehaviour(),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              Image.asset(C.imageNoInternetConnection),
                            ],
                          ),
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ));
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      title: C.textSearch, onPressed: () => controller.clickOnBackButton());

  Widget listViewSuggestionBooks() {
    return Container(
      margin: EdgeInsets.only(
        left: C.margin,
        right: C.margin,
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.px)),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: controller.scrollController,
        itemBuilder: (context, index) => Container(
          color: Col.inverseSecondary,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: index == 0 || index == controller.bookList.length - 1
                    ? 10.px
                    : 5.px,
                horizontal: 10.px),
            child: GestureDetector(
              onTap: () => controller.clickOnParticularBook(index: index),
              child: Row(
                children: [
                  imageViewBookImage(
                      image: controller.bookList[index].bookThumbnail),
                  SizedBox(
                    width: 10.px,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.bookList[index].title != null)
                        textViewBookName(index: index),
                    ],
                  )),
                  buttonViewArrow(index: index)
                ],
              ),
            ),
          ),
        ),
        itemCount: controller.bookList.length,
      ),
    );
  }

  Widget imageViewBookImage({String? image}) {
    if (image != null) {
      return Image.network(
        CM.getImageUrl(value: image),
        height: 60.px,
        width: 50.px,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 60.px, width: 50.px, radius: 0.px);
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            C.imageBookImage,
            height: 60.px,
            width: 50.px,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        C.imageBookImage,
        height: 60.px,
        width: 50.px,
        fit: BoxFit.cover,
      );
    }
  }

  Widget textViewBookName({required int index}) => Text(
        controller.bookList[index].title ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaBodySmall(),
      );

  Widget buttonViewArrow({required int index}) => IconButton(
        onPressed: () => controller.clickOnArrowButton(index: index),
        padding: EdgeInsets.zero,
        splashRadius: C.iconButtonRadius,
        icon: imageViewArrow(index: index),
      );

  Widget imageViewArrow({required int index}) => Image.asset(
        C.imageSuggestionArrowLogo,
        height: 20.px,
        width: 23.px,
      );
}
