
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
  SubscriptionView({Key? key}) : super(key: key);
  SubscriptionController _controller = Get.put(SubscriptionController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return _controller.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ModalProgress(
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
                              SizedBox(
                                height: 10.px,
                              ),
                              listViewPlan(),
                              SizedBox(
                                height: 15.px,
                              ),
                             // buttonViewSubscription(context),
                              Obx(() {
                                return
                                  _controller.isPaymentLoading.value ==true?Center(child: CircularProgressIndicator(),):
                                buttonViewSubscription(context);})
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
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

  Widget listViewPlan() =>Obx(() {
    print("Subscribe plan called");
    return ListView.builder(
      itemBuilder: (context, index) => Obx(() =>
          Padding(
            padding: EdgeInsets.only(bottom: 14.px),
            child: InkWell(
              borderRadius: BorderRadius.circular(5.px),
              onTap: () => controller.clickOnParticularPlan(index: index, price:int.parse(_controller.GetSubcriptionData.value['subscription'][index]['plan_price']),ID:_controller.GetSubcriptionData.value['subscription'][index]['id'] ),
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
                              text: _controller.GetSubcriptionData
                                  .value['subscription'][index]['plan_name']),
                          SizedBox(
                            height: 2.px,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: textViewPlanPrice(
                                    index: index,
                                    price: int.parse(_controller
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

                              textViewPerMonth(index: index,text: _controller
                                  .GetSubcriptionData
                                  .value['subscription'][index]
                              ['plan_duration']),
                              SizedBox(width: 4.px,),
                              Expanded(child: textViewPerMonth(index: index,text: _controller
                                  .GetSubcriptionData
                                  .value['subscription'][index]
                              ['plan_period'])),
                            ],
                          ),

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
      itemCount: _controller.GetSubcriptionDataLength.value,
    );
  });


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

  Widget textViewPerMonth({required int index, i,required String text}) => Text(
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

  Widget buttonViewSubscription(BuildContext context) =>
      CW.commonElevatedButton(
        onPressed: () {
          if (controller.selectedRadioButton.value == null ||
              controller.selectedRadioButton.value <=0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Please select any Payment',
              style: TextStyle(
                color: Colors.black,
              ),
            ),duration: Duration(microseconds: 1500),));
          } else {
            controller.clickOnSubscriptionButton();
          }
        },
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
