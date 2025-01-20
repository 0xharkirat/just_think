package com.example.just_think

import android.content.Intent
import android.net.Uri
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity : FlutterActivity() {

    private val METHOD_CHANNEL = "com.example.just_think/foreground"
    private val EVENT_CHANNEL = "com.example.just_think/foreground_app"

    override fun configureFlutterEngine(@NonNull flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // MethodChannel for redirecting to Usage Access Settings
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "redirectToUsageAccessSettings" -> {
                    redirectToUsageAccessSettings()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        // EventChannel for broadcasting app changes
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL).setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                ForegroundAppService.eventSink = events
                Log.d("MainActivity", "EventSink initialized: $events")

                // Start the ForegroundAppService
                startService(Intent(this@MainActivity, ForegroundAppService::class.java))
            }

            override fun onCancel(arguments: Any?) {
                ForegroundAppService.eventSink = null
                Log.d("MainActivity", "EventSink detached")

                // Stop the ForegroundAppService
                stopService(Intent(this@MainActivity, ForegroundAppService::class.java))
            }
        })
    }

    private fun redirectToUsageAccessSettings() {
        try {
            val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            intent.data = Uri.parse("package:$packageName") // Dynamic package name
            startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
