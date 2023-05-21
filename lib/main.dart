import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ssp_sapme/adview_widget.dart';
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
      buildSetUserId(),
      buildOpenBanner(),
      buildGetEarnableTotalRewardInfo(),
      buildUseFlagShowWhenLocked(),
      buildOpenCSPage(),
      buildLoadPopupAd(),
      buildShowPopupAd(),
      buildAdView(),
    ];
    AdPopcornSSP.setOnAgreePrivacy(() => showSnackBar('onAgreePrivacy()'));
    AdPopcornSSP.setOnDisagreePrivacy(
        () => showSnackBar('onDisagreePrivacy()'));
    AdPopcornSSP.setOnClosedOfferWallPage(
        () => showSnackBar('onClosedOfferWallPage()'));
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

  Widget buildSetAppKeyHashKey() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: textControllerAppKey,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'App key',
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: TextFormField(
                controller: textControllerHashKey,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Hash key',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            final appKey = textControllerAppKey.text;
            final hashKey = textControllerHashKey.text;
            log('setAppKeyAndHashKey() appKey=$appKey, hashKey=$hashKey');
            await AdPopcornSSP.setAppKeyAndHashKey(appKey, hashKey);
            showSnackBar('setAppKeyAndHashKey()');
          },
          child: const Text('setAppKeyAndHashKey()'),
        ),
      ],
    );
  }

  Widget buildUseIgaworksRewardServer() {
    return ElevatedButton(
      onPressed: () async {
        final flag = random.nextBool();
        log('useIgaworksRewardServer() flag=$flag');
        await AdPopcornSSP.useIgaworksRewardServer(flag);
        showSnackBar('useIgaworksRewardServer($flag)');
      },
      child: const Text('useIgaworksRewardServer()'),
    );
  }

  Widget buildSetUserId() {
    return Column(
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: textControllerUserId,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'User ID',
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            userId = textControllerUserId.text;
            log('setUserId() id=$userId');
            await AdPopcornSSP.setUserId(userId);
            showSnackBar('setUserId()');
          },
          child: const Text('setUserId()'),
        ),
      ],
    );
  }

  Widget buildAdView() {
    return Container(
        width: double.infinity,
        height: 50,
        color: Colors.amber,
        child: PlatformWidget());
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
            child: const Text('openBanner()'),
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
            child: const Text('stopBanner()'),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget buildUseFlagShowWhenLocked() {
    return ElevatedButton(
      onPressed: () async {
        final flag = random.nextBool();
        log('useFlagShowWhenLocked() flag=$flag');
        await AdPopcornSSP.useFlagShowWhenLocked(flag);
        showSnackBar('useFlagShowWhenLocked($flag)');
      },
      child: const Text('useFlagShowWhenLocked()'),
    );
  }

  Widget buildOpenCSPage() {
    return ElevatedButton(
      onPressed: () async {
        log('openCSPage() userId=$userId');
        await AdPopcornSSP.openCSPage(userId);
      },
      child: const Text('openCSPage()'),
    );
  }

  Widget buildGetEarnableTotalRewardInfo() {
    return ElevatedButton(
      onPressed: () async {
        log('getEarnableTotalRewardInfo()');
        await AdPopcornSSP.getEarnableTotalRewardInfo(
            (queryResult, totalCount, totalReward) {
          showSnackBar(
              'onGetEarnableTotalRewardInfo() queryResult=$queryResult, totalCount=$totalCount, totalReward=$totalReward');
        });
      },
      child: const Text('getEarnableTotalRewardInfo()'),
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

  Widget buildShowPopupAd() {
    return ElevatedButton(
      onPressed: () async {
        log('showPopupAd()');
        await AdPopcornSSP.showPopupAd();
      },
      child: const Text('showPopupAd()'),
    );
  }
}
