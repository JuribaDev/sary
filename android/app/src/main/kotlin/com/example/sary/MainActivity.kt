package com.example.sary

import android.content.Context
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.BinaryMessenger
class MainActivity: FlutterActivity() {

    private val MethodChannelName = "com.sary.juriba/toast"

    private var methodChannel: MethodChannel? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //Setup Channels
        setupChannels(this,flutterEngine.dartExecutor.binaryMessenger)

    }

    override fun onDestroy() {
        teardownChannels()
        super.onDestroy()
    }

    private fun setupChannels(context: Context, messenger:BinaryMessenger){


        methodChannel = MethodChannel(messenger, MethodChannelName)
        methodChannel!!.setMethodCallHandler{
            call,result ->
            if (call.method == "saryToast") {
                val message = call.argument<Any>("message").toString()
                Toast.makeText(applicationContext,message,Toast.LENGTH_SHORT).show()
            } else {
                result.notImplemented()
            }
        }


    }

    private fun teardownChannels(){
        methodChannel!!.setMethodCallHandler(null)
    }
}
