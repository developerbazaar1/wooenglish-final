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
import '../controllers/author_list_controller.dart';

class AuthorListView extends GetView<AuthorListController> {
  const AuthorListView({Key? key}) : super(key: key);

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
              SizedBox(
                height: 10.px,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: C.margin),
                child: CW.commonTextFieldForSearch(
                    controller: controller.searchController,
                    wantFilterIcon: false,
                    textInputAction: TextInputAction.search,
                    fillColor: Col.cardBackgroundColor,
                    onChanged: (value) => controller.onChange(value: value),
                    onFieldSubmitted: (value) => controller.isSearchShow.value
                        ? controller.clickOnSearchKeyBordButton(value: value)
                        : null,
                    hintText: C.textSearchNarrators,
                    clickOnSearchIcon: () {}),
              ),
              Obx(() {
                if (AppController.isConnect.value) {
                  if (controller.responseCode.value == 200 ||
                      controller.getDataModel.value != null) {
                    if (controller.authorList.isNotEmpty) {
                      return ScrollConfiguration(
                        behavior: ListScrollBehaviour(),
                        child: controller.loaderForSearch.value
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [CW.commonProgressBarView()],
                                ),
                              )
                            : Expanded(
                                child: CW.commonRefreshIndicator(
                                  onRefresh: () => controller.onRefresh(),
                                  child: RefreshLoadMore(
                                    isLastPage: controller.isLastPage.value,
                                    onLoadMore: () => controller.onLoadMore(),
                                    child: ListView(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: [gridView()],
                                    ),
                                  ),
                                ),
                              ),
                      );
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
                                commonTitleForError(title: C.textNoDataTitle),
                                commonDisForError(dis: C.textNoDataDis),
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
    });
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      title: C.textFamousAuthors,
      onPressed: () => controller.clickOnBackButton());

  Widget gridView() => SingleChildScrollView(
        child: Wrap(
          children: List.generate(controller.authorList.length, (index) {
            final cellWidth = MediaQuery.of(Get.context!).size.width /
                3; // Every cell's `width` will be set to 1/2 of the screen width.
            return SizedBox(
              width: cellWidth,
              child: GestureDetector(
                onTap: () => controller.clickOnParticularAuthor(index: index),
                child: Container(
                    width: cellWidth,
                    height: 130.px,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 2.px, right: 2.px),
                    margin: EdgeInsets.only(
                        left: index + 1 % 3 == 1 ? 16.px : 10.px,
                        right: index + 1 % 3 == 0 ? 16.px : 10.px,
                        bottom: 16.px,
                        top: 17.px),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70.px)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.px),
                          child: imageViewAuthor(
                              value: controller.authorList[index].authorImage ??
                                  ""),
                        ),
                        SizedBox(
                          height: 5.px,
                        ),
                        if (controller.authorList[index].name != null)
                          textAuthorName(
                              value: controller.authorList[index].name ?? "")
                      ],
                    )),
              ),
            );
          }),
        ),
      );

  Widget imageViewAuthor({required String value}) {
    if (value.isNotEmpty) {
      return Image.network(
        CM.getImageUrl(value: value),
        height: 100.px,
        width: 100.px,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CW.commonShimmerViewForImage(
              height: 100.px, width: 100.px, radius: 50.px);
        },
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

  Widget textAuthorName({required String value}) => Text(
        value,
        style: CT.alegreyaBodySmall(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );

  static Widget commonTitleForError({required String title}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.px),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(Get.context!)
            .textTheme
            .displayLarge
            ?.copyWith(color: Col.text, fontFamily: C.fontOpenSans),
      ),
    );
  }

  static Widget commonDisForError({required String dis}) {
    return Text(
      dis,
      textAlign: TextAlign.center,
      style: Theme.of(Get.context!)
          .textTheme
          .titleMedium
          ?.copyWith(color: Col.textGrayColor, fontFamily: C.fontOpenSans),
    );
  }
}
