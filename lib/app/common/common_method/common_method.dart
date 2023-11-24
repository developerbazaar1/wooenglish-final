import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/user_data_model.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/app/theme/constants/constants.dart';

class CM {
  ///  flutter pub add internet_connection_checker -- For Check Internet
  static Future<bool> internetConnectionCheckerMethod() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }

  ///  flutter pub add fluttertoast --FGor Show Toast
  static void showToast(
    String msg, {
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }

  /// FOR UNFOCS KEYBOARD
  static void unFocsKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// FOR GET DEVICE TYPE
  static String getDeviceType() {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "IOS";
    } else {
      return "";
    }
  }

  ///FOR SHOW SNACKBAR required flutter pub add responsive_sizer
  static void showSnackBar({required String message, Duration? duration}) {
    var snackBar = SnackBar(
      elevation: .4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.px)),
      content: Text(
        message,
        style: TextStyle(
            color: Col.secondary,
            fontSize: 14.px,
            fontFamily: C.fontOpenSans,
            fontWeight: FontWeight.w600),
      ),
      backgroundColor: Col.inverseSecondary,
      margin: EdgeInsets.symmetric(horizontal: 24.px, vertical: 24.px),
      behavior: SnackBarBehavior.floating,
      duration: duration ?? const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  ///flutter pub add shared_preferences --For Local DataBase
  static Future<String?> getString({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  ///flutter pub add shared_preferences --For Local DataBase
  static Future<bool> setString(
      {required String key, required String value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(key, value);
  }

  ///flutter pub add intl --FOR DateFormat
  static String dateTimeToAgo(String dateTime) {
    DateTime input = DateTime.parse(dateTime);
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return diff.inDays < 7
          ? '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago'
          : DateFormat('MMM d').format(input);
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
    } else {
      return 'just now';
    }
  }

  static void noInternet() {
    showToast(
      "Please check your internet connection!",
    );
  }

  static void error() {
    showToast(
      "Something went wrong!",
    );
  }

  ///For Get Device Size Expect Tool Bar Or Bottom
  static double getDeviceSize() {
    double availableHeight = MediaQuery.of(Get.context!).size.height -
        MediaQuery.of(Get.context!).padding.top -
        MediaQuery.of(Get.context!).padding.bottom;
    return availableHeight;
  }

  static Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // UNIQUE ID ON iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // UNIQUE ID ON ANDROID
    }
    return null;
  }

  ///For Get App Bar Size
  static double getAppBarSize() {
    return AppBar().preferredSize.height;
  }

  ///For Get Tool Bar Size
  static double getToolBarSize() {
    return MediaQuery.of(Get.context!).padding.top;
  }

  ///For Get Six Digit Random Number
  static String getRandomNumber() {
    var random = Random();
    int min = 100000;
    int max = 999999;
    var number = min + random.nextInt(max - min);
    return number.toString();
  }

  ///For Check Post Api Response
  static bool responseCheckForPostMethod({http.Response? response}) {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (response != null && response.statusCode == StatusCodeConstant.OK) {
      CM.showToast(responseMap[ApiKey.message]);
      return true;
    } else {
      CM.showToast(responseMap[ApiKey.message]);
      return false;
    }
  }

  ///For Check Get Api Response
  static bool responseCheckForGetMethod(
      {http.Response? response,
      bool wantSuccessToast = false,
      bool wantErrorToast = true}) {
    Map<String, dynamic> responseMap = jsonDecode(response?.body ?? "");
    if (response != null && response.statusCode == StatusCodeConstant.OK) {
      if (wantSuccessToast) {
        CM.showToast(responseMap[ApiKey.message]);
      }
      return true;
    } else {
      if (wantErrorToast) {
        CM.showToast(responseMap[ApiKey.message]);
      }
      return false;
    }
  }

  static Future<void> setScreenPortraitMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  ///For Insert Api Data Into UserLocal
  static Map<String, dynamic> insertDataInModel({UserData? userData}) {
    UserLocalData userLocalData = UserLocalData();
    userLocalData.columnId = userData?.user?.id.toString() ?? "";
    userLocalData.columnName = userData?.user?.name.toString() ?? "";
    userLocalData.columnEmail = userData?.user?.email.toString() ?? "";
    userLocalData.columnMobile = userData?.user?.mobile.toString() ?? "";
    userLocalData.columnUserImage = userData?.user?.userImage.toString() ?? "";
    userLocalData.columnEmailVerifyAt =
        userData?.user?.emailVerifiedAt.toString() ?? "";
    userLocalData.columnUserRole = userData?.user?.userRole.toString() ?? "";
    userLocalData.columnStatus = userData?.user?.status.toString() ?? "";
    userLocalData.columnUserId = userData?.user?.userId.toString() ?? "";
    userLocalData.columnMembershipPlan =
        userData?.user?.membershipPlan.toString() ?? "";
    userLocalData.columnMembershipDate =
        userData?.user?.membershipDate.toString() ?? "";
    userLocalData.columnIp = userData?.user?.ip.toString() ?? "";
    userLocalData.columnDeviceType =
        userData?.user?.deviceType.toString() ?? "";
    userLocalData.columnCreatedAt = userData?.user?.createdAt.toString() ?? "";
    userLocalData.columnUpdatedAt = userData?.user?.updatedAt.toString() ?? "";
    userLocalData.columnToken = userData?.token.toString().toString() ?? "";
    userLocalData.columnMyCollection =
        userData?.bookcount?.myCollection.toString() ?? "";
    userLocalData.columnCompleteBook =
        userData?.bookcount?.completedbook.toString() ?? "";
    userLocalData.columnOnGoing = userData?.bookcount?.ongoing.toString() ?? "";
    userLocalData.columnNotificationOnOff =
        userData?.user?.notificationOnOff.toString() ?? "";
    userLocalData.columnAppUpdateOnOff =
        userData?.user?.appUpdateOnOff.toString() ?? "";

    userLocalData.columnMode = userData?.user?.mode.toString() ?? "";
    userLocalData.columnCountryCode =
        userData?.user?.countryCode.toString() ?? "";
    return userLocalData.toMap();
  }

  ///For Insert Data In DataBase
  static Future<bool> insertDataIntoDataBase({UserData? userData}) async {
    DatabaseHelper.db = await DatabaseHelper.databaseHelperInstance.openDB();
    if (await DatabaseHelper.databaseHelperInstance
        .isDatabaseHaveData(db: DatabaseHelper.db)) {
      bool isInsert = await DatabaseHelper.databaseHelperInstance.insert(
        db: DatabaseHelper.db,
        data: CM.insertDataInModel(userData: userData),
      );
      return isInsert;
    } else {
      await DatabaseHelper.databaseHelperInstance.update(
          db: DatabaseHelper.db,
          data: CM.insertDataInModel(userData: userData));
      return true;
    }
  }

  ///For Get Image Url
  static String getImageUrl({required String value}) {
    return "${UriConstant.baseUrl}public/$value";
  }

  ///FOR Remove html tag from text
  static String parseHtmlString(String htmlString) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String value = htmlString.replaceAll(exp, '');
    value = value.replaceAll("&nbsp;", "");
    value = value.replaceAll("&rdquo;", "");
    value = value.replaceAll("&ldquo;", "");
    value = value.replaceAll("&lsquo;", "");
    return value.replaceAll("&rsquo;", "");
  }

  ///For Check Response
