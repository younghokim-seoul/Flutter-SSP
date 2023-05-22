package com.ssp.ad.ssp_sapme.widget

import android.content.Context
import android.util.Log
import android.view.View
import com.igaworks.ssp.SSPErrorCode
import com.igaworks.ssp.part.nativead.AdPopcornSSPNativeAd
import com.igaworks.ssp.part.nativead.binder.AdPopcornSSPViewBinder
import com.igaworks.ssp.part.nativead.listener.INativeAdEventCallbackListener
import com.ssp.ad.ssp_sapme.R
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView


class NativeAdView(
    context: Context?,
    messenger: BinaryMessenger,
    id: Int,
    creationParams: Map<String?, Any?>?
) : PlatformView, MethodCallHandler {
    private val apMediationNativeAd: AdPopcornSSPNativeAd = AdPopcornSSPNativeAd(context)

    private lateinit var channel: MethodChannel

    override fun getView(): View {
        return apMediationNativeAd
    }

    override fun dispose() {}

    private val methodChannel: MethodChannel = MethodChannel(messenger, "NativePlatformView")

    init {
        Log.i("young", "NativeAdView init")


        methodChannel.setMethodCallHandler(this)

        apMediationNativeAd.setPlacementId("NATIVE")

        val igawMediationViewBinder = AdPopcornSSPViewBinder.Builder(R.id.apssp_native_ad_view)
            .iconImageViewId(R.id.apssp_native_ad_icon_image1)
            .descViewId(R.id.apssp_native_ad_desc1)
            .mainImageViewId(R.id.apssp_native_ad_main_image1)
            .titleViewId(R.id.apssp_native_ad_title1)
            .callToActionId(R.id.apssp_native_ad_ctatext1)
            .build()

        apMediationNativeAd.adPopcornSSPViewBinder = igawMediationViewBinder

        apMediationNativeAd.setNativeAdEventCallbackListener(object :
            INativeAdEventCallbackListener {
            override fun onNativeAdLoadSuccess() {
                Log.i(
                    "young",
                    "Mediation NativeAd onNativeAdLoadSuccess : " + apMediationNativeAd.isLoaded
                )

            }

            override fun onNativeAdLoadFailed(errorCode: SSPErrorCode) {
                Log.i("young", "Mediation NativeAd onNativeAdLoadFailed : " + apMediationNativeAd.isLoaded + " errorCode : " + errorCode.errorMessage)

            }

            override fun onImpression() {
                Log.i("young", "Mediation NativeAd onImpression")
            }

            override fun onClicked() {
                Log.i("young", "Mediation NativeAd onClicked")
            }
        })

        apMediationNativeAd.loadAd()


    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
//        Log.e("young", "NativeView onMethodCall => " + call.method)
//        Log.e("young", "NativeView onMethodCall => " + call.argument<String>("optType"))
//        when (call.method) {
//            "showBannerAd" -> adView.loadAd()
//            "stopBannerAd" -> adView.stopAd()
//        }
    }
}