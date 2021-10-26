package com.flutter.weidong.wallet

import android.animation.Animator
import android.content.Context
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.SplashScreen

class SplashScreenView constructor(view: View, crossFadeDurationInMillis: Long = 500L) : SplashScreen {
    private val crossFadeDurationInMillis: Long
    private val splashView: View?

    init {
        splashView = view
        this.crossFadeDurationInMillis = crossFadeDurationInMillis
    }

    override fun createSplashView(context: Context, savedInstanceState: Bundle?): View? {
        return splashView
    }

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        if (splashView == null) {
            onTransitionComplete.run()
        } else {
            splashView.animate().alpha(0.0f).setDuration(crossFadeDurationInMillis).setListener(object : Animator.AnimatorListener {
                override fun onAnimationStart(animation: Animator) {}
                override fun onAnimationEnd(animation: Animator) {
                    onTransitionComplete.run()
                }

                override fun onAnimationCancel(animation: Animator) {
                    onTransitionComplete.run()
                }

                override fun onAnimationRepeat(animation: Animator) {}
            })
        }
    }


}