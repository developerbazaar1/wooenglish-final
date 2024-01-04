

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';
import '../../splash/controllers/splash_controller.dart';
import '../../subscription/controllers/subscription_controller.dart';
import '../controllers/congratulation_controller.dart';

class CongratulationView extends GetView<CongratulationController> {
  const CongratulationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: ScrollConfiguration(
            behavior: ListScrollBehaviour(),
            child: ListView(
              padding:
                  EdgeInsets.only(top: 120.px, left: C.margin, right: C.margin),
              children: [
                imageViewAppLogo(),
                imageViewCompleteView(),
                SizedBox(
                  height: 10.px,
                ),
                Center(child: textViewCongratulation()),
                SizedBox(
                  height: 15.px,
                ),

                textViewDis(value: C.textYourPayment),
                textViewDis(value: C.textNowYouCanListen),
                SizedBox(
                  height: 25.px,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonViewBackToHome(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageViewAppLogo() => Image.asset(
        C.imageWooEnglishAppLogo,
        height: 150.px,
        width: 150.px,
      );

  Widget imageViewCompleteView() => Image.asset(
        C.imageCompleteLogo,
        height: 200.px,
        width: 200.px,
      );

  Widget textViewCongratulation() => Text(
        C.textCongratulation,
        style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(
              fontFamily: C.fontAlegreya,
              fontSize: 32.px,
              color: Col.secondary,
            ),
      );

  Widget textViewDis({required String value}) => Text(
        value,
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
              color: Col.onSecondary,
              fontSize: 18.px,
              fontFamily: C.fontOpenSans,
            ),
        textAlign: TextAlign.center,
      );

  Widget buttonViewBackToHome() => CW.commonElevatedButton(
        onPressed: () => controller.clickOnBackToHomeButton(),
        child: textViewBackToHomeButton(),
        buttonColor: Col.primaryColor,
        borderRadius: 15.px,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 22.px, vertical: 10.px),
      );

  Widget textViewBackToHomeButton() => Text(
        C.textBackToHome,
        style: CT.alegreyaHeadLineLarge(),
      );
}
