package com.crequency.kitx.mobile

import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.reflect.Method
import java.net.NetworkInterface
import java.util.*

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.crequency.kitx.mobile/channel";
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "getMAC") {
                var mac = getMacAddress();
                result.success(mac);
                Toast.makeText(this, mac, Toast.LENGTH_LONG).show()
            }
        }
    }

    private fun getMacAddress(): String? {
        var fallBackValue = ""
        try {
            val all: List<NetworkInterface> =
                Collections.list<NetworkInterface>(NetworkInterface.getNetworkInterfaces())
            for (nif in all) {
                if (!nif.getName().equals("wlan0", ignoreCase = true)) continue
                val macBytes: ByteArray = nif.getHardwareAddress() ?: return fallBackValue
                val res1 = StringBuilder()
                for (b in macBytes) {
                    res1.append(String.format("%02X:", b))
                }
                if (res1.length > 0) {
                    res1.deleteCharAt(res1.length - 1)
                }
                return res1.toString()
            }
        } catch (ex: java.lang.Exception) {
            return fallBackValue
        }
        return fallBackValue
    }
}
