import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/common/common_method/common_method.dart';
import 'package:woo_english/app/modules/home/controllers/home_controller.dart';
import 'package:woo_english/app/modules/home/views/home_view.dart';
import 'package:woo_english/app/modules/my_books/controllers/my_books_controller.dart';
import 'package:woo_english/app/modules/my_books/views/my_books_view.dart';
import 'package:woo_english/app/modules/my_profile/controllers/my_profile_controller.dart';
import 'package:woo_english/app/modules/my_profile/views/my_profile_view.dart';
import 'package:woo_english/app/modules/search_screen/controllers/search_screen_controller.dart';
import 'package:woo_english/app/modules/search_screen/views/search_screen_view.dart';

final selectedViewIndex = 0.obs;

class NavigatorController extends AppController {
  final count = 0.obs;
  final inAsyncCall = false.obs;
  int h = 0;
  int s = 0;
  int b = 0;
  int p = 0;
  int load = 0;

  @override
  void onInit() {
    super.onInit();
    onReload();
    print("Getevhjjhc::::::::::::${Get.previousRoute}");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onReload() {
    connectivity.onConnectivityChanged.listen((event) async {
      if (await CM.internetConnectionCheckerMethod() && load == 0) {
        if (screens == Screens.home) {
          HomeController homeController = Get.find();
          await homeController.onInit();
        } else if (screens == Screens.search) {
          SearchScreenController searchScreenController = Get.find();
          await searchScreenController.onInit();
        } else if (screens == Screens.books) {
          MyBooksController myBooksController = Get.find();
          myBooksController.offset = 0;
          await myBooksController.onInit();
        } else if (screens == Screens.profile) {
          MyProfileController myProfileController = Get.find();
          await myProfileController.onInit();
        }
        load++;
      } else {
        load = 0;
      }
    });
  }

  void increment() => count.value++;

  Future<void> onViewChange({required int value}) async {
    CM.unFocsKeyBoard();
    inAsyncCall.value = true;
    selectedViewIndex.value = value;
    inAsyncCall.value = false;
  }

  Widget getBody() {
    increment();
    switch (selectedViewIndex.value) {
      case 0:
        screens = Screens.home;
        if (h != 0) {
          HomeController homeController = Get.find();
          homeController.onInit();
        }
        h++;
        return const HomeView();
      case 1:
        screens = Screens.search;
        if (s != 0) {
          SearchScreenController searchScreenController = Get.find();
          searchScreenController.onInit();
        }
        s++;
        return const SearchScreenView();
      case 2:
        screens = Screens.books;
        if (b != 0) {
          MyBooksController myBooksController = Get.find();
          myBooksController.offset = 0;
          myBooksController.onInit();
        }
        b++;
        return const MyBooksView();
      case 3:
        screens = Screens.profile;
        if (p != 0) {
          MyProfileController myProfileController = Get.find();
          myProfileController.onInit();
        }
        p++;
        return const MyProfileView();
      default:
        return const SizedBox();
    }
  }
}

enum Screens {
  home,
  search,
  books,
  profile,
  authorsList,
  authorDetail,
  booksList,
  editProfile,
  bookMark,
  reviews,
  allReviews,
  eBooks,
  favoriteBooks,
  finishedBooks,
  quizzes,
  appSettings,
  termsAndCondition,
  privacyPolicy,
  helpAndSupport,
  bookDetail,
  readAndListen,
  notifications, signIn, signUp, verification, videoScreen, feedBack, quizDetail
}
