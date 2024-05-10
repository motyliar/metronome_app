package com.example.metronome

import com.example.metronome.player.Metronome
import com.example.metronome.wave.WaveFactoryBuffer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


enum class MethodChannelNames {
    INIT, PLAY, METRONOME
}
class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val context = this.applicationContext
        val metronome = Metronome(context)




        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MethodChannelNames.METRONOME.name.lowercase())
            .setMethodCallHandler {
                call, result ->
                when(call.method) {
                    MethodChannelNames.INIT.name -> WaveFactoryBuffer.initialize()
                    MethodChannelNames.PLAY.name -> {
                        val asset = call.argument<String>("audio")
                        val pitch = call.argument<String>("accent")

                            metronome.play(pitch!!, asset!!)

                    }
                }
            }
    }

}






