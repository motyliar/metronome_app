package com.example.metronome.player

import android.content.Context
import com.example.metronome.sound.StreamFetcher
import com.example.metronome.wave.FileWave
import com.example.metronome.sound.SoundsInterpreter
import com.example.metronome.wave.WaveFactoryBuffer

class Metronome(val context: Context) {


    private val streamFetcher: StreamFetcher = StreamFetcher(context)
    private val inputs = streamFetcher.fetch()

    private val fileWave: FileWave = FileWave(inputs)
    private val sound = fileWave.readAudioToArray()
    private val player: MetronomePlayer = MetronomePlayer()
    private val interpreter: SoundsInterpreter = SoundsInterpreter(sound)

    init {
        initPlayer()
        WaveFactoryBuffer.initialize()
    }

   private fun initPlayer() {
        player.initPlayer()
        player.audioTrack?.play()
    }
    fun play(pitch: String, asset: String ) {
        val wave = interpreter.interpret(pitch, asset)
        player.play(wave)




    }




}