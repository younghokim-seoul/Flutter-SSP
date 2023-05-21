package com.ssp.ad.ssp_sapme.widget


import io.flutter.embedding.engine.plugins.FlutterPlugin


class PlatformViewPlugin : FlutterPlugin {

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val viewFactory = NativeViewFactory(flutterPluginBinding.binaryMessenger)
        flutterPluginBinding.platformViewRegistry.registerViewFactory("BannerPlatformView", viewFactory)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }

}