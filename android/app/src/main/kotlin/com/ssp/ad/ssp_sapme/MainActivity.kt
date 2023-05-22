package com.ssp.ad.ssp_sapme

import android.os.Bundle
import androidx.annotation.NonNull
import com.igaworks.ssp.AdPopcornSSP
import com.igaworks.ssp.SSPErrorCode
import com.igaworks.ssp.part.interstitial.AdPopcornSSPInterstitialAd
import com.igaworks.ssp.part.interstitial.listener.IInterstitialEventCallbackListener
import com.igaworks.ssp.part.video.AdPopcornSSPInterstitialVideoAd
import com.igaworks.ssp.part.video.AdPopcornSSPRewardVideoAd
import com.igaworks.ssp.part.video.listener.IInterstitialVideoAdEventCallbackListener
import com.igaworks.ssp.part.video.listener.IRewardVideoAdEventCallbackListener
import com.ssp.ad.ssp_sapme.widget.BannerViewFactory
import com.ssp.ad.ssp_sapme.widget.NativeAdViewFactory
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


private const val CHANNEL_NAME = "adpopcorn_flutter_sdk"
private const val TAG: String = "young_";

class MainActivity : FlutterActivity() {

    private lateinit var apRewardVideoAd: AdPopcornSSPRewardVideoAd
    private lateinit var apInterstitialAd: AdPopcornSSPInterstitialAd
    private lateinit var apInterstitialVideoAd: AdPopcornSSPInterstitialVideoAd

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        /* 주의 사항
            샘플에서 사용하고 있는 placement ID 값은 반드시 애드팝콘에서 발급받은 키로 변경하여 사용하여야 합니다.
            기타 자세한 사항 및 최신 SDK는 애드팝콘 SSP 가이드 페이지를 참고해 주시기 바랍니다
        */

