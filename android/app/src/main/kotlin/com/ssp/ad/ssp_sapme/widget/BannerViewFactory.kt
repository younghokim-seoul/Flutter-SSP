package com.ssp.ad.ssp_sapme.widget

import android.content.Context
import io.flutter.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class BannerViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(
    StandardMessageCodec.INSTANCE
) {

    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        Log.i("young", "BannerViewFactory")
        val creationParams = args as Map<String?, Any?>?
        return BannerView(context, messenger, viewId, creationParams)
    }


}