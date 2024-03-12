import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../../../../DeshBorder/DeshBorder.dart';
import '../controller/my_subcription_plan_controller.dart';

class MyPlanSubscriptionView extends GetView<MySubscriptionController> {
  MyPlanSubscriptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalProgress(
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
                      left: 28.px,
                      right: 28.px,
                      bottom: C.margin + C.margin),
                  children: [
                    textViewSubcriptionDetails(),
                    SizedBox(
                      height: 15.px,
                    ),
                    textViewSubscriptionManage(),

                    SizedBox(
                      height: 15.px,
                    ),
                    ActivePlan(context),
                    SizedBox(
                      height: 15.px,
                    ),
                    listViewPlan(),
                    SizedBox(
                      height: 20.px,
                    ),
                    buttonViewSubscription(context)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
        onPressed: () => controller.clickOnBackButton(),
        title: C.textMySubcriptionPlan,
      );

  Widget textViewTitle() => Text(
        C.textWhatIncludedInSubscriptionDis,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
              color: Col.onSecondary,
              fontFamily: C.fontOpenSans,
            ),
      );

  Widget textViewSubcriptionDetails() => Text(
        C.textSubcriptionDetails,
        style: CT.alegreyaDisplaySmall(),
        textAlign: TextAlign.center,
      );

  Widget textViewSubscriptionManage() => Text(
        C.textSubscriptionManage,
        style: CT.openSansTitleSmall(),
    textAlign: TextAlign.center,

      );

  Widget ActivePlan(BuildContext context) => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              C.textActivePlanSubscription,
              style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                  fontSize: 20.px,
                  fontFamily: C.fontAlegreya,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.left,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: DashedBorderPainter(
                      color: Col.primary,
                      dashWidth: 4,
                      strokeWidth: 1.5,
                      spaceWidth: 3),
                ),
              ),
            ),
            Obx(() => MyPlanDetails(
                context, C.textMyPlanName, controller.planName.value)),
            SizedBox(
              height: 10.px,
            ),
            Obx(
              () => MyPlanDetails(context, C.textMyPlanPurchased,
                  controller.MembershipDate.value),
            ),
            SizedBox(
              height: 10.px,
            ),
            Obx(() => MyPlanDetails(
                context, C.textMyPlanPrice, controller.planPrice.value)),
            SizedBox(
              height: 10.px,
            ),
            Obx(() => MyPlanDetails(
                context,
                C.textMyPlanDuration,
                controller.MembershipDuration.value +
                    ' ' +
                    controller.MembershipPeriods.value)),
            SizedBox(
              height: 10.px,
            ),
            Obx(() => MyPlanDetails(context, C.textMyPlanExpiry,
                controller.MembershipExpireDate.value)),
          ],
        ),
      );


  Widget listViewPlan() {


    return Obx(() => ListView.builder(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        print("current plan is");
        if(controller.planPrice.toString() == controller.GetSubcriptionData.value['subscription'][index]['plan_price']){
          controller.isUpgrade.value = true;
        }else{
          controller.isUpgrade.value = false;
        }
          return controller.isUpgrade.value
              ?SizedBox()
              :Obx(() => Padding(
        padding: EdgeInsets.only(bottom: 14.px),
        child: InkWell(
          borderRadius: BorderRadius.circular(5.px),
          onTap: () => controller.clickOnParticularPlan(
              index: index,
              price: int.parse(controller.GetSubcriptionData
                  .value['subscription'][index]['plan_price']),
              ID: controller.GetSubcriptionData.value['subscription']
              [index]['id']),
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
                      textViewPlanName(
                          index: index,
                          text: controller.GetSubcriptionData
                              .value['subscription'][index]
                          ['plan_name']),
                      SizedBox(
                        height: 2.px,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: textViewPlanPrice(
                                index: index,
                                price: int.parse(controller
                                    .GetSubcriptionData
                                    .value['subscription'][index]
                                ['plan_price'])),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.px,
                      ),
                      Row(
                        children: [
                          textViewPerMonth(
                              index: index,
                              text: controller.GetSubcriptionData
                                  .value['subscription'][index]
                              ['plan_duration']),
                          SizedBox(
                            width: 4.px,
                          ),
                          Expanded(
                              child: textViewPerMonth(
                                  index: index,
                                  text: controller.GetSubcriptionData
                                      .value['subscription'][index]
                                  ['plan_period'])),
                        ],
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 50.px,
                //   width: 50.px,
                //   child: Transform.scale(
                //     scale: 1.5,
                //     child: radioButtonViewForPlan(index: index),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ))
              ;},
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: controller.GetSubcriptionDataLength.value,
    ));
  }

  SizedBox MyPlanDetails(BuildContext context, String title, String subtitle) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.px,
                fontFamily: C.fontOpenSans,
                fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle??'',
            style: TextStyle(
                color: Col.primary,
                fontSize: 20.px,
                fontFamily: C.fontOpenSans,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget textViewPlanName({required int index, required text}) => Text(
        text,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.onSecondary),
      );

  Widget textViewPlanPrice({required int index, required int price}) => Text(
        "\$$price",
        style: Theme.of(Get.context!).textTheme.displayLarge?.copyWith(
              fontFamily: C.fontOpenSans,
              color: Col.primary,
            ),
      );

  Widget textViewPerMonth({required int index, i, required String text}) =>
      Text(
        text,
        style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
            fontFamily: C.fontOpenSans,
            fontSize: 14.px,
            color: Col.onSecondary),
      );

  Widget textViewPlanDis({required int index}) => Text(
        C.textThenPerMonthRupeeSelected,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: C.fontOpenSans, fontSize: 12.px),
      );

  Widget textViewUpgradeButton() => Text(
        C.textUpgradeNow,
        style: CT.alegreyaHeadLineLarge(),
      );
  Widget buttonViewSubscription(BuildContext context) =>
      CW.commonElevatedButton(
        onPressed: () {
          controller.clickOnUpgradeButton();
        },
        child: textViewUpgradeButton(),
        buttonColor: Col.primaryColor,
        borderRadius: 15.px,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 22.px, vertical: 10.px),
      );
}
