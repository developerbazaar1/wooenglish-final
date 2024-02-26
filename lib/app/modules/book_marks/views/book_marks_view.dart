import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/load_more/load_more.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../../../theme/colors/colors.dart';
import '../controllers/book_marks_controller.dart';

class BookMarksView extends GetView<BookMarksController> {
  const BookMarksView({Key? key}) : super(key: key);

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
                      if (controller.bookList.isNotEmpty) {
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
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      title: C.textMyBookMark, onPressed: () => controller.clickOnBackButton());

  Widget listView() => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(bottom: 15.px),
          decoration: BoxDecoration(
              border: Border.all(color: Col.borderColor, width: 3.px),
              borderRadius: BorderRadius.circular(5.px),
              color: Col.inverseSecondary),
          child: InkWell(
            onTap: () => controller.clickOnParticularBook(index: index),
            borderRadius: BorderRadius.circular(5.px),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 15.px),
              child: Row(
                children: [
                  imageViewBookMark(index: index),
                  SizedBox(
                    width: 17.px,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textBookName(index: index),
                      textBookDis(index: index),
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
        itemCount: controller.bookList.length,
        padding: EdgeInsets.only(left: C.margin, right: C.margin, top: 17.px),
      );

  Widget imageViewBookMark({required int index}) => Image.asset(
        C.imageBookmarkTitle,
        height: 23.px,
        width: 15.px,
      );

  Widget textBookName({required int index}) => Text(
        controller.bookList[index].bookdetails?.title ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget textBookDis({required int index}) => Text(
        CM.parseHtmlString(controller.bookList[index].chapterName ?? ''),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(fontSize: 12.px, fontFamily: C.fontOpenSans),
      );

  Widget imageViewArrow({required int index}) => Image.asset(
        C.imageArrowForwordDark,
        height: 15.px,
        width: 6.px,
      );
}
