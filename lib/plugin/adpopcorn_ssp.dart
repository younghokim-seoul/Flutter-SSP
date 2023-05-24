import 'package:ssp_sapme/plugin/adpopcorn_ssp_platform.dart';

class AdPopcornSSP {
  static Future<void> setOnAdInit(NoArgumentListener listener) async {
    return AdPopcornSSPPlatform.instance.setOnAdInit(listener);
  }

  static Future<void> loadPopupAd({
    NoArgumentListener? onLoadPopupAdSuccess,
    PopupAdErrorListener? onLoadPopupAdFailure,
    NoArgumentListener? onShowPopupAdSuccess,
    PopupAdErrorListener? onShowPopupAdFailure,
    NoArgumentListener? onPopupAdClose,
  }) async {
    return AdPopcornSSPPlatform.instance.loadPopupAd(
      onLoadPopupAdSuccess: onLoadPopupAdSuccess,
      onLoadPopupAdFailure: onLoadPopupAdFailure,
      onShowPopupAdSuccess: onShowPopupAdSuccess,
      onShowPopupAdFailure: onShowPopupAdFailure,
      onPopupAdClose: onPopupAdClose,
    );
  }

  static Future<void> apRewardVideoAd({
    NoArgumentListener? onRewardVideoAdLoaded,
    PopupAdErrorListener? onRewardVideoAdLoadFailed,
    NoArgumentListener? onRewardVideoAdOpened,
    NoArgumentListener? onRewardVideoAdOpenFalied,
    NoArgumentListener? onRewardVideoAdClosed,
    NoArgumentListener? onRewardVideoPlayCompleted,
    NoArgumentListener? onRewardVideoAdClicked,
  }) {
    return AdPopcornSSPPlatform.instance.apRewardVideoAd(
      onRewardVideoAdLoaded: onRewardVideoAdLoaded,
      onRewardVideoAdLoadFailed: onRewardVideoAdLoadFailed,
      onRewardVideoAdOpened: onRewardVideoAdOpened,
      onRewardVideoAdOpenFalied: onRewardVideoAdOpenFalied,
      onRewardVideoAdClosed: onRewardVideoAdClosed,
      onRewardVideoPlayCompleted: onRewardVideoPlayCompleted,
      onRewardVideoAdClicked: onRewardVideoAdClicked,
    );
  }

  static Future<void> showBannerAd() {
    return AdPopcornSSPPlatform.instance.showBannerAd();
  }

  static Future<void> stopBannerAd() {
    return AdPopcornSSPPlatform.instance.stopBannerAd();
  }

  static Future<void> interstitialAd() {
    return AdPopcornSSPPlatform.instance.interstitialAd();
  }

  static Future<void> apInterstitialVideoAd() {
    return AdPopcornSSPPlatform.instance.apInterstitialVideoAd();
  }
}