/* static Future<bool> checkResponse({
    required http.Response response,
  }) async {
    Map<String, dynamic> responseMap = jsonDecode(response.body);
    if (await CM.internetConnectionCheckerMethod()) {
      if (response.statusCode == StatusCodeConstant.OK) {
        CM.showSnackBar(
            message: responseMap[],
            );
        return true;
      } else if (response.statusCode == StatusCodeConstant.BAD_REQUEST) {
        CM.showSnackBar(
            message: responseMap[ApiKeyConstant.message],
            );
        return false;
      } else if (response.statusCode == StatusCodeConstant.BAD_GATEWAY) {
        CM.showSnackBar(
            message: "Server Down", );
        return false;
      } else if (response.statusCode == StatusCodeConstant.REQUEST_TIMEOUT) {
        CM.showSnackBar(
            message: "Server Down", );
        return false;
      } else {
        CM.showSnackBar(
            message: "Server Down", );
        return false;
      }
    } else {
      CM.showSnackBar(
          message: "Check Your Internet Connection",
          duration: const Duration(seconds: 4));
      return false;
    }
  }*/

/*  flutter pub add device_info_plus  --FOR GET DEVICE ID


    flutter pub add flutter_windowmanager --ONlY FOR ANDROID SECURE FROM SCREEN SHOTS
  static secureFromScreenShot() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }*/
}

/* For Scroll Behaviour*/
class ListScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
