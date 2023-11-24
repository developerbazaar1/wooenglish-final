import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/model_progress_bar/model_progress_bar.dart';

import '../controllers/navigator_controller.dart';

class NavigatorView extends GetView<NavigatorController> {
  const NavigatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ModalProgress(
      inAsyncCall: controller.inAsyncCall.value,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottomNavigationBar: bottomBarView(context: context),
        body: controller.getBody(),
      ),
    ));
  }

  BottomNavigationBar bottomBarView({required BuildContext context}) {
    return BottomNavigationBar(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      currentIndex: selectedViewIndex.value,
      elevation: 10,


      unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
      type: BottomNavigationBarType.fixed,
      items: [
        dashboardView(),
        searchView(),
        myBooksView(),
        myProfileView(),
      ],
      onTap: (value) => controller.onViewChange(value: value),
    );
  }

  BottomNavigationBarItem dashboardView() {
    return BottomNavigationBarItem(
        icon: Image.asset(
          C.imageBottomBarHomeLogo,
          height: 22.px,
          width: 21.px,
          color: selectedViewIndex.value == 0 ? Col.primary : Col.secondary,
        ),
        label: C.textHome);
  }

  BottomNavigationBarItem searchView() {
    return BottomNavigationBarItem(
        icon: Image.asset(
          C.imageBottomBarSearchLogo,
          height: 30.px,
          width: 30.px,
          color: selectedViewIndex.value == 1 ? Col.primary : Col.secondary,
        ),
        label: C.textSearch);
  }

  BottomNavigationBarItem myBooksView() {
    return BottomNavigationBarItem(
        icon: Image.asset(
          C.imageBottomBarFavorite,
          height: 19.px,
          width: 23.px,
          color: selectedViewIndex.value == 2 ? Col.primary : Col.secondary,
        ),
        label: C.textMyBooks);
  }

  BottomNavigationBarItem myProfileView() {
    return BottomNavigationBarItem(
        icon: Image.asset(
          C.imageBottomBarUserLogo,
          height: 18.px,
          width: 19.px,
          color: selectedViewIndex.value == 3 ? Col.primary : Col.secondary,
        ),
        label: C.textMyProfile);
  }
}
