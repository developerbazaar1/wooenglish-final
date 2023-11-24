import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/app/validator/validator.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

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
              key: controller.formKey,
              autovalidateMode: C.autoValidateMode,
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
                                textViewHello(),
                                textViewWellCome(),
                                SizedBox(
                                  height: 15.px,
                                ),
                                Row(
                                  children: [
                                    textViewMobileNumber(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.px,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                    flex: 5, child: textFieldCountryCode()),
                                    SizedBox(
                                      width: 10.px,
                                    ),
                                    Expanded(
                                        flex: 13,
                                        child: textFieldViewMobileNumber()),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.px,
                                ),
                                buttonViewGetOtp(),
                                SizedBox(
                                  height: 30.px,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Divider(
                                      color: Col.onSecondary,
                                      thickness: 2.px,
                                      endIndent: 10.px,
                                    )),
                                    textViewContinueWith(),
                                    Expanded(
                                        child: Divider(
                                      color: Col.onSecondary,
                                      thickness: 2.px,
                                      indent: 10.px,
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.px,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   /* SizedBox(
                                      height: 30.px,
                                      width: 30.px,
                                      child: floatingButtonViewFacebook(),
                                    ),
                                    SizedBox(
                                      width: 30.px,
                                    ),*/
                                    SizedBox(
                                      height: 30.px,
                                      width: 30.px,
                                      child: floatingButtonViewGoogle(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15.px,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textViewDontHaveAccount(),
                                    buttonViewSignUp()
                                  ],
                                )
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

  Widget textViewHello() => Text(
        C.textHelloAgain,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall
            ?.copyWith(fontFamily: C.fontPlayfairDisplay, fontSize: 32.px),
      );

  Widget textViewWellCome() => Text(
        C.textWelcomeBack,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall
            ?.copyWith(fontFamily: C.fontPlayfairDisplay, fontSize: 32.px),
      );

  Widget textViewMobileNumber() => Text(
        C.textMobileNumber,
        style: CT.playfairHeadLineMedium(),
      );

  Widget textFieldViewMobileNumber() => CW.commonTextFieldForLoginSignUP(
        controller: controller.mobileNumberController,
        hintText: C.textEnterNumber,
        keyboardType: TextInputType.number,
        validator: (value) => Validator.isValid(value: value, title: "Number"),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        maxHeight: 52.px,
        onChanged: (value) {},
      );

  Widget textFieldCountryCode() =>CW.textFieldCountryCode(
    onTap: () => controller.clickOnCountryCode(),
    code:controller.countryCodeController.text ,
    logo: controller.countyLogo.value,

  );

  Widget buttonViewGetOtp() => CW.commonElevatedButtonForLoginSignUp(
      onPressed: () => controller.isOtpButtonClicked.value
          ? null
          : controller.clickOnGetOtpButton(),
      child: textViewGetOtp(),
      isClicked: controller.isOtpButtonClicked.value,
      wantContentSizeButton: false,
      buttonColor: Col.darkGreen);

  Widget textViewGetOtp() =>
      Text(C.textGetOtp, style: CT.openSansDisplayLarge());

  Widget textViewContinueWith() => Text(
        C.textContinueWith,
        style: Theme.of(Get.context!).textTheme.displaySmall?.copyWith(
            color: Col.onSecondary, fontSize: 18.px, fontFamily: C.fontLato),
      );

  Widget floatingButtonViewFacebook() => FloatingActionButton(
        onPressed: () => controller.clickOnFacebookButton(),
        heroTag: null,
        backgroundColor: Col.blue,
        child: imageViewFacebookLogo(),
      );

  Widget imageViewFacebookLogo() => Image.asset(
        C.imageFacebookLogo,
        height: 15.px,
        width: 9.px,
      );

  Widget floatingButtonViewGoogle() => FloatingActionButton(
        onPressed: () => controller.clickOnGoogleButton(),
        heroTag: null,
        backgroundColor: Col.onError,
        child: imageViewGoogleLogo(),
      );

  Widget imageViewGoogleLogo() => Image.asset(
        C.imageGoogleLogo,
        height: 10.px,
        width: 16.px,
      );

  Widget textViewDontHaveAccount() => Text(C.textDontHaveAccount,
      style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
          fontFamily: C.fontOpenSans,
          fontSize: 12.px,
          color: Col.secondaryContainer));

  Widget buttonViewSignUp() => CW.commonTextButton(
      onPressed: () => controller.clickOnSignUpButton(),
      contentPadding: EdgeInsets.zero,
      child: textViewSignUp());

  Widget textViewSignUp() => Text(
        C.textSignUp,
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.darkGreen),
      );
}
