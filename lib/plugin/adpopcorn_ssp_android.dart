import 'package:flutter/services.dart';
import 'package:ssp_sapme/plugin/adpopcorn_ssp_platform.dart';

const channelName = 'adpopcorn_flutter_sdk';

class AdPopcornSSPAndroid extends AdPopcornSSPPlatform {

  final noArgListeners = <String, NoArgumentListener?>{};
  final popupAdErrorListeners = <String, PopupAdErrorListener?>{};
  OnGetEarnableTotalRewardInfo? onGetEarnableTotalRewardInfo;

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

    if (call.method == 'onGetEarnableTotalRewardInfo') {
      return onGetEarnableTotalRewardInfo!(
        call.arguments['queryResult'],
        call.arguments['totalCount'],
        call.arguments['totalReward'],
      );
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    return await invokeMethodAndHandleException('setUserId', {'userId': userId});
  }

  @override
  Future<void> openOfferWall() async {
    return await invokeMethodAndHandleException('openOfferWall');
  }

  @override
  Future<void> setOnAgreePrivacy(NoArgumentListener listener) async {
    noArgListeners['onAgreePrivacy'] = listener;
  }

  @override
  Future<void> setOnDisagreePrivacy(NoArgumentListener listener) async {
    noArgListeners['onDisagreePrivacy'] = listener;
  }

  @override
  Future<void> setOnClosedOfferWallPage(NoArgumentListener listener) async {
    noArgListeners['onClosedOfferWallPage'] = listener;
  }

  @override
  Future<void> useFlagShowWhenLocked(bool flag) async {
    return await invokeMethodAndHandleException('useFlagShowWhenLocked', {'flag': flag});
  }

  @override
  Future<void> openCSPage(String userId) async {
    return await invokeMethodAndHandleException('openCSPage', {'userId': userId});
  }

  @override
  Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) async {
    onGetEarnableTotalRewardInfo = callback;
    return await invokeMethodAndHandleException('getEarnableTotalRewardInfo');
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
  Future<void> showPopupAd() async {
    return await invokeMethodAndHandleException('showPopupAd');
  }

  @override
  Future<void> showBannerAd() async {
    return await invokeMethodAndHandleException2('showBannerAd',{"optType": "show"});
  }

  @override
  Future<void> stopBannerAd() async {
    return await invokeMethodAndHandleException2('stopBannerAd',{"optType": "stop"});
  }

}
