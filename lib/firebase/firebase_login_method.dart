import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_plus/share_plus.dart';
import 'package:woo_english/app/app_controller/app_controller.dart';
import 'package:woo_english/app/modules/book_detail/controllers/book_detail_controller.dart';
import 'package:woo_english/app/modules/book_detail/views/book_detail_view.dart';
import 'package:woo_english/app/modules/read_book/controllers/read_book_controller.dart';
import 'package:woo_english/app/modules/read_book/views/read_book_view.dart';
import 'package:woo_english/app/modules/video_book/controllers/video_book_controller.dart';
import 'package:woo_english/app/modules/video_book/views/video_book_view.dart';
import 'package:woo_english/app/routes/app_pages.dart';
import 'package:woo_english/app/theme/constants/constants.dart';
import 'package:woo_english/firebase/firebase_user_model.dart';
import '../app/common/common_method/common_method.dart';

class FirebaseMethod {
  static final FirebaseMethod instance = FirebaseMethod._();

  FirebaseMethod._();

  Future<String?> fcmIdRequest() async {
    if (await CM.internetConnectionCheckerMethod()) {
      String? fcmId = await FirebaseMessaging.instance.getToken();
      return fcmId;
    } else {
      CM.noInternet();
      return null;
    }
  }

  Future<FirebaseUser?> googleSignInRequest() async {
    FirebaseUser? firebaseUser;
    if (await CM.internetConnectionCheckerMethod()) {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User? user;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          final UserCredential userCredential =
              await firebaseAuth.signInWithCredential(authCredential);
          String? fcmId = await FirebaseMessaging.instance.getToken();
          user = userCredential.user;
          firebaseUser = FirebaseUser(
            uid: user?.uid,
            fcmId: fcmId,
            refreshToken: user?.refreshToken,
            displayName: user?.displayName,
            email: user?.email,
            phoneNumber: user?.phoneNumber,
            photoURL: user?.photoURL,
          );
          return firebaseUser;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            CM.error();
            return null;
          } else if (e.code == 'invalid-credential') {
            CM.error();
            return null;
          } else {
            CM.error();
            return null;
          }
        } catch (e) {
          CM.error();
          return null;
        }
      } else {
        return null;
      }
    } else {
      CM.noInternet();
      return null;
    }
  }

  Future<FirebaseUser?> facebookSigningRequest() async {
    FirebaseUser? firebaseUser;
    if (await CM.internetConnectionCheckerMethod()) {
      await FacebookAuth.instance.logOut();

      final LoginResult result = await FacebookAuth.instance.login(
        permissions: const ['email', 'public_profile'],
      );
      if (result.status == LoginStatus.success) {
        final userDataStore = await FacebookAuth.instance.getUserData();
          firebaseUser = FirebaseUser(
          displayName: userDataStore["name"],
          email: "email",
          photoURL: "picture.width(200)",
        );
        final AuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);
        FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
        return firebaseUser;
      } else {
        return null;
      }
    } else {
      CM.noInternet();
      return null;
    }
  }

  Future<void> sendOtpRequest(
      {required String number,PhoneCodeSent? codeSent}) async {

    String phoneNumber = number;

    void verificationCompleted(AuthCredential phoneAuthCredential) {}

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `milliseconds`
      timeout: const Duration(seconds: 20),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: (error) {
        CM.showToast("Please enter valid number!");
        print("phone number of firebase:::::::::::::::::::$phoneNumber");
        print("phone number of firebase:::::::::::::::::::$error");

      },

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent ?? (verificationId, forceResendingToken) {},

      /// After automatic code retrial `timeout` this function is called
      codeAutoRetrievalTimeout: (verificationId) {},
    );

  }

  Future<bool> verifyOtpRequest(
      {required String verificationId, required String smsCode}) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ));
    } catch (e) {
      CM.showToast("Please enter valid otp!");
      return false;
    }

    // ignore: unnecessary_null_comparison
    if (userCredential != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> shareDynamicLink({
    required String routes,
    String? bookId,
    String? authorId,
    String? categoryId,
    String? chapterId,
  }) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    ShortDynamicLink? shortLink;
    String link =
        "http://wooenglishapplication.page.link?${C.routes}=$routes&${C.bookId}=$bookId&${C.authorId}=$authorId&${C.categoryId}=$categoryId&${C.chapterId}=$chapterId";
    String uriPrefix = 'http://wooenglishapplication.page.link';
    String packageName = "app.woo.english.woo_english_application";
    String url =
        "https://play.google.com/store/apps/details?id=com.gameloft.android.ANMP.GloftA9HM&pcampaignid=merch_published_cluster_promotion_battlestar_featured_games";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: uriPrefix,
        link: Uri.parse(link),
        androidParameters: AndroidParameters(
          fallbackUrl: Uri.parse(url),
          packageName: packageName,
          minimumVersion: 1,
        ),
        iosParameters: const IOSParameters(
          bundleId: "app.woo.english.woo_english_application",
        ));
    shortLink = await dynamicLinks.buildShortLink(parameters);
    Share.share(
      "${shortLink.shortUrl}",
    );
  }

  Future<bool> getDynamicLink() async {
    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri? deepLink = data?.link;
    String routes = deepLink?.queryParameters[C.routes] ?? "";
    String authorId = deepLink?.queryParameters[C.authorId] ?? "";
    String bookId = deepLink?.queryParameters[C.bookId] ?? "";
    String categoryId = deepLink?.queryParameters[C.categoryId] ?? "";
    String chapterId = deepLink?.queryParameters[C.chapterId] ?? "";

    if (routes == C.authors) {
      AppController.routes = C.not;
      await Get.offAllNamed(Routes.AUTHOR, arguments: ["", authorId]);
      return true;
    } else if (routes == C.books) {
      AppController.routes = C.not;
      String tag = CM.getRandomNumber();
      Get.put(BookDetailController(), tag: tag);
      await Navigator.of(Get.context!).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BookDetailView(

            tag: tag,

            bookId: bookId,
            isLiked: false,
            categoryId: categoryId,
          ),
        ),
        (route) {
          return false;
        },
      );
      return true;
    } else if (routes == C.chapters) {
      AppController.routes = C.not;
      String tag = CM.getRandomNumber();
      Get.put(ReadBookController(), tag: tag);
      await Navigator.of(Get.context!).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => ReadBookView(
            tag: tag,
            isBookmark: false,
            bookId: bookId,
            chapterId: chapterId,
          ),
        ),
        (route) {
          return false;
        },
      );
      return true;
    } else if (routes == C.video) {
      AppController.routes = C.not;
      String tag = CM.getRandomNumber();
      Get.put(VideoBookController(), tag: tag);
      await Navigator.of(Get.context!).push(
        MaterialPageRoute(
          builder: (context) => VideoBookView(
            tag: tag,
            bookId: bookId,
            categoryId: categoryId,
            isLiked: false,
          ),
        ),
      );
      return true;
    } else {
      return false;
    }
  }
}
