import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:ssp_sapme/plugin/adpopcorn_ssp_android.dart';

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
  final MethodChannel methodChannel2 =
      const MethodChannel("BannerPlatformView");

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

  Future<void> setOnAdInit(NoArgumentListener listener) {
    throw UnimplementedError('setOnAdInit() has not been implemented.');
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

  Future<void> apRewardVideoAd({
    NoArgumentListener? onRewardVideoAdLoaded,
    PopupAdErrorListener? onRewardVideoAdLoadFailed,
    NoArgumentListener? onRewardVideoAdOpened,
    NoArgumentListener? onRewardVideoAdOpenFalied,
    NoArgumentListener? onRewardVideoAdClosed,
    NoArgumentListener? onRewardVideoPlayCompleted,
    NoArgumentListener? onRewardVideoAdClicked,
  }) {
    throw UnimplementedError('apRewardVideoAd() has not been implemented.');
  }

  Future<void> showBannerAd() {
    throw UnimplementedError('showBannerAd() has not been implemented.');
  }

  Future<void> stopBannerAd() {
    throw UnimplementedError('stopBannerAd() has not been implemented.');
  }

  Future<void> interstitialAd() {
    throw UnimplementedError('interstitialAd() has not been implemented.');
  }

  Future<void> apInterstitialVideoAd() {
    throw UnimplementedError(
        'apInterstitialVideoAd() has not been implemented.');
  }
}
