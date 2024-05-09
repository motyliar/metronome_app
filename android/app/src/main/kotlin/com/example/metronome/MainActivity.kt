package com.example.metronome

import android.content.Context
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import android.os.Build
import com.example.metronome.player.MetronomePlayer
import com.example.metronome.sound.SoundShifter
import com.example.metronome.wave.WaveFactoryBuffer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    val channel = "metronome"
    val metronome: MetronomePlayer = MetronomePlayer()
    val shifter: SoundShifter = SoundShifter()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler {
                call, result ->
                when(call.method) {
                    MethodChannelNames.INIT.name.lowercase() -> WaveFactoryBuffer.initialize()
                    MethodChannelNames.PLAY.name.lowercase() -> {
                        val audio = call.argument<String>("audio")
                        val accent = call.argument<String>("accent")
                        val wave = WaveFactoryBuffer.getCurrentWave(audio!!)
                        val waveTable = shifter.set(wave, accent!!)


                        metronome.play(waveTable)}
                }
            }
    }

}


enum class MethodChannelNames {
    INIT, PLAY
}
