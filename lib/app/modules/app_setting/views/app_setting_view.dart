import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/common/common_text_styles/common_text_styles.dart';
import 'package:woo_english/app/common/common_widget/common_widget.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/app_setting_controller.dart';

class AppSettingView extends GetView<AppSettingController> {
  const AppSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ModalProgress(
        inAsyncCall: controller.inAsyncCall.value,
        child: Scaffold(
          body: Column(
            children: [
              appBarView(),
              SizedBox(
                height: 17.px,
              ),
               Expanded(
                 child: ScrollConfiguration(
                   behavior: ListScrollBehaviour(),
                   child: CW.commonRefreshIndicator(
                     onRefresh: () => controller.onRefresh(),
                     child: ListView(
                       children: [
                         commonSwitchView(
                           title: C.textNotification,
                           subtitle: C.textNotificationDis,
                           changeValue: controller.notificationValue.value,
                           onChanged: (bool value) =>
                               controller.notificationOnChange(value: value),
                         ),
                         commonSwitchView(
                           title: C.textDarkMode,
                           subtitle: C.textDarkModeDis,
                           changeValue: controller.modeValue.value,
                           onChanged: (bool value) =>
                               controller.modeOnChange(value: value),
                         ),
                         commonSwitchView(
                           title: C.textApplicationUpdate,
                           subtitle: C.textApplicationUpdateDis,
                           changeValue: controller.applicationUpdateValue.value,
                           onChanged: (bool value) =>
                               controller.applicationUpdateOnChange(value: value),
                         ),
                       ],
                     ),
                   ),
                 ),
               )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBarView() => CW.commonAppBarWithoutActon(
      title: C.textAppSettings,
      onPressed: () => controller.clickOnBackButton());

  Widget commonSwitchView(
          {required String title,
          required String subtitle,
          required bool changeValue,
          required ValueChanged<bool>? onChanged}) =>
      Container(
        margin: EdgeInsets.only(left: C.margin,right: C.margin,bottom: C.margin),
        padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 8.px),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.px),
          border: Border.all(color: Col.borderColor, width: 3.px),
          color: Col.inverseSecondary,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textTitle(title: title),
/*
                  textSubtitle(subtitle: subtitle)
*/
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.px),
              child: CupertinoSwitch(
                value: changeValue,
                onChanged: onChanged,
                activeColor: Col.borderColor,
                thumbColor: changeValue ? Col.primary : Col.inverseSecondary,
                trackColor: Col.textGrayColor,
              ),
            )
          ],
        ),
      );

  Widget textTitle({required String title}) => Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CT.alegreyaDisplaySmall(),
      );

  Widget textSubtitle({required String subtitle}) => Text(
        subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(fontSize: 12.px, fontFamily: C.fontOpenSans),
      );
}
