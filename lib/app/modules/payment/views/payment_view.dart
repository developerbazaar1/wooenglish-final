

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
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: GestureDetector(
          onTap: () => CM.unFocsKeyBoard(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Form(
              key: controller.formKey,
              autovalidateMode: C.autoValidateMode,
              child: Column(
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
                          textViewCardDetails(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.px),
                            child: MySeparator(
                              height: 2.px,
                              color: Col.primary,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              commonView(
                                  image: C.imageVisaLogo,
                                  onTap: () => controller.clickOnVisaLogo()),
                              SizedBox(
                                width: 18.px,
                              ),
                              commonView(
                                  image: C.imagePayPalLogo,
                                  onTap: () => controller.clickOnPayPalLogo()),
                              SizedBox(
                                width: 18.px,
                              ),
                              commonView(
                                  image: C.imageMasterCardLogo,
                                  onTap: () => controller.clickOnMasterLogo()),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.px),
                            child: imageViewMasterCard(),
                          ),
                          textViewTitle(value: C.textNameONCard),
                          SizedBox(
                            height: 7.px,
                          ),
                          textFieldNameOnCard(),
                          SizedBox(
                            height: 12.px,
                          ),
                          textViewTitle(value: C.textCardNumber),
                          SizedBox(
                            height: 7.px,
                          ),
                          textFieldNumberOnCard(),
                          SizedBox(
                            height: 12.px,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textViewTitle(value: C.textExpiryDate),
                                    SizedBox(
                                      height: 7.px,
                                    ),
                                    textFieldExpiryDateOnCard(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 35.px,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    textViewTitle(value: C.textCVV),
                                    SizedBox(
                                      height: 7.px,
                                    ),
                                    textFieldCvvOnCard(),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25.px,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buttonViewPayment(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
        onPressed: () => controller.clickOnBackButton(),
        title: C.textPayment,
      );

  Widget textViewCardDetails() => Text(
        C.textCardDetails,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget commonView({required String image, required VoidCallback onTap}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.px),
        child: Ink(
          height: 35.px,
          width: 35.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.px),
            color: Col.borderColor,
          ),
          child: Padding(
              padding: EdgeInsets.all(4.px),
              child: Image.asset(
                image,
              )),
        ),
      );

  Widget imageViewMasterCard() => Image.asset(C.imageMasterCard);

  Widget textViewTitle({required String value}) => Text(
        value,
        style: CT.alegreyaBodySmall(),
      );

  Widget textFieldNameOnCard() => CW.commonTextFieldForLoginSignUP(
      hintText: C.textEnterCardHolderName,
      initialBorderColor: Col.borderColor,
      initialBorderWidth: 3.px,
      controller: controller.cardNameController,
      keyboardType: TextInputType.name,
      validator: (value) => Validator.isNameValid(value: value),
      hintStyle: Theme.of(Get.context!)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: C.fontOpenSans, color: Col.textGrayColor));

  Widget textFieldNumberOnCard() => CW.commonTextFieldForLoginSignUP(
      hintText: C.textEnterYourCardNumber,
      initialBorderColor: Col.borderColor,
      initialBorderWidth: 3.px,
      keyboardType: TextInputType.number,
      validator: (value) =>
          Validator.isValid(value: value, title: "card number"),
      controller: controller.cardNumberController,
      hintStyle: Theme.of(Get.context!)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: C.fontOpenSans, color: Col.textGrayColor));

  Widget textFieldExpiryDateOnCard() =>
      CW.commonTextFieldForLoginSignUP(
          hintText: C.textExpiryDate,
          validator: (value) =>
              Validator.isValid(value: value, title: "expiry date"),
          initialBorderColor: Col.borderColor,
          initialBorderWidth: 3.px,
          keyboardType: TextInputType.datetime,
          controller: controller.cardExpiryDateController,
          hintStyle: Theme.of(Get.context!)
              .textTheme
              .bodyMedium
              ?.copyWith(fontFamily: C.fontOpenSans, color: Col.textGrayColor));

  Widget textFieldCvvOnCard() => CW.commonTextFieldForLoginSignUP(
      hintText: C.textCVVCode,
      initialBorderColor: Col.borderColor,
      initialBorderWidth: 3.px,
      validator: (value) => Validator.isValid(value: value, title: "cvv"),
      keyboardType: TextInputType.datetime,
      onChanged: (value) {},
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: controller.cardCvvCodeController,
      hintStyle: Theme.of(Get.context!)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: C.fontOpenSans, color: Col.textGrayColor));

  Widget buttonViewPayment() => CW.commonElevatedButton(
        onPressed: () => controller.clickOnPaymentButton(),
        child: textViewPaymentButton(),
        buttonColor: Col.primaryColor,
        borderRadius: 15.px,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 22.px, vertical: 10.px),
      );

  Widget textViewPaymentButton() => Text(
        C.textPayment,
        style: CT.alegreyaHeadLineLarge(),
      );
}