        // 1. AdPopcornSSP SDK 초기화
        initSDK()

    }


    private fun initSDK() {
        //SSP SDK 초기화
        if (AdPopcornSSP.isInitialized(activity)) {
            // Already SSP SDK initialized
            Log.d(TAG, "SSP Already SSP SDK initialized")
        } else {
            Log.d(TAG, "SSP init")
            AdPopcornSSP.init(activity)
        }

        apRewardVideoAd = AdPopcornSSPRewardVideoAd(activity)
        apInterstitialAd = AdPopcornSSPInterstitialAd(activity)
        apInterstitialVideoAd = AdPopcornSSPInterstitialVideoAd(activity)

    }


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "BannerPlatformView",
                BannerViewFactory(flutterEngine.dartExecutor.binaryMessenger)
            )


        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                "NativePlatformView",
                NativeAdViewFactory(flutterEngine.dartExecutor.binaryMessenger)
            )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            Log.i(TAG, "main Handler => " + call.method)
            if (call.method == "apRewardVideoAd") {
                apRewardVideoAd = AdPopcornSSPRewardVideoAd(this)
                apRewardVideoAd.setPlacementId(SSPType.REWARD_VIDEO.keyValue)
                apRewardVideoAd.setRewardVideoAdEventCallbackListener(object :
                    IRewardVideoAdEventCallbackListener {
                    override fun OnRewardVideoAdLoaded() {
                        Log.i(TAG, "OneButton OnRewardVideoAdLoaded")
                        if (apRewardVideoAd.isReady) apRewardVideoAd.showAd()
                    }

                    override fun OnRewardVideoAdLoadFailed(p0: SSPErrorCode?) {
                        Log.i(
                            TAG,
                            "OneButton OnRewardVideoAdLoadFailed " + p0?.errorCode + " => " + p0?.errorMessage
                        )
                    }

                    override fun OnRewardVideoAdOpened() {
                        Log.i(TAG, "OneButton OnRewardVideoAdOpened")
                    }

                    override fun OnRewardVideoAdOpenFalied() {
                        Log.i(TAG, "OneButton OnRewardVideoAdOpenFalied")
                    }

                    override fun OnRewardVideoAdClosed() {
                        Log.i(TAG, "OneButton OnRewardVideoAdClosed")
                    }

                    override fun OnRewardVideoPlayCompleted(p0: Int, p1: Boolean) {
                        Log.i(TAG, "OneButton OnRewardVideoPlayCompleted")
                    }

                    override fun OnRewardVideoAdClicked() {
                        Log.i(TAG, "OneButton OnRewardVideoAdClicked")
                    }

                })
                Log.i(TAG, "loadAd " + apRewardVideoAd)
                apRewardVideoAd.loadAd()
                result.success(null)
            } else if (call.method == "interstitialAd") {
                apInterstitialAd.setPlacementId(SSPType.INTERSTITIAL.keyValue)
                apInterstitialAd.setInterstitialEventCallbackListener(object :
                    IInterstitialEventCallbackListener {
                    override fun OnInterstitialLoaded() {
                        Log.i("young", "OnInterstitialLoaded")
                        if (apInterstitialAd.isLoaded) apInterstitialAd.showAd()
                    }

                    override fun OnInterstitialOpened() {
                        Log.i("young", "OnInterstitialOpened")
                    }

                    override fun OnInterstitialReceiveFailed(errorCode: SSPErrorCode) {
                        Log.i(
                            "young",
                            "OnInterstitialReceiveFailed : " + errorCode.errorCode + ", errorMessage : " + errorCode.errorMessage
                        )

                    }

                    override fun OnInterstitialOpenFailed(errorCode: SSPErrorCode) {
                        Log.i(
                            "young",
                            "OnInterstitialOpenFailed : " + errorCode.errorCode + ", errorMessage : " + errorCode.errorMessage
                        )

                    }

                    override fun OnInterstitialClosed(closeEvent: Int) {
                        Log.i("young", "OnInterstitialClosed : $closeEvent")
                        if (closeEvent == AdPopcornSSPInterstitialAd.CloseEvent.UNKNOWN) {

                        } else if (closeEvent == AdPopcornSSPInterstitialAd.CloseEvent.CLICK_CLOSE_BTN) {

                        } else if (closeEvent == AdPopcornSSPInterstitialAd.CloseEvent.PRESSED_BACK_KEY) {

                        }
                    }

                    override fun OnInterstitialClicked() {
                        Log.i("young", "OnInterstitialClicked")
                    }
                })
                apInterstitialAd.loadAd()
            } else if (call.method == "apInterstitialVideoAd") {
                apInterstitialVideoAd.setPlacementId(SSPType.INTERSTITIAL_VIDEO.keyValue)
                apInterstitialVideoAd.setEventCallbackListener(object :
                    IInterstitialVideoAdEventCallbackListener {
                    override fun OnInterstitialVideoAdLoaded() {
                        Log.i("young", "OnInterstitialVideoAdLoaded")
                        if (apInterstitialVideoAd.isReady) apInterstitialVideoAd.showAd()
                    }

                    override fun OnInterstitialVideoAdLoadFailed(errorCode: SSPErrorCode?) {
                        Log.i(
                            "young",
                            "OnInterstitialVideoAdLoadFailed : " + errorCode?.errorCode + ", errorMessage : " + errorCode?.errorMessage
                        )
                    }

                    override fun OnInterstitialVideoAdOpened() {
                        Log.i("young", "OnInterstitialVideoAdOpened")
                    }

                    override fun OnInterstitialVideoAdOpenFalied() {
                        Log.i("young", "OnInterstitialVideoAdOpenFalied")
                    }

                    override fun OnInterstitialVideoAdClosed() {
                        Log.i("young", "OnInterstitialVideoAdClosed")
                    }

                    override fun OnInterstitialVideoAdClicked() {
                        Log.i("young", "OnInterstitialVideoAdClicked")
                    }

                })
                apInterstitialVideoAd.loadAd()
            }
        }

    }
}
