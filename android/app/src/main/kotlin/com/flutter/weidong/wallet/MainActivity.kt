package com.flutter.weidong.wallet

import android.os.Bundle
import androidx.core.view.WindowInsetsControllerCompat
import androidx.core.view.WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
import io.flutter.custom.plugins.CustomPluginRegistrant.registerWith
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.android.SplashScreen
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        WindowInsetsControllerCompat(window, window.decorView).systemBarsBehavior = BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        registerWith(flutterEngine)
    }

    override fun provideSplashScreen(): SplashScreen? {
        //  
        return try {
            val splashView = layoutInflater.inflate(R.layout.layout_splash_screen, null)
            SplashScreenView(splashView)
        } catch (e: Exception) {
            null
        }

//        val manifestSplashDrawable = getSplashScreenFromManifest()
//        if (null == manifestSplashDrawable) {
//            //Android <= 7.1drawable。 drawable
//            val splashView = layoutInflater.inflate(R.layout.layout_splash_screen, null)
//            return SplashScreenView(splashView)
//        }
//
//        return manifestSplashDrawable?.let { DrawableSplashScreen(it) }
    }

    /**
     * Android <= 7.1drawable。 drawable
     */
//    private fun getSplashScreenFromManifest(): Drawable? {
//        return try {
//            val metaData = this.metaData
//            val splashScreenId = metaData?.getInt("io.flutter.embedding.android.SplashScreenDrawable")
//                    ?: 0
//            val drawable = ResourcesCompat.getDrawable(resources, splashScreenId, theme)
//            drawable
//        } catch (e: Exception) {
//            null
//        }
//    }

}
