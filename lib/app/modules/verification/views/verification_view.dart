import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

import '../controllers/verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.absorbing.value,
        child: GestureDetector(
          onTap: () => CM.unFocsKeyBoard(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Form(
              child: ScrollConfiguration(
                behavior: ListScrollBehaviour(),
                child: ListView(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: C.margin,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: C.wooEnglishAppLogoMargin,
                            ),
                            imageViewWooEnglishApp(),
                            SizedBox(
                              height: 30.px,
                            ),
                            Column(
                              children: [
                                textViewEnterOtp(),
                                SizedBox(
                                  height: 15.px,
                                ),
                                textViewConfirmation(),
                                SizedBox(
                                  height: 15.px,
                                ),
                                buttonViewOtp(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textViewNotGetOtp(),
                                    if (controller.secondsRemaining.value == 0)
                                      buttonViewResendOtp(),
                                  ],
                                ),
                                if (controller.secondsRemaining.value != 0)
                                  SizedBox(
                                    height: 10.px,
                                  ),
                                if (controller.secondsRemaining.value != 0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      textViewResendOtp(),
                                      SizedBox(width: 2.px),
                                      Text(
                                        '(after ${controller.secondsRemaining.value} seconds)',
                                        style: Theme.of(Get.context!)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(fontSize: 14.px),
                                      ),
                                    ],
                                  ),
                                if (controller.secondsRemaining.value != 0)
                                  SizedBox(
                                    height: 10.px,
                                  ),
                                buttonViewVerify(),
                              ],
                            ),
                            SizedBox(
                              height: C.margin,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imageViewWooEnglishApp() => Image.asset(
        C.imageWooEnglishAppLogo,
        height: 150.px,
        width: 150.px,
      );

  Widget textViewEnterOtp() => Text(
        C.textEnterOtp,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall
            ?.copyWith(fontFamily: C.fontPlayfairDisplay, fontSize: 32.px),
        textAlign: TextAlign.center,
      );

  Widget textViewConfirmation() {
    return Text(
      "${C.textConfirmation}${controller.countryCode} #######${controller.number.substring(controller.number.length - 3)}",
      style: Theme.of(Get.context!)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: C.fontOpenSans, color: Col.onSecondary),
      textAlign: TextAlign.center,
    );
  }

  Widget buttonViewOtp() => PinCodeTextField(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        appContext: (Get.context!),
        length: 6,
/*
    textStyle: Theme.of(Get.context!).textTheme.headline2?.copyWith(color: Theme.of(Get.context!).colorScheme.onSurface),
*/
        cursorColor: Theme.of(Get.context!).colorScheme.primary,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        blinkWhenObscuring: true,
        autoDisposeControllers: false,
        animationType: AnimationType.none,
        pinTheme: PinTheme(
          inactiveColor: Col.inverseSecondary,
          inactiveFillColor: Col.inverseSecondary,
          activeColor: Col.darkBlue,
          activeFillColor: Col.backgroundFillColor,
          selectedColor: Col.darkBlue,
          selectedFillColor: Col.backgroundFillColor,
          shape: PinCodeFieldShape.box,
          fieldWidth: 50.px,
          fieldHeight: 60.px,
          borderWidth: 1.px,
          borderRadius: BorderRadius.circular(10.px),
        ),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: controller.otpController,
        onChanged: (value) {
          value = value.trim();
          if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
            controller.otpController.text = "";
          }
        },
        beforeTextPaste: (text) {
          return true;
        },
      );

  Widget textViewNotGetOtp() => Text(C.textNotGetOtp,
      style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
          fontFamily: C.fontOpenSans,
          fontSize: 12.px,
          color: Col.secondaryContainer));

  Widget buttonViewResendOtp() => CW.commonTextButton(
      onPressed: () => controller.enableResend.value
          ? controller.clickOnResendOtpButton()
          : null,
      contentPadding: EdgeInsets.zero,
      child: textViewResendOtp());

  Widget textViewResendOtp() => Text(
        C.textResendOtp,
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.darkGreen),
      );

  Widget buttonViewVerify() => CW.commonElevatedButtonForLoginSignUp(
      onPressed: () => controller.isVerifyButtonClicked.value
          ? null
          : controller.clickOnVerifyButton(),
      child: textViewVerify(),
      isClicked: controller.isVerifyButtonClicked.value,
      wantContentSizeButton: false,
      buttonColor: Col.darkGreen);

  Widget textViewVerify() =>
      Text(C.textVerify, style: CT.openSansDisplayLarge());
}
