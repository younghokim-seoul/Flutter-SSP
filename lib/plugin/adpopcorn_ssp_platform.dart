import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:ssp_sapme/plugin/adpopcorn_ssp_android.dart';




typedef OnGetEarnableTotalRewardInfo = void Function(
    bool queryResult, int totalCount, String totalReward);
typedef NoArgumentListener = void Function();
typedef PopupAdErrorListener = void Function(
    int errorCode, String errorMessage);

const channelName = 'adpopcorn_flutter_sdk';

enum AdPopcornLogLevel {
  info,
  debug,
  trace,
}

abstract class AdPopcornSSPPlatform extends PlatformInterface {
  static final Object _token = Object();

  static final AdPopcornSSPPlatform instance = _instanceByPlatform();

  @protected
  final MethodChannel methodChannel = const MethodChannel(channelName);

  @protected
  final MethodChannel methodChannel2 = const MethodChannel("BannerPlatformView");

  AdPopcornSSPPlatform() : super(token: _token);

  static AdPopcornSSPPlatform _instanceByPlatform() {
    AdPopcornSSPPlatform? instance;
    if (Platform.isAndroid) {
      instance = AdPopcornSSPAndroid();
    } else {
      throw UnsupportedError(
          '\'${Platform.operatingSystem}\' is not supported.');
    }
    PlatformInterface.verify(instance, _token);
    return instance;
  }

  @protected
  Future<T?> invokeMethodAndHandleException<T>(String methodName,
      [dynamic arguments]) async {
    try {
      return await methodChannel.invokeMethod<T>(methodName, arguments);
    } catch (e, s) {
      log('Exception during invoking \'$methodName\'', error: e, stackTrace: s);
      return Future<T?>(() => null);
    }
  }

  @protected
  Future<T?> invokeMethodAndHandleException2<T>(String methodName,
      [dynamic arguments]) async {
    try {
      return await methodChannel2.invokeMethod<T>(methodName, arguments);
    } catch (e, s) {
      log('Exception during invoking \'$methodName\'', error: e, stackTrace: s);
      return Future<T?>(() => null);
    }
  }

  Future<void> setAppKeyAndHashKey(String appKey, String hashKey) async {
    throw UnimplementedError('setAppKeyAndHashKey() has not been implemented.');
  }

  Future<void> useIgaworksRewardServer(bool flag) async {
    throw UnimplementedError(
        'useIgaworksRewardServer() has not been implemented.');
  }

  Future<void> setLogLevel(AdPopcornLogLevel level) async {
    throw UnimplementedError('setLogLevel() has not been implemented.');
  }

  Future<void> setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<void> openOfferWall() {
    throw UnimplementedError('openOfferWall() has not been implemented.');
  }

  Future<void> setOnAgreePrivacy(NoArgumentListener listener) {
    throw UnimplementedError('setOnAgreePrivacy() has not been implemented.');
  }

  Future<void> setOnDisagreePrivacy(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnDisagreePrivacy() has not been implemented.');
  }

  Future<void> setOnClosedOfferWallPage(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnClosedOfferWallPage() has not been implemented.');
  }

  Future<void> setOnWillOpenOfferWall(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnWillOpenOfferWall() has not been implemented.');
  }

  Future<void> setOnDidOpenOfferWall(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnDidOpenOfferWall() has not been implemented.');
  }

  Future<void> setOnWillCloseOfferWall(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnWillCloseOfferWall() has not been implemented.');
  }

  Future<void> setOnDidCloseOfferWall(NoArgumentListener listener) {
    throw UnimplementedError(
        'setOnDidCloseOfferWall() has not been implemented.');
  }

  Future<void> useFlagShowWhenLocked(bool flag) {
    throw UnimplementedError(
        'useFlagShowWhenLocked() has not been implemented.');
  }

  Future<void> openCSPage(String userId) {
    throw UnimplementedError('openCSPage() has not been implemented.');
  }

  Future<void> getEarnableTotalRewardInfo(
      OnGetEarnableTotalRewardInfo callback) {
    throw UnimplementedError(
        'getEarnableTotalRewardInfo() has not been implemented.');
  }

  Future<void> loadPopupAd({
    NoArgumentListener? onLoadPopupAdSuccess,
    PopupAdErrorListener? onLoadPopupAdFailure,
    NoArgumentListener? onShowPopupAdSuccess,
    PopupAdErrorListener? onShowPopupAdFailure,
    NoArgumentListener? onPopupAdClose,
  }) {
    throw UnimplementedError('loadPopupAd() has not been implemented.');
  }

  Future<void> showPopupAd() {
    throw UnimplementedError('showPopupAd() has not been implemented.');
  }

  Future<void> showBannerAd() {
    throw UnimplementedError('showBannerAd() has not been implemented.');
  }

  Future<void> stopBannerAd() {
    throw UnimplementedError('stopBannerAd() has not been implemented.');
  }
}
