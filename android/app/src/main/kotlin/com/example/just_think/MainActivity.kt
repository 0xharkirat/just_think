package com.example.just_think

import io.flutter.embedding.android.FlutterActivity
import android.net.Uri
import android.content.Intent
import android.provider.Settings
import android.content.Context
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.just_think/foreground"

    override fun configureFlutterEngine(@NonNull flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "redirectToUsageAccessSettings" -> {
                    redirectToUsageAccessSettings()
                    result.success(null)
                }
                "getForegroundApp" -> {
                    val foregroundApp = getForegroundApp()
                    if (foregroundApp != null) {
                        result.success(foregroundApp)
                    } else {
                        result.error("UNAVAILABLE", "Could not retrieve foreground app", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
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

    private fun getForegroundApp(): String? {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val currentTime = System.currentTimeMillis()
        val stats = usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY,
            currentTime - 1000 * 60 * 60, // Past hour
            currentTime
        )

        if (stats != null) {
            val recentStats = stats.maxByOrNull { it.lastTimeUsed }
            return recentStats?.packageName
        }
        return null
    }

}

