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

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

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
                                textViewGetStart(),
                                SizedBox(
                                  height: 5.px,
                                ),
                                Row(
                                  children: [
                                    textViewName(),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.px,
                                ),
                                textFieldViewName(),
                                SizedBox(
                                  height: 5.px,
                                ),
                                Row(
                                  children: [
                                    textViewMobileNumber(),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.px,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 3, child: textFieldCountryCode()),
                                    SizedBox(
                                      width: 10.px,
                                    ),
                                    Expanded(
                                        flex: 14,
                                        child: textFieldViewMobileNumber()),
                                  ],
                                ),

                                SizedBox(
                                  height: 5.px,
                                ),
                                Row(
                                  children: [
                                    textViewEmailAddress(),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.px,
                                ),
                                textFieldViewEmailAddress(),
                                SizedBox(
                                  height: 20.px,
                                ),
                                buttonViewSignUp(),
                                SizedBox(
                                  height: 15.px,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textViewAlreadyHaveAccount(),
                                    buttonViewSignIn()
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

  Widget textViewGetStart() => Text(
        C.textToGetStarted,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineSmall
            ?.copyWith(fontFamily: C.fontPlayfairDisplay, fontSize: 32.px),
      );

  Widget textViewName() => Text(
        C.textName,
        style: CT.playfairHeadLineMedium(),
      );

  Widget textFieldViewName() => CW.commonTextFieldForLoginSignUP(
      controller: controller.nameController,
      hintText: C.textEnterName,
      validator: (value) => Validator.isNameValid(value: value),
      keyboardType: TextInputType.name);

  Widget textViewMobileNumber() => Text(
        C.textMobileNumber,
        style: CT.playfairHeadLineMedium(),
      );


  Widget textFieldCountryCode() => CW.commonTextFieldForLoginSignUP(
    controller: controller.countryCodeController,
    hintText: C.textDefaultCountryCode,
    keyboardType: TextInputType.text,
    readOnly: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 5.px),
    onTap: () =>controller.clickOnCountryCode(),
    maxHeight: 52.px,
    onChanged: (value) {},
    wantBorder: false,

  );

  Widget textFieldViewMobileNumber() =>
      CW.commonTextFieldForLoginSignUP(
          controller: controller.mobileNumberController,
          hintText: C.textEnterNumber,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {},
          validator: (value) => Validator.isValid(value: value,title: 'Number'),
          keyboardType: TextInputType.number);

  Widget textViewEmailAddress() => Text(
        C.textEmail,
        style: CT.playfairHeadLineMedium(),
      );

  Widget textFieldViewEmailAddress() =>
      CW.commonTextFieldForLoginSignUP(
          controller: controller.emailAddressController,
          hintText: C.textEnterEmailAddress,
          validator: (value) => Validator.isEmailValid(value: value),
          keyboardType: TextInputType.emailAddress);


  Widget buttonViewSignUp() => CW.commonElevatedButtonForLoginSignUp(
      onPressed: () =>  controller.isSignUpButtonClicked.value?null:controller.clickOnSignUpButton(),
      child: textViewSignUp(),
      isClicked: controller.isSignUpButtonClicked.value,
      wantContentSizeButton: false,
      buttonColor: Col.darkGreen);

  Widget textViewSignUp() =>
      Text(C.textSignUp, style: CT.openSansDisplayLarge());

  Widget textViewAlreadyHaveAccount() => Text(C.textAlreadyHave,
      style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
          fontFamily: C.fontOpenSans,
          fontSize: 12.px,
          color: Col.secondaryContainer));

  Widget buttonViewSignIn() => CW.commonTextButton(
      onPressed: () => controller.clickOnSignInButton(),
      contentPadding: EdgeInsets.zero,
      child: textViewSignIn());

  Widget textViewSignIn() => Text(
        C.textSignIn,
        style: Theme.of(Get.context!)
            .textTheme
            .titleLarge
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.darkGreen),
      );
}
