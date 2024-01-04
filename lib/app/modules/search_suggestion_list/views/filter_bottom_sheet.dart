import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_model/get_dashboard_data_model.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/modules/search_suggestion_list/controllers/search_suggestion_list_controller.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class FilterBottomSheet extends GetView<SearchSuggestionListController> {
  FilterBottomSheet({super.key});

  @override
  RxBool value = false.obs;
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: C.margin),
      child: ScrollConfiguration(
        behavior: ListScrollBehaviour(),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(bottom: 20.px),
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.px),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      C.textFilter,
                      style: CT.alegreyaHeadLineLarge(),
                    ),
                    Obx(() {
                      controller.count.value;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonButtonView(
                            onTap: () => controller.clickOnClearFilterButton(),
                            title: C.textShowAll,
                            textColor: Col.primary,
                            isClickable: true,
                          ),
                          SizedBox(
                            width: 5.px,
                          ),   commonButtonView(
                            onTap: () => controller.clickOnClearFilterButton(),
                            title: C.textClearFilter,
                            textColor: controller.categoryValue.isNotEmpty ||
                                    controller.englishAssentValue.isNotEmpty ||
                                    controller.levelValue.isNotEmpty ||
                                    controller.languageValue.isNotEmpty ||
                                    controller.lengthValue.isNotEmpty
                                ? Col.primary
                                : Col.secondary,
                            isClickable: controller.categoryValue.isNotEmpty ||
                                controller.englishAssentValue.isNotEmpty ||
                                controller.levelValue.isNotEmpty ||
                                controller.languageValue.isNotEmpty ||
                                controller.lengthValue.isNotEmpty,
                          ),
                          SizedBox(
                            width: 5.px,
                          ),
                          commonButtonView(
                              onTap: () =>
                                  controller.clickOnApplyFilterButton(),
                              title: C.textApplyFilter,
                              textColor: controller.categoryValue.isNotEmpty ||
                                      controller
                                          .englishAssentValue.isNotEmpty ||
                                      controller.levelValue.isNotEmpty ||
                                      controller.languageValue.isNotEmpty ||
                                      controller.lengthValue.isNotEmpty
                                  ? Col.primary
                                  : Col.secondary,
                              isClickable: controller
                                      .categoryValue.isNotEmpty ||
                                  controller.englishAssentValue.isNotEmpty ||
                                  controller.levelValue.isNotEmpty ||
                                  controller.languageValue.isNotEmpty ||
                                  controller.lengthValue.isNotEmpty),
                        ],
                      );
                    })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.px,
            ),
            commonFilterView(
                list: controller.languageList,
                title: C.textLanguage,
                selectedList: controller.selectedLanguage,
                key: 0),
            commonFilterView(
                list: controller.genreList,
                title: C.textGenre,
                selectedList: controller.selectedGenre,

                key: 1),
            commonFilterView(
                list: controller.englishAccentList,
                title: C.textEnglishAssent,
                selectedList: controller.selectedEnglishAssent,
                key: 2),
            commonFilterView(
                list: controller.levelList,
                title: C.textLevel,
                selectedList: controller.selectedLevel,
                key: 3),
            commonFilterView(
                list: controller.lengthList,
                title: C.textLength,
                selectedList: controller.selectedLength,
                wantDivider: false,
                key: 4),
          ],
        ),
      ),
    );
  }

  Widget commonButtonView(
      {VoidCallback? onTap,
      required String title,
      required Color textColor,
      required bool isClickable}) {
    if (!isClickable) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 4.px),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.px)),
        child: Text(
          title,
          style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                fontFamily: C.fontOpenSans,
                color: textColor,
              ),
        ),
      );
    } else {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4.px),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.px, vertical: 4.px),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.px)),
          child: Text(
            title,
            style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                  fontFamily: C.fontOpenSans,
                  color: textColor,
                ),
          ),
        ),
      );
    }
  }

  Widget commonFilterView(
          {required String title,
          required List<Filters> list,
          required List<int> selectedList,
          required int key,
          bool wantDivider = true}) =>
      Obx(() {
        controller.count.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textViewTitle(value: title),
            SizedBox(
              height: 2.px,
            ),
            listViewFilters(list: list, selectedList: selectedList, key: key),
            SizedBox(
              height: 8.px,
            ),
            if (wantDivider)
              Divider(
                color: Col.primaryColor,
                height: 0.px,
                thickness: 3.px,
              )
          ],
        );
      });

  Widget textViewTitle({
    required String value,
  }) =>
      Text(
        value,
        style: CT.openSansBodyMedium(),
      );

  Widget listViewFilters(
          {required List<Filters> list,
          required List<int> selectedList,
          required int key}) =>
      Obx(() {
        controller.count.value;
        return Wrap(
          children: List.generate(
            list.length,
            (index) => list[index].name!.isNotEmpty
                ? InkWell(
                    onTap: () {
                      if(selectedList[index] == list[index].id){
                        value.value = true;
                      }else{
                        value.value = false;
                      }

                      controller.clickOnParticularFilter(

                          index: index, key: key,name: "${list[index].name}",
                      value: value.value);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10.px, bottom: 2.px),
                      padding: EdgeInsets.symmetric(horizontal: 5.px),
                      decoration: BoxDecoration(
                          color: selectedList[index] == list[index].id
                              ? Col.primary
                              : Col.inverseSecondary,
                          borderRadius: BorderRadius.circular(8.px)),
                      child: textViewBrowsTitle(
                          list: list, index: index, selectedList: selectedList),
                    ),
                  )
                : const SizedBox(),
          ),
        );
      });

  Widget textViewBrowsTitle(
          {required List<Filters> list,
          required int index,
          required List<int> selectedList}) =>
      Text(
        list[index].name ?? "",
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
            fontFamily: C.fontAlegreya,
            color: selectedList.contains(list[index].id)
                ? Col.inverseSecondaryVariant
                : Col.textGrayColor),
      );
}
