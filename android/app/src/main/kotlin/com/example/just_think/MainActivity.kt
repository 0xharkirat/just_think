package com.example.just_think

import android.content.Intent
import android.os.Bundle
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.just_think/navigation"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "goToHome") {
                goToHomeScreen()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun goToHomeScreen() {
        val intent = Intent(Intent.ACTION_MAIN)
        intent.addCategory(Intent.CATEGORY_HOME)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }
}

