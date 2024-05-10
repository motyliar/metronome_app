package com.example.metronome

import android.content.Context
import android.media.AudioFormat
import android.media.AudioManager
import android.media.AudioTrack
import android.os.Build
import com.example.metronome.player.MetronomePlayer
import com.example.metronome.sound.SoundShifter
import com.example.metronome.wave.SinWave
import com.example.metronome.wave.WaveFactoryBuffer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.math.sin

class MainActivity: FlutterActivity() {
   private val channel = "metronome"
   private val metronome: MetronomePlayer = MetronomePlayer()
   private val shifter: SoundShifter = SoundShifter()



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        metronome.initPlayer()
        metronome.audioTrack?.play()
        WaveFactoryBuffer.initialize()

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler {
                call, result ->
                when(call.method) {
                    MethodChannelNames.INIT.name -> WaveFactoryBuffer.initialize()
                    MethodChannelNames.PLAY.name -> {
                        val audio = call.argument<String>("audio")
                        println("asset: $audio")
                        val accent = call.argument<String>("accent")
                        val sound = WaveFactoryBuffer.getCurrentWave(audio!!)
                        val wave = shifter.set(sound, accent!!)

                        metronome.play(wave)
                    }
                }
            }
    }

}


enum class MethodChannelNames {
    INIT, PLAY
}



