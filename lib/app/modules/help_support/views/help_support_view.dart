import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../../../validator/validator.dart';
import '../controllers/help_support_controller.dart';

class HelpSupportView extends GetView<HelpSupportController> {
  const HelpSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: GestureDetector(
          onTap: () => CM.unFocsKeyBoard(),
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                appBarView(),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ListScrollBehaviour(),
                    child: ListView(
                        padding: EdgeInsets.only(
                            bottom: 17.px, left: C.margin, right: C.margin),
                        children: [
                          Image.asset(
                            C.imageHelpAndSupport,
                            height: 305.px,
                            width: 350.px,
                          ),
                          SizedBox(
                            height: 25.px,
                          ),
                          Text(
                            C.textHowCanWeHelpYou,
                            textAlign: TextAlign.center,
                            style: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: 20.px,
                                    fontFamily: C.fontOpenSans),
                          ),
                          SizedBox(
                            height: 20.px,
                          ),
                          commonView(
                              image: C.imagePhoneLogo, value: C.textUserNumber),
                          SizedBox(
                            height: 10.px,
                          ),
                          commonView(
                            image: C.imageMessageLogo,
                            value: C.textUserEmail,
                          ),

                          SizedBox(
                            height: 15.px,
                          ),
                          textViewEmailAddress(),

                          SizedBox(
                            height: 10.px,
                          ),
                          Form(
                              key: controller.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                            emailInputBox(),


                            SizedBox(
                              height: 10.px,
                            ),
                            textViewWriteUs(),
                            SizedBox(
                              height: 4.px,
                            ),
                            textFieldView(),
                            SizedBox(
                              height: 10.px,
                            ),
                            buttonViewSubmit()
                          ],)),

                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textViewEmailAddress() => Text(
    C.textEmail,
    style: CT.playfairBodySmall(),
  );
  Widget emailInputBox()=> CW.commonTextFieldForLoginSignUP(
      controller: controller.emailAddressController,
      hintText: C.textEnterEmailAddress,
      validator: (value) => Validator.isEmailValid(value: value),
      keyboardType: TextInputType.emailAddress);

    Widget appBarView() => CW.commonAppBarWithoutActon(
        onPressed: () => controller.clickOnBackButton(),
        title: C.textHelpAndSupport);

  Widget commonView({
    required String image,
    required String value,
  }) =>
      Row(
        children: [
          Container(
            height: 35.px,
            width: 35.px,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Col.cardBackgroundColor,
            ),
            child: Image.asset(
              image,
            ),
          ),
          SizedBox(
            width: 10.px,
          ),
          Text(
            value,
            style: CT.openSansBodyMedium(),
          ),
        ],
      );

  Widget textViewWriteUs() => Text(
        C.textWriteUs,
        style: CT.openSansTitleMedium(),
      );

  Widget textFieldView() => CW.commonTextFieldForWriteSomething(
      hintText: C.textWriteYourMessage,
      keyboardType: TextInputType.multiline,
      elevation: 0.3.px,
      validator: (value){
        if(value!.isEmpty && value==null){
          return 'Please write message';

        }
        return null;
      },
      hintStyle: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
          fontFamily: C.fontOpenSans,
          fontSize: 12.px,
          color: Col.textGrayColor),
      maxHeight: 150.px,
      controller: controller.writeSomethingController,
      wantBorder: false);

  Widget buttonViewSubmit() => CW.commonElevatedButton(
      onPressed: () => controller.clickOnSubmitButton(),
      child: textViewSubmit(),
      borderRadius: 5.px,
      buttonColor: Col.primaryColor,
      wantContentSizeButton: false);

  Widget textViewSubmit() => Text(
        C.textSubmit,
        style: CT.alegreyaDisplaySmall(),
      );

}
