import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/http_methods/http_methods.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:http/http.dart' as http;

import '../../splash/controllers/splash_controller.dart';
class MyProfileController extends AppController {
  final count = 0.obs;
  final inAsyncCall=false.obs;
  final  isMamber = false.obs;

  var _key;

  List<String> listOfTitles = [
    C.textMyPlan,
    C.textMyBookMark,
    C.textMyReview,
    C.textMyeBooks,
    C.textMyFavorites,
    C.textMyFinishedBooks,
    C.textMyQuizzes,
    C.textAppSettings,
    C.textTermAndCondition,
    C.textPrivacyPolicy,
    C.textHelpAndSupport,
  ];
  String? userProfilePicture="";
  String? userName="";
  String? userOnGoingCount="";
  String? userOnCompleteCount="";
  String? userOnMyCollectionCount="";


  @override
  Future<void> onInit() async {
    super.onInit();


    if(isUserSubscribed==true)
    {
      isMamber.value= true;
    }else{
      isMamber.value= false;
    }
    inAsyncCall.value=true;
    isMamber.value = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnStatus) ==
        "active";
    userProfilePicture=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnUserImage);
    userName=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnName);
    userOnGoingCount=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnOnGoing);
    userOnCompleteCount=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnCompleteBook);
    userOnMyCollectionCount=await DatabaseHelper.databaseHelperInstance.getParticularData(key: DatabaseConst.columnMyCollection);
    inAsyncCall.value=false;

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  Future<void> onRefresh() async {
    await onInit();
  }

  void increment() => count.value++;

  Future<bool> logOutApiCalling() async {

    http.Response? response = await HttpMethod.instance.postRequest(
        url: UriConstant.endPointLogOut, bodyParams: {},);
    if (CM.responseCheckForPostMethod(response: response)) {
      return true;
    } else {
      return false;
    }
  }


  Future<void> clickOnEditProfileButton() async {
    inAsyncCall.value = true;
    await Get.toNamed(Routes.EDIT_PROFILE);
    await onInit();
    inAsyncCall.value = false;
  }

  void clickOnParticularItem({required int index}) {
    inAsyncCall.value = true;
    if (index == 0) {
      Get.toNamed(Routes.MY_PLAN);

    }else if (index == 1) {
      Get.toNamed(Routes.BOOK_MARKS);
    } else if (index == 2) {
      Get.toNamed(Routes.REVIEWS);
    } else if (index == 3) {
      Get.toNamed(Routes.E_BOOK);
    } else if (index == 4) {
      Get.toNamed(Routes.FAVORITES_BOOKS);
    } else if (index ==5) {
      Get.toNamed(Routes.FINISHED_BOOKS);
    } else if (index == 6) {
      Get.toNamed(Routes.QUIZZES);
    } else if (index == 7) {
      Get.toNamed(Routes.APP_SETTING);
    } else if (index == 8) {
      Get.toNamed(Routes.TERMS_CONDITION);
    } else if (index == 9) {
      Get.toNamed(Routes.PRIVACY_POLICY);
    } else if (index == 10) {
      Get.toNamed(Routes.HELP_SUPPORT);
    }
    inAsyncCall.value = false;
  }

  void clickOnGetPremium() {
    inAsyncCall.value = true;

    Get.toNamed(Routes.SUBSCRIPTION);

    inAsyncCall.value = false;
  }
  void _deletetoken() async {
    print('running');
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.remove('subscribe');

      _key = key;

    print('YOUR KEY - "$key"');
    print('key deleted');
  }

  Future<void> clickOnLogOutButton() async {
    inAsyncCall.value = true;
    try{
      if(await logOutApiCalling())
      {

        _deletetoken();
        await DatabaseHelper.databaseHelperInstance.update(db: DatabaseHelper.db, data: CM.insertDataInModel());
        await Get.offAllNamed(Routes.SIGN_IN);
        selectedViewIndex.value = 0;


      }
    }catch (e) {
      CM.error();
      inAsyncCall.value = false;
    }

    inAsyncCall.value = false;
  }
}
