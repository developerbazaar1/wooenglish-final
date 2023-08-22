import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.count.value;
      return  Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body:  Center(
          child: Image.asset(C.imageWooEnglishAppLogo,height: 200.px,width: 200.px,),
        ),
      );
    });
  }
}
