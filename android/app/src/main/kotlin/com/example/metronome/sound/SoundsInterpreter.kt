package com.example.metronome.sound

import com.example.metronome.wave.WaveFactoryBuffer



class SoundsInterpreter(private val sounds: List<ShortArray>) {
    fun interpret(pitch: String, asset: String): ShortArray{
        return when(asset) {
            "tambourine" -> if(pitch == "high") { return sounds[0]
            } else { return sounds[1]
            } else -> WaveFactoryBuffer.getSound(asset, pitch)
        }
    }
}