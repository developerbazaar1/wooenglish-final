import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgress(
      inAsyncCall: controller.inAsyncCall.value,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            appBarView(),
            Expanded(
              child: ScrollConfiguration(
                behavior: ListScrollBehaviour(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 16.px,
                      left: C.margin,
                      right: C.margin,
                      bottom: C.margin + C.margin),
                  children: [
                    textViewGetAllAccess(),
                    SizedBox(
                      height: 15.px,
                    ),
                    textViewSubscriptionDis(),
                    Container(
                      padding: EdgeInsets.all(C.margin / 2),
                      margin: EdgeInsets.symmetric(vertical: 17.px),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.px),
                          border:
                          Border.all(color: Col.borderColor, width: 3.px),
                          color: Col.inverseSecondary),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textViewWhatIncludeInSubscription(),
                          listViewIncludedPlan(),
                        ],
                      ),
                    ),
                    listViewPlan(),
                    SizedBox(
                      height: 15.px,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttonViewSubscription(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
        onPressed: () => controller.clickOnBackButton(),
        title: C.textSubscription,
      );

  Widget textViewTitle() => Text(
        C.textWhatIncludedInSubscriptionDis,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
              color: Col.onSecondary,
              fontFamily: C.fontOpenSans,
            ),
      );

  Widget textViewGetAllAccess() => Text(
        C.textGetAccessToAllBooksAndFeatures,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget textViewSubscriptionDis() => Text(
        C.textSubscriptionDis,
        style: CT.openSansTitleSmall(),
      );

  Widget textViewWhatIncludeInSubscription() => Text(
        C.textWhatIncludedInSubscription,
        style: Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
            fontSize: 14.px,
            fontFamily: C.fontOpenSans,
            fontWeight: FontWeight.w600),
      );

  Widget listViewIncludedPlan() => ListView.builder(
        itemBuilder: (context, index) => Obx(() => Row(
              children: [
                Expanded(
                  child: textViewTitle(),
                ),
                SizedBox(
                  width: 30.px,
                  height: 30.px,
                  child: radioButtonViewForIncludePlan(index: index),
                ),
              ],
            )),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.currentIndexOfIncludePlan.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
      );

  Widget radioButtonViewForIncludePlan({required int index}) => Radio(
      toggleable: true,
      fillColor: MaterialStateProperty.all(Col.primary),
      value: index,
      groupValue: controller.currentIndexOfIncludePlan[index],
      onChanged: (flag) {
        if (controller.currentIndexOfIncludePlan[index] == index) {
          controller.currentIndexOfIncludePlan[index] = -1;
        } else {
          controller.currentIndexOfIncludePlan[index] = flag!;
        }
      });

  Widget listViewPlan() => ListView.builder(
        itemBuilder: (context, index) => Obx(() => Padding(
              padding: EdgeInsets.only(bottom: 14.px),
              child: InkWell(
                borderRadius: BorderRadius.circular(5.px),
                onTap: () => controller.clickOnParticularPlan(index: index),
                child: Ink(
                  padding: EdgeInsets.all(C.margin / 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.px),
                      border: Border.all(color: Col.borderColor, width: 3.px),
                      color: controller.currentIndexOfPlan.value == index
                          ? Col.cardBackgroundColor
                          : Col.inverseSecondary),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textViewPlanName(index: index),
                            SizedBox(
                              height: 2.px,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: textViewPlanPrice(index: index),
                                ),
                                Expanded(child: textViewPerMonth(index: index)),
                              ],
                            ),
                            SizedBox(
                              height: 2.px,
                            ),
                            textViewPlanDis(index: index),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.px,
                        width: 50.px,
                        child: Transform.scale(
                          scale: 1.5,
                          child: radioButtonViewForPlan(index: index),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 3,
      );

  Widget textViewPlanName({required int index}) => Text(
        C.textFreeTrial,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.onSecondary),
      );

  Widget textViewPlanPrice({required int index}) => Text(
        "\$9.99",
        style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(
              fontFamily: C.fontOpenSans,
              color: Col.primary,
            ),
      );

  Widget textViewPerMonth({required int index}) => Text(
        C.textPerMonthRupee,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
            fontFamily: C.fontOpenSans,
            fontSize: 12.px,
            color: Col.onSecondary),
      );

  Widget textViewPlanDis({required int index}) => Text(
        C.textThenPerMonthRupeeSelected,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: C.fontOpenSans, fontSize: 12.px),
      );

  Widget radioButtonViewForPlan({required int index}) => Radio(
      toggleable: true,
      fillColor: MaterialStateProperty.all(Col.primary),
      value: index,
      groupValue: controller.currentIndexOfPlan.value,
      onChanged: (flag) {
        if (controller.currentIndexOfPlan.value == index) {
          controller.currentIndexOfPlan.value = -1;
        } else {
          controller.currentIndexOfPlan.value = flag!;
        }
      });

  Widget buttonViewSubscription() => CW.commonElevatedButton(
        onPressed: () => controller.clickOnSubscriptionButton(),
        child: textViewSubscriptionButton(),
        buttonColor: Col.primaryColor,
        borderRadius: 15.px,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 22.px, vertical: 10.px),
      );

  Widget textViewSubscriptionButton() => Text(
        C.textSubscriptionNow,
        style: CT.alegreyaHeadLineLarge(),
      );
}
