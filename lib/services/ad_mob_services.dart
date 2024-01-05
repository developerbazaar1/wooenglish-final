import 'dart:io';

class AdHelper {

       static String get bannerAdUnitId {
              if (Platform.isAndroid) {
                     return 'ca-app-pub-4361045577652525/4763241082';
              } else if (Platform.isIOS) {
                     return 'ca-app-pub-4361045577652525/4763241082';
              } else {
                     throw UnsupportedError('Unsupported platform');
              }
       }

       static String get interstitialAdUnitId {
              if (Platform.isAndroid) {
                     return 'ca-app-pub-4361045577652525/2388714407';
              } else if (Platform.isIOS) {
                     return 'ca-app-pub-4361045577652525/2388714407';
              } else {
                     throw UnsupportedError('Unsupported platform');
              }
       }

       static String get rewardedAdUnitId {
              if (Platform.isAndroid) {
                     return 'ca-app-pub-3940256099942544/1033173712';
              } else if (Platform.isIOS) {
                     return 'ca-app-pub-4361045577652525~6707233361';
              } else {
                     throw UnsupportedError('Unsupported platform');
              }
       }
}