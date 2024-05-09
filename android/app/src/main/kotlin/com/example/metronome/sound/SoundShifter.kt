package com.example.metronome.sound

import com.example.metronome.wave.WaveFactoryBuffer
import java.lang.IllegalArgumentException

class SoundShifter() {
    fun set(wave: WaveFactoryBuffer, pitch: String) : ShortArray {
         return when(pitch) {
            "high" -> wave.high
             "mid" -> wave.mid
             "low" -> wave.low
             else -> throw IllegalArgumentException("Unknown pitch: $pitch")
        }
    }
}