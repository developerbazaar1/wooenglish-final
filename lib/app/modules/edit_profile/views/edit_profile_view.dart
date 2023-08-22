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

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);

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
                        padding: EdgeInsets.only(
                            top: 35.px,
                            left: C.margin,
                            right: C.margin,
                            bottom: C.margin + C.margin),
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 86.px,
                                width: 86.px,
                                child: Stack(
                                  children: [
                                    Obx(
                                      () => Container(
                                        height: 86.px,
                                        width: 86.px,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.px),
                                          image: DecorationImage(
                                            image: imageViewUserProfile(),
                                            fit: BoxFit.cover,
                                          ),
                                          border: Border.all(
                                              width: 5.px,
                                              color: Col.borderColor),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: 23.px,
                                        width: 23.px,
                                        margin: EdgeInsets.only(top: C.margin),
                                        decoration: BoxDecoration(
                                          color: Col.cardBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(15.px),
                                        ),
                                        child: InkWell(
                                          onTap: () =>
                                              controller.clickOnEditImage(),
                                          child: Padding(
                                            padding: EdgeInsets.all(3.px),
                                            child: imageViewEditImage(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 33.px,
                          ),
                          textViewTitle(value: C.textEnterName),
                          SizedBox(
                            height: 10.px,
                          ),
                          textFiledViewName(),
                          SizedBox(
                            height: 25.px,
                          ),
                          textViewTitle(value: C.textEnterPhoneNumber),
                          SizedBox(
                            height: 10.px,
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
                                  child: textFiledViewNumber()),
                            ],
                          ),
                          SizedBox(
                            height: 25.px,
                          ),
                          textViewTitle(value: C.textEnterEmailAddress),
                          SizedBox(
                            height: 10.px,
                          ),
                          textFiledViewEmail(),
                          SizedBox(
                            height: 150.px,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buttonViewUpdateProfile(),
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
        title: C.textEditProfile,
      );

  ImageProvider imageViewUserProfile() {
    if (controller.image.value != null) {
      return FileImage(
        controller.image.value!,
      );
    } else if (controller.userProfile != null &&
        controller.userProfile != "null" &&
        controller.userProfile!.isNotEmpty) {
      return NetworkImage(
        CM.getImageUrl(value: controller.userProfile ?? ""),

      );
    } else {
      return const AssetImage(
        C.imageUserProfile,
      );
    }
  }

  Widget imageViewEditImage() => Image.asset(C.imageChangeImageLogo);

  Widget textViewTitle({required String value}) => Text(
        value,
        style: CT.openSansBodyMedium(),
      );

  Widget textFiledViewName() => CW.commonTextFieldForLoginSignUP(
        borderRadius: 25.px,
        hintText: C.textUserName,
        controller: controller.nameController,
        keyboardType: TextInputType.name,
        validator: (value) => Validator.isNameValid(value: value),
      );

  Widget textFieldCountryCode() => CW.commonTextFieldForLoginSignUP(
    controller: controller.countryCodeController,
    hintText: C.textDefaultCountryCode,
    keyboardType: TextInputType.text,
    readOnly: true,
    wantBorder: false,
    contentPadding: EdgeInsets.symmetric(horizontal: 5.px),
    onTap: () =>controller.clickOnCountryCode(),
    maxHeight: 52.px,
    borderRadius: 25.px,
    onChanged: (value) {},
  );
  Widget textFiledViewNumber() => CW.commonTextFieldForLoginSignUP(
        borderRadius: 25.px,
        hintText: C.textUserNumber,
        controller: controller.mobileController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {},
        validator: (value) => Validator.isValid(value: value,title: 'Number'),
      );

  Widget textFiledViewEmail() => CW.commonTextFieldForLoginSignUP(
        borderRadius: 25.px,
        hintText: C.textUserEmail,
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => Validator.isEmailValid(value: value),
      );

  Widget buttonViewUpdateProfile() => CW.commonElevatedButton(
      onPressed: () => controller.clickOnUpdateProfile(),
      child: textViewUpdateProfile(),
      buttonColor: Col.primaryColor,
      borderRadius: 15.px,
      contentPadding: EdgeInsets.symmetric(horizontal: 22.px, vertical: 10.px));

  Widget textViewUpdateProfile() => Text(
        C.textUpdateProfile,
        style: CT.alegreyaHeadLineLarge(),
      );
}
