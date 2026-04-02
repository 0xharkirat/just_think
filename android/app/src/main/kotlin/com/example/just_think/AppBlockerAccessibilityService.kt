package com.hsi.harki.just_think

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.content.SharedPreferences
import android.util.Log
import android.view.accessibility.AccessibilityEvent

class AppBlockerAccessibilityService : AccessibilityService() {

    companion object {
        private const val TAG = "AppBlockerA11y"
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val BLOCKED_PACKAGES_KEY = "flutter.blocked_packages"
        private const val COOLDOWN_MS = 10_000L // 10 seconds cooldown
    }

    private var blockedPackages: Set<String> = emptySet()
    private val recentlyLaunched = mutableMapOf<String, Long>()
    private var lastDetectedPackage: String? = null

    private val prefsListener = SharedPreferences.OnSharedPreferenceChangeListener { prefs, key ->
        if (key == BLOCKED_PACKAGES_KEY) {
            loadBlockedPackages(prefs)
        }
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        val prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
        loadBlockedPackages(prefs)
        prefs.registerOnSharedPreferenceChangeListener(prefsListener)
        Log.d(TAG, "AccessibilityService connected, blocked: $blockedPackages")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return
        if (event.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return

        val packageName = event.packageName?.toString() ?: return

        // Ignore our own package and system UI
        if (packageName == applicationContext.packageName) return
        if (packageName == "com.android.systemui") return
        if (packageName == lastDetectedPackage) return

        lastDetectedPackage = packageName

        if (!blockedPackages.contains(packageName)) return

        // Check cooldown
        val now = System.currentTimeMillis()
        val lastLaunch = recentlyLaunched[packageName] ?: 0
        if (now - lastLaunch < COOLDOWN_MS) {
            Log.d(TAG, "Skipping $packageName — cooldown active")
            return
        }

        recentlyLaunched[packageName] = now
        Log.d(TAG, "Blocked app detected: $packageName — launching overlay")

        launchOverlay(packageName)
    }

    override fun onInterrupt() {
        Log.d(TAG, "AccessibilityService interrupted")
    }

    override fun onDestroy() {
        val prefs = getSharedPreferences(PREFS_NAME, MODE_PRIVATE)
        prefs.unregisterOnSharedPreferenceChangeListener(prefsListener)
        super.onDestroy()
    }

    private fun loadBlockedPackages(prefs: SharedPreferences) {
        blockedPackages = prefs.getStringSet(BLOCKED_PACKAGES_KEY, emptySet()) ?: emptySet()
        Log.d(TAG, "Loaded blocked packages: $blockedPackages")
    }

    private fun launchOverlay(blockedPackageName: String) {
        try {
            val intent = Intent(this, MainActivity::class.java).apply {
                action = "com.hsi.harki.just_think.ACTION_BLOCK_APP"
                putExtra("blocked_package_name", blockedPackageName)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            }
            startActivity(intent)
        } catch (e: Exception) {
            Log.e(TAG, "Failed to launch overlay: ${e.message}")
        }
    }

    /**
     * Called from Dart side via MethodChannel when user allows an app.
     * Resets the cooldown tracking so the app won't be immediately re-blocked.
     */
    fun clearCooldown(packageName: String) {
        recentlyLaunched.remove(packageName)
        lastDetectedPackage = null
    }
}
