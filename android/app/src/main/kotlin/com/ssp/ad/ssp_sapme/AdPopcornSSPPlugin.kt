package com.ssp.ad.ssp_sapme

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.igaworks.ssp.AdPopcornSSP
import com.igaworks.ssp.SSPErrorCode
import com.igaworks.ssp.part.banner.AdPopcornSSPBannerAd
import com.igaworks.ssp.part.banner.listener.IBannerEventCallbackListener
import com.igaworks.ssp.part.video.AdPopcornSSPRewardVideoAd
import com.igaworks.ssp.part.video.listener.IRewardVideoAdEventCallbackListener
import io.flutter.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result

private const val CHANNEL_NAME = "adpopcorn_flutter_sdk"
private const val TAG: String = "young_";


class AdPopcornSSPPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {

    enum class AdPopType(val id: String) {
        REWARD_VIDEO("8EgzAzwcpDh1CfC"),
        NATIVE("xkzFM4k7PFfgt8z"),
        BANNER("BANNER_320x50"),

    }

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var apRewardVideoAd : AdPopcornSSPRewardVideoAd

    private val invokeResult = object : Result {
        override fun success(result: Any?) {
            Log.v(TAG, "invokeResult: success: '$result'")
        }

        override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
            Log.e(TAG, "invokeResult: error: $errorCode, $errorMessage, $errorDetails")
        }

        override fun notImplemented() {
            Log.e(TAG, "invokeResult: notImplemented:")
        }
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "setUserId") {
            Log.d(TAG, "onMethodCall: setUserId")
            result.success(null)
        } else if (call.method == "openOfferWall") {
            result.success(null)
        } else if (call.method == "useFlagShowWhenLocked") {
            result.success(null)
        } else if (call.method == "openCSPage") {
            result.success(null)
        } else if (call.method == "getEarnableTotalRewardInfo") {
            result.success(null)
        } else if (call.method == "loadPopupAd") {
            apRewardVideoAd.showAd()
            result.success(null)
        } else if (call.method == "showPopupAd") {
            Log.i(TAG, "OneButton OnRewardVideoAdOpenFalied")
//            Adpopcorn.showPopupAd(activity)
//            val adPopcornBannerAd = AdPopcornSSPBannerAd(activity)
//            Log.d(TAG, "adPopcornBannerAd: $adPopcornBannerAd")
//            adPopcornBannerAd.setAdSize(AdSize.BANNER_320x50);
//            adPopcornBannerAd.placementId = AdPopType.BANNER.id
//            Log.d(TAG, "setting adPopcornBannerAd: " + adPopcornBannerAd.placementId)
//            register(adPopcornBannerAd)
//            adPopcornBannerAd.loadAd()





//             6.Reward Video
            apRewardVideoAd = AdPopcornSSPRewardVideoAd(activity)
            apRewardVideoAd.setPlacementId("REWARD_VIDEO")
            apRewardVideoAd.setRewardVideoAdEventCallbackListener(object :
                IRewardVideoAdEventCallbackListener {
                override fun OnRewardVideoAdLoaded() {
                    Log.i(TAG, "OneButton OnRewardVideoAdLoaded")
                }

                override fun OnRewardVideoAdLoadFailed(p0: SSPErrorCode?) {
                    Log.i(TAG, "OneButton OnRewardVideoAdLoadFailed " + p0 + " => " + p0?.errorMessage)
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
            apRewardVideoAd.loadAd()
            result.success(null)
        } else {
            result.notImplemented()
        }
    }

    private fun register(adPopcornBannerAd: AdPopcornSSPBannerAd) {
        adPopcornBannerAd.setBannerEventCallbackListener(object : IBannerEventCallbackListener {

            override fun OnBannerAdReceiveSuccess() {
                Log.e(TAG, "OnBannerAdReceiveSuccess " + adPopcornBannerAd.currentNetwork)
            }

            override fun OnBannerAdReceiveFailed(sspErrorCode: SSPErrorCode) {
                Log.e(
                    TAG,
                    "OnBannerAdReceiveFailed " + sspErrorCode.errorMessage + " code " + sspErrorCode.errorCode
                )
            }

            override fun OnBannerAdClicked() {
                Log.e(TAG, "OnBannerAdClicked ")
            }
        })
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Log.d(TAG, "onAttachedToActivity")
        activity = binding.activity;
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
    }


    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }
}