package com.hsi.harki.just_think

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.PowerManager
import android.provider.Settings
import android.text.TextUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val NAV_CHANNEL = "com.hsi.harki.just_think/navigation"
    private val BLOCKER_CHANNEL = "com.hsi.harki.just_think/blocker"
    private val EVENT_CHANNEL = "com.hsi.harki.just_think/blocked_app_events"

    private var eventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Navigation channel (existing)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, NAV_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "goToHome") {
                    goToHomeScreen()
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }

        // Blocker control channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BLOCKER_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAccessibilityEnabled" -> {
                        result.success(isAccessibilityServiceEnabled())
                    }
                    "openAccessibilitySettings" -> {
                        openAccessibilitySettings()
                        result.success(null)
                    }
                    "isBatteryOptIgnored" -> {
                        val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
                        result.success(pm.isIgnoringBatteryOptimizations(packageName))
                    }
                    "requestBatteryOptExemption" -> {
                        requestBatteryOptExemption()
                        result.success(null)
                    }
                    "syncBlockedPackages" -> {
                        val packages = call.argument<List<String>>("packages") ?: emptyList()
                        val prefs = getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
                        prefs.edit().putStringSet("flutter.blocked_packages", packages.toSet()).apply()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }

        // Event channel for blocked app events
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                }
            })

        // Check if launched with a blocked app intent
        handleBlockedAppIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleBlockedAppIntent(intent)
    }

    private fun handleBlockedAppIntent(intent: Intent?) {
        if (intent?.action == "com.hsi.harki.just_think.ACTION_BLOCK_APP") {
            val packageName = intent.getStringExtra("blocked_package_name") ?: return
            val data = mapOf(
                "packageName" to packageName
            )
            eventSink?.success(data)
        }
    }

    private fun goToHomeScreen() {
        val intent = Intent(Intent.ACTION_MAIN)
        intent.addCategory(Intent.CATEGORY_HOME)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }

    private fun isAccessibilityServiceEnabled(): Boolean {
        val service = ComponentName(this, AppBlockerAccessibilityService::class.java)
        val enabledServices = Settings.Secure.getString(
            contentResolver,
            Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
        ) ?: return false

        val colonSplitter = TextUtils.SimpleStringSplitter(':')
        colonSplitter.setString(enabledServices)
        while (colonSplitter.hasNext()) {
            val componentName = colonSplitter.next()
            if (ComponentName.unflattenFromString(componentName) == service) {
                return true
            }
        }
        return false
    }

    private fun openAccessibilitySettings() {
        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }

    private fun requestBatteryOptExemption() {
        val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
        intent.data = Uri.parse("package:$packageName")
        startActivity(intent)
    }
}

