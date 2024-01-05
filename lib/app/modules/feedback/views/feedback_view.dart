import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/feedback_controller.dart';

// ignore: must_be_immutable
class FeedbackView extends GetView<FeedbackController> {
  String? tag;
  late FeedbackController controller;

   FeedbackView({super.key, Key? k, this.tag,}){
     controller = Get.find(tag: tag);
   }
  @override
  Widget build(BuildContext context) {
    return    Obx(
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
                            bottom: 17.px, left: C.margin, right: C.margin,top: 15.px),
                        children: [
                          Image.asset(
                            C.imageFeedBackScreen,
                            height: 305.px,
                            width: 350.px,
                          ),
                          SizedBox(
                            height: 25.px,
                          ),
                          Text(
                            C.textFeedBackDis,
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
                          textViewWriteUs(),
                          SizedBox(
                            height: 6.px,
                          ),
                          textFieldView(),
                          SizedBox(
                            height: 15.px,
                          ),
                          buttonViewSubmit()
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

  Widget appBarView() => CW.commonAppBarWithoutActon(
      onPressed: () => controller.clickOnBackButton(),
      title: C.textFeedBack);

  Widget textViewWriteUs() => Text(
    C.textWriteUs,
    style: CT.openSansTitleMedium(),
  );

  Widget textFieldView() => CW.commonTextFieldForWriteSomething(
      hintText: C.textWriteYourMessage,
      keyboardType: TextInputType.multiline,
      elevation: 0.3.px,
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
