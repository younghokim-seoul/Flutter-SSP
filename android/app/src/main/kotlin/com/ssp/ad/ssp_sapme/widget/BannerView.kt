package com.ssp.ad.ssp_sapme.widget

import android.content.Context
import android.view.View
import com.igaworks.ssp.AdSize
import com.igaworks.ssp.SSPErrorCode
import com.igaworks.ssp.part.banner.AdPopcornSSPBannerAd
import com.igaworks.ssp.part.banner.listener.IBannerEventCallbackListener
import com.ssp.ad.ssp_sapme.SSPType
import io.flutter.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView


class BannerView(context: Context?, messenger: BinaryMessenger, id: Int, creationParams: Map<String?, Any?>?) : PlatformView , MethodCallHandler{
    private val adView: AdPopcornSSPBannerAd = AdPopcornSSPBannerAd(context)

    private lateinit var channel: MethodChannel

    override fun getView(): View {
        return adView
    }

    override fun dispose() {}

    private val methodChannel: MethodChannel = MethodChannel(messenger, "BannerPlatformView")

    init {
        Log.i("young","BannerView init")
//        val message: String = creationParams?.get("key").toString()

        methodChannel.setMethodCallHandler(this)

        adView.setAdSize(AdSize.BANNER_320x100);
        adView.placementId = SSPType.BANNER.keyValue
        adView.setBannerEventCallbackListener(object : IBannerEventCallbackListener {

            override fun OnBannerAdReceiveSuccess() {
                Log.e("young", "OnBannerAdReceiveSuccess " + adView.currentNetwork)
            }

            override fun OnBannerAdReceiveFailed(sspErrorCode: SSPErrorCode) {
                Log.e(
                    "young",
                    "OnBannerAdReceiveFailed " + sspErrorCode.errorMessage + " code " + sspErrorCode.errorCode
                )
            }

            override fun OnBannerAdClicked() {
                Log.e("young", "OnBannerAdClicked ")
            }
        })

    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.e("young", "NativeView onMethodCall => " + call.method)
        Log.e("young", "NativeView onMethodCall => " + call.argument<String>("optType"))
        when(call.method){
            "showBannerAd" -> adView.loadAd()
            "stopBannerAd" -> adView.stopAd()
        }
    }
}