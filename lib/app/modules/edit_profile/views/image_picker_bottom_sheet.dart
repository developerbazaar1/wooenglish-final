import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class ImagePickerBottomSheet extends GetView<EditProfileController> {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ListScrollBehaviour(),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: C.margin,
        ),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.px, bottom: 10.px),
            child: Ink(
              decoration: BoxDecoration(
                color: Col.inverseSecondary,
                borderRadius: BorderRadius.circular(20.px),
                border: Border.all(color: Col.darkGrayColor, width: 2.px),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.px),
                    child: textViewSelectImage(),
                  ),
                  dividerView(),
                  commonView(
                      onTap: () => controller.clickOnTakePhoto(),
                      title: C.textTakePhoto),
                  dividerView(),
                  commonView(
                      onTap: () => controller.clickOnChooseFromLibrary(),
                      title: C.textChooseFromLibrary),
                  dividerView(),
                  commonView(
                      onTap: () => controller.clickOnRemovePhoto(),
                      title: C.textRemovePhoto),
                  SizedBox(
                    height: 10.px,
                  ),
                ],
              ),
            ),
          ),
          buttonViewCancel(),
          SizedBox(
            height: 20.px,
          )
        ],
      ),
    );
  }

  Widget textViewSelectImage() => Text(
        C.textSelectImage,
        style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
              fontFamily: C.fontOpenSans,
              color: const Color(0xff717171),
            ),
      );

  Widget dividerView() => Divider(
        height: 0.px,
        thickness: 2.px,
        color: Col.onSecondary,
        indent: 10.px,
        endIndent: 10.px,
      );

  Widget commonView({required VoidCallback onTap, required String title}) =>
      InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10.px),
                child: textViewTitle(title: title)),
          ],
        ),
      );

  Widget textViewTitle({required String title}) => Text(
        title,
        style: CT.openSansBodyMedium(),
      );

  Widget buttonViewCancel() => InkWell(
        onTap: () => controller.clickOnCancel(),
        borderRadius: BorderRadius.circular(25.px),
        child: Ink(
          decoration: BoxDecoration(
            color: Col.inverseSecondary,
            borderRadius: BorderRadius.circular(25.px),
            border: Border.all(color: Col.darkGrayColor, width: 2.px),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.px),
            child: Center(child: textViewCancel()),
          ),
        ),
      );

  Widget textViewCancel() => Text(
        C.textCancel,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium
            ?.copyWith(fontFamily: C.fontOpenSans, color: Col.primary),
      );
}
