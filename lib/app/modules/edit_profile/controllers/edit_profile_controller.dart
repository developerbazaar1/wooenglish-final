import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:woo_english/app/api/api_constant/api_constant.dart';
import 'package:woo_english/app/api/api_model/user_data_model.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_country_bottomsheet/common_country_bottomsheet.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/data/countries/countries_json_data.dart';
import 'package:woo_english/app/data/countries/get_countries_model.dart';
import 'package:woo_english/app/data/local_database/database_const/database_const.dart';
import 'package:woo_english/app/data/local_database/database_helper/database_helper.dart';
import 'package:woo_english/app/modules/edit_profile/views/image_picker_bottom_sheet.dart';
import 'package:woo_english/app/modules/navigator/controllers/navigator_controller.dart';
import 'package:woo_english/app/theme/colors/colors.dart';
import 'package:woo_english/custom_image_picker/custom_image_picker.dart';
import '../../../api/http_methods/http_methods.dart';

class EditProfileController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int load = 0;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final countryCodeController = TextEditingController();
  final image = Rxn<File?>();
  final countyLogo = "".obs;

  String? userProfile;
  String? userProfileCopy;
  String? userName = "";
  String? userMobileNumber = "";
  String? userEmailAddress = "";
  String countyCode = "";
  Map<String, dynamic> bodyParamsForEditProfile = {};
  UserData? getUserDataModel;
  GetCountriesModel? getCountriesModel;

  @override
  Future<void> onInit() async {
    super.onInit();
    screens = Screens.editProfile;
    inAsyncCall.value = true;
    String countriesJson = jsonEncode(countryData);
    countryCodeController.text = "+91";
    getCountriesModel = GetCountriesModel.fromJson(jsonDecode(countriesJson));

    getCountriesModel?.country?.forEach((element) {
      if (element.idd!.suffixes!.isNotEmpty) {
        if ("${element.idd!.root}${element.idd!.suffixes![0]}" ==
            countryCodeController.text) {
          countyLogo.value = element.flags?.png ?? "";
        }
      } else {
        if ("${element.idd!.root}" == countryCodeController.text) {
          countyLogo.value = element.flags?.png ?? "";
        }
      }
    });
    userProfile = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnUserImage);
    userProfileCopy = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnUserImage);
    userName = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnName);
    userMobileNumber = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnMobile);
    userEmailAddress = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnEmail);
    if (userName != null && userName!.isNotEmpty && userName != 'null') {
      nameController.text = userName ?? "";
    }
    if (userMobileNumber != null &&
        userMobileNumber!.isNotEmpty &&
        userMobileNumber != 'null') {
      mobileController.text = userMobileNumber ?? "";
    }

    if (userEmailAddress != null &&
        userEmailAddress!.isNotEmpty &&
        userEmailAddress != 'null') {
      emailController.text = userEmailAddress ?? "";
    }
    inAsyncCall.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void increment() => count.value++;

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod() &&
          load == 0 &&
          screens == Screens.editProfile) {
        load++;
        await onInit();
      } else {
        load = 0;
      }
    });
  }

  Future<bool> updateProfileApiCalling() async {
    String token = await DatabaseHelper.databaseHelperInstance
        .getParticularData(key: DatabaseConst.columnToken);
    bodyParamsForEditProfile = {
      ApiKey.name: nameController.text,
      ApiKey.documentOld: userProfile!="null"?userProfile:"",
      ApiKey.countryCode: countryCodeController.text,
    };
    http.Response? response = await HttpMethod.instance.updateMultipartRequest(
        url: UriConstant.endPointUpdateUserProfile,
        bodyParams: bodyParamsForEditProfile,
        multipartRequestType: 'POST',
        image: image.value,
        token: '${ApiKey.bearer} $token',
        imageKey: ApiKey.document);
    if (CM.responseCheckForPostMethod(response: response)) {
      bodyParamsForEditProfile.clear();
      return true;
    } else {
      bodyParamsForEditProfile.clear();
      return false;
    }
  }

  Future<bool> getUserDataApiCalling() async {
    http.Response? response = await HttpMethod.instance.getRequest(
      url: UriConstant.endPointGetUserData,
    );
    if (CM.responseCheckForGetMethod(response: response)) {
      getUserDataModel = UserData.fromJson(jsonDecode(response?.body ?? ""));
      await CM.insertDataIntoDataBase(userData: getUserDataModel);
      return true;
    } else {
      return false;
    }
  }

  void clickOnBackButton() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    Get.back();
    inAsyncCall.value = false;
  }

  void clickOnEditImage() {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    showModalBottomSheet(
        context: Get.context!,
        builder: (context) => const ImagePickerBottomSheet(),
        isDismissible: true,
        enableDrag: true,
        shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.px),
              topRight: Radius.circular(25.px)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent);
    inAsyncCall.value = false;
  }

  Future<void> clickOnUpdateProfile() async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    if (formKey.currentState!.validate()) {
      try {
        if (await updateProfileApiCalling()) {
          await getUserDataApiCalling();
          Get.back();
        }
      } catch (e) {
        CM.error();
        inAsyncCall.value = false;
      }
    }
    inAsyncCall.value = false;
  }

  Future<void> clickOnTakePhoto() async {
    Get.back();
    image.value = await IP.pickImage(wantCropper: true);
  }

  Future<void> clickOnChooseFromLibrary() async {
    Get.back();
    image.value =
        await IP.pickImage(wantCropper: true, pickImageFromGallery: true);
  }

  void clickOnRemovePhoto() {
    inAsyncCall.value = true;
    Get.back();
    image.value = null;
    userProfile = "";
    inAsyncCall.value = false;
  }

  void clickOnCancel() {
    Get.back();
  }

  void clickOnCountryCode() {
    showModalBottomSheet(
      context: Get.context!,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.px),
          topRight: Radius.circular(25.px),
        ),
      ),
      backgroundColor: Col.scaffoldBackgroundColor,
      builder: (context) {
        return CB(
          getCountriesModel: getCountriesModel,
          indexValue: (index) {
            Get.back();
            if (getCountriesModel!.country![index].idd!.suffixes!.isNotEmpty) {
              countryCodeController.text =
                  "${getCountriesModel!.country![index].idd!.root}${getCountriesModel!.country![index].idd!.suffixes![0]}";
            } else {
              countryCodeController.text =
                  "${getCountriesModel!.country![index].idd!.root}";
            }
            countyLogo.value =
                getCountriesModel!.country![index].flags?.png ?? "";
          },
        );
      },
    );
  }
}
