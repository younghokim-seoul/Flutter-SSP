import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ssp_sapme/banner_adview_widget.dart';
import 'package:ssp_sapme/native_adview_widget.dart';
import 'package:ssp_sapme/plugin/adpopcorn_ssp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final random = math.Random();
  final textControllerAppKey = TextEditingController();
  final textControllerHashKey = TextEditingController();
  final textControllerUserId = TextEditingController();
  String userId = '';

  List<Widget>? widgetsByPlatform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      initAndroid();
    }
  }

  @override
  void dispose() {
    textControllerAppKey.dispose();
    textControllerHashKey.dispose();
    textControllerUserId.dispose();
    super.dispose();
  }

  void initAndroid() {
    widgetsByPlatform = [
      buildOpenBanner(),
      buildInterstitialAd(),
      buildRewardVideoAd(),
      buildInterstitialVideoAd(),
      buildBannerView(),
      buildNativeAdView()
    ];
    //애드팝콘 sdk init시 콜백...
    AdPopcornSSP.setOnAdInit(() => showSnackBar('setOnAdInit()'));
  }

  void showSnackBar(String text) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 600),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    for (Widget widget in widgetsByPlatform!) {
      children.add(const SizedBox(height: 8));
      children.add(widget);
    }
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Center(
              child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 24),
                  for (final child in children) child,
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget buildBannerView() {
    return Container(
        width: double.infinity,
        height: 100,
        color: Colors.amber,
        child: BannerWidget());
  }

  Widget buildNativeAdView() {
    return Container(
        width: double.infinity,
        height: 100,
        color: Colors.amber,
        child: NativeAdWidget());
  }

  Widget buildOpenBanner() {
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () async {
              log('openBanner()');
              await AdPopcornSSP.showBannerAd();
            },
            child: const Text('배너 시작'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () async {
              log('stopBanner()');
              await AdPopcornSSP.stopBannerAd();
            },
            child: const Text('배너 종료'),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget buildRewardVideoAd() {
    return ElevatedButton(
      onPressed: () async {
        log('apRewardVideoAd()');
        await AdPopcornSSP.apRewardVideoAd(
          onRewardVideoAdLoaded: () => showSnackBar('onRewardVideoAdLoaded()'),
          onRewardVideoAdLoadFailed: (errorCode, errorMessage) => showSnackBar(
              'onRewardVideoAdLoadFailed() errorCode=$errorCode, errorMessage=$errorMessage'),
          onRewardVideoAdOpened: () => showSnackBar('onRewardVideoAdOpened()'),
          onRewardVideoAdOpenFalied: () => showSnackBar('onRewardVideoAdOpenFalied()'),
          onRewardVideoAdClosed: () => showSnackBar('onRewardVideoAdClosed()'),
          onRewardVideoPlayCompleted: () => showSnackBar('onRewardVideoPlayCompleted()'),
          onRewardVideoAdClicked: () => showSnackBar('onRewardVideoAdClicked()'),
        );
      },
      child: const Text('리워드 비디오 광고'),
    );
  }

  Widget buildInterstitialVideoAd() {
    return ElevatedButton(
      onPressed: () async {
        log('apInterstitialVideoAd()');
        await AdPopcornSSP.apInterstitialVideoAd();
      },
      child: const Text('전면 비디오 광고'),
    );
  }

  Widget buildInterstitialAd() {
    return ElevatedButton(
      onPressed: () async {
        log('getEarnableTotalRewardInfo()');
        await AdPopcornSSP.interstitialAd();
      },
      child: const Text('전면 광고 로드'),
    );
  }

  Widget buildLoadPopupAd() {
    return ElevatedButton(
      onPressed: () async {
        log('loadPopupAd()');
        await AdPopcornSSP.loadPopupAd(
          onLoadPopupAdSuccess: () => showSnackBar('onLoadPopupAdSuccess()'),
          onLoadPopupAdFailure: (errorCode, errorMessage) => showSnackBar(
              'onLoadPopupAdFailure() errorCode=$errorCode, errorMessage=$errorMessage'),
          onShowPopupAdSuccess: () => showSnackBar('onShowPopupAdSuccess()'),
          onShowPopupAdFailure: (errorCode, errorMessage) => showSnackBar(
              'onShowPopupAdFailure()) errorCode=$errorCode, errorMessage=$errorMessage'),
          onPopupAdClose: () => showSnackBar('onPopupAdClose()'),
        );
      },
      child: const Text('loadPopupAd()'),
    );
  }
}
