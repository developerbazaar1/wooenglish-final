import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/firebase/firebase_login_method.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  String token = "";
  String isUserLogin = "";
  @override
  Future<void> onInit() async {
    super.onInit();
    await DatabaseHelper.databaseHelperInstance.openDB();

    isUserLogin = await DatabaseHelper.databaseHelperInstance.getParticularData(
        key: DatabaseConst.columIsLogIn,
        tableName: DatabaseConst.tableNameUserLogin);

    token = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnToken);
    await Future.delayed(const Duration(seconds: 2));
    await manageSession();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> manageSession() async {
    if (isUserLogin.isEmpty) {
      await Get.offAllNamed(Routes.ON_BOARDING);
    } else {
      if (token.isNotEmpty) {
        if(!await FirebaseMethod.instance.getDynamicLink()) {
          await Get.offAllNamed(Routes.NAVIGATOR);
        }
      } else {
        await Get.offNamed(Routes.SIGN_IN);
      }
    }
  }
}
