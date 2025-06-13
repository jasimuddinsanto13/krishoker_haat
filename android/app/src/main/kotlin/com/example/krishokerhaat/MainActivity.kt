package com.example.krishokerhaat

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "your_plugin_channel"  // use the same channel name your Dart code calls

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAll" -> {
                    // Implement your getAll logic here.
                    // For example, return a dummy list:
                    val data = listOf("Item1", "Item2", "Item3")
                    result.success(data)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
