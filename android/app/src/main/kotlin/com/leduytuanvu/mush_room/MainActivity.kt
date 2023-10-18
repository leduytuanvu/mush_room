package com.leduytuanvu.mush_room

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private lateinit var channer: MethodChannel
    private val WIFI_CHANNEL = "leduytuanvu.com/tuanvu"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val messenger: BinaryMessenger = flutterEngine.dartExecutor.binaryMessenger
        channer = MethodChannel(messenger, WIFI_CHANNEL)

        channer.setMethodCallHandler { call, result ->
            if (call.method == "getBattery") {
                val arguments = call.arguments as Map<String, String>?
                val name = arguments?.get("name")
                val battery = getBatteryValue() // Implement this method
                result.success(battery)
            }
        }
    }

    private fun getBatteryValue(): Int {
        // Implement your logic to fetch the battery value here
        return 7 // Example battery value
    }
}

