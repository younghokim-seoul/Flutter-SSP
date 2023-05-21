

import 'package:ssp_sapme/plugin/adpopcorn_ssp_platform.dart';

class AdPopcornSSP {
  static Future<void> setAppKeyAndHashKey(String appKey, String hashKey) async {
    return AdPopcornSSPPlatform.instance
        .setAppKeyAndHashKey(appKey, hashKey);
  }

  static Future<void> useIgaworksRewardServer(bool flag) async {
    return AdPopcornSSPPlatform.instance.useIgaworksRewardServer(flag);
  }

  static Future<void> setLogLevel(AdPopcornLogLevel level) async {
    return AdPopcornSSPPlatform.instance.setLogLevel(level);
  }

  static Future<void> setUserId(String userId) async {
    return AdPopcornSSPPlatform.instance.setUserId(userId);
  }

  static Future<void> openOfferWall() async {
    return AdPopcornSSPPlatform.instance.openOfferWall();
  }

  static Future<void> setOnAgreePrivacy(NoArgumentListener listener) async {
    return AdPopcornSSPPlatform.instance.setOnAgreePrivacy(listener);
  }

  static Future<void> setOnDisagreePrivacy(NoArgumentListener listener) async {
    return AdPopcornSSPPlatform.instance.setOnDisagreePrivacy(listener);
  }

  static Future<void> setOnClosedOfferWallPage(
      NoArgumentListener listener) async {
    return AdPopcornSSPPlatform.instance
        .setOnClosedOfferWallPage(listener);
  }

  static Future<void> setOnWillOpenOfferWall(NoArgumentListener listener) {
    return AdPopcornSSPPlatform.instance.setOnWillOpenOfferWall(listener);
  }

  static Future<void> setOnDidOpenOfferWall(NoArgumentListener listener) {
    return AdPopcornSSPPlatform.instance.setOnDidOpenOfferWall(listener);
  }

  static Future<void> setOnWillCloseOfferWall(NoArgumentListener listener) {
    return AdPopcornSSPPlatform.instance
        .setOnWillCloseOfferWall(listener);
  }

  static Future<void> setOnDidCloseOfferWall(NoArgumentListener listener) {
    return AdPopcornSSPPlatform.instance.setOnDidCloseOfferWall(listener);
  }

  static Future<void> useFlagShowWhenLocked(bool flag) async {
    return AdPopcornSSPPlatform.instance.useFlagShowWhenLocked(flag);
  }

  static Future<void> openCSPage(String userId) async {
    return AdPopcornSSPPlatform.instance.openCSPage(userId);
  }

  static Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) async {
    return AdPopcornSSPPlatform.instance
        .getEarnableTotalRewardInfo(callback);
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

  static Future<void> showPopupAd() {
    return AdPopcornSSPPlatform.instance.showPopupAd();
  }

  static Future<void> showBannerAd() {
    return AdPopcornSSPPlatform.instance.showBannerAd();
  }
  static Future<void> stopBannerAd() {
    return AdPopcornSSPPlatform.instance.stopBannerAd();
  }
}
