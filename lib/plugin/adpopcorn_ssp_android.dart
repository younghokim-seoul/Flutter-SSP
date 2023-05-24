import 'package:flutter/services.dart';
import 'package:ssp_sapme/plugin/adpopcorn_ssp_platform.dart';

const channelName = 'adpopcorn_flutter_sdk';

class AdPopcornSSPAndroid extends AdPopcornSSPPlatform {
  final noArgListeners = <String, NoArgumentListener?>{};
  final popupAdErrorListeners = <String, PopupAdErrorListener?>{};

  AdPopcornSSPAndroid() {
    methodChannel.setMethodCallHandler(handleMethodCall);
  }

  Future<void> handleMethodCall(MethodCall call) async {
    NoArgumentListener? noArgListener = noArgListeners[call.method];
    if (noArgListener != null) {
      return noArgListener();
    }

    PopupAdErrorListener? popupAdErrorListener =
        popupAdErrorListeners[call.method];
    if (popupAdErrorListener != null) {
      return popupAdErrorListener(
        call.arguments['errorCode'],
        call.arguments['errorMessage'],
      );
    }
  }

  @override
  Future<void> setOnAdInit(NoArgumentListener listener) async {
    noArgListeners['onInitialized'] = listener;
  }

  @override
  Future<void> loadPopupAd({
    NoArgumentListener? onLoadPopupAdSuccess,
    PopupAdErrorListener? onLoadPopupAdFailure,
    NoArgumentListener? onShowPopupAdSuccess,
    PopupAdErrorListener? onShowPopupAdFailure,
    NoArgumentListener? onPopupAdClose,
  }) async {
    noArgListeners['onLoadPopupAdSuccess'] = onLoadPopupAdSuccess;
    noArgListeners['onShowPopupAdSuccess'] = onShowPopupAdSuccess;
    noArgListeners['onPopupAdClose'] = onPopupAdClose;
    popupAdErrorListeners['onLoadPopupAdFailure'] = onLoadPopupAdFailure;
    popupAdErrorListeners['onShowPopupAdFailure'] = onShowPopupAdFailure;
    return await invokeMethodAndHandleException('loadPopupAd');
  }

  @override
  Future<void> apInterstitialVideoAd() async {
    return await invokeMethodAndHandleException('apInterstitialVideoAd');
  }

  @override
  Future<void> apRewardVideoAd({
    NoArgumentListener? onRewardVideoAdLoaded,
    PopupAdErrorListener? onRewardVideoAdLoadFailed,
    NoArgumentListener? onRewardVideoAdOpened,
    NoArgumentListener? onRewardVideoAdOpenFalied,
    NoArgumentListener? onRewardVideoAdClosed,
    NoArgumentListener? onRewardVideoPlayCompleted,
    NoArgumentListener? onRewardVideoAdClicked,
  }) async {
    noArgListeners['onRewardVideoAdLoaded'] = onRewardVideoAdLoaded;
    popupAdErrorListeners['onRewardVideoAdLoadFailed'] =
        onRewardVideoAdLoadFailed;
    noArgListeners['onRewardVideoAdOpened'] = onRewardVideoAdOpened;
    noArgListeners['onRewardVideoAdOpenFalied'] = onRewardVideoAdOpenFalied;
    noArgListeners['onRewardVideoAdClosed'] = onRewardVideoAdClosed;
    noArgListeners['onRewardVideoPlayCompleted'] = onRewardVideoPlayCompleted;
    noArgListeners['onRewardVideoAdClicked'] = onRewardVideoAdClicked;

    return await invokeMethodAndHandleException('apRewardVideoAd');
  }

  @override
  Future<void> showBannerAd() async {
    return await invokeMethodAndHandleException2(
        'showBannerAd', {"optType": "show"});
  }

  @override
  Future<void> stopBannerAd() async {
    return await invokeMethodAndHandleException2(
        'stopBannerAd', {"optType": "stop"});
  }

  @override
  Future<void> interstitialAd() async {
    return await invokeMethodAndHandleException('interstitialAd');
  }
}
