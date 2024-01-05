import 'dart:io';

class AdMobHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9747725006209280/7603774496';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9747725006209280/7726229277';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9747725006209280/5353865734';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9747725006209280/3853081805';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

 /* static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return '<YOUR_ANDROID_REWARDED_AD_UNIT_ID>';
    } else if (Platform.isIOS) {
      return '<YOUR_IOS_REWARDED_AD_UNIT_ID>';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }*/
}