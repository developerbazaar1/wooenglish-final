import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
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
                    if (controller.getDataModel.value?.page?.pageName != null &&
                        controller
                            .getDataModel.value!.page!.pageName!.isNotEmpty &&
                        controller.getDataModel.value?.page?.pageDescription !=
                            null &&
                        controller.getDataModel.value!.page!.pageDescription!
                            .isNotEmpty) {
                      return Expanded(
                        child: ScrollConfiguration(
                          behavior: ListScrollBehaviour(),
                          child: Scrollbar(
                            child: CW.commonRefreshIndicator(
                              onRefresh: () => controller.onRefresh(),
                              child: ListView(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 17.px,
                                      horizontal: C.margin + 5.px),
                                  children: [
                                    textViewTitle(
                                        value: controller.getDataModel.value
                                                ?.page?.pageName ??
                                            "",
                                        fontSize: 20.px),
                                    textViewDis(
                                        value: controller.getDataModel.value
                                                ?.page?.pageDescription ??
                                            ""),
                                  ]),
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
      ),
    );
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      onPressed: () => controller.clickOnBackButton(),
      title: C.textPrivacyPolicy);

  Widget textViewTitle({required String value, required double fontSize}) =>
      Text(value,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge
              ?.copyWith(fontFamily: C.fontOpenSans, fontSize: fontSize));

  Widget textViewDis({required String value}) => Text(
        CM.parseHtmlString(value),
        style: CT.openSansBodySmall(),
      );
}
