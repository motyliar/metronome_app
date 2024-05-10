package com.example.metronome.wave

import java.lang.UnsupportedOperationException

enum class WaveFactoryBuffer(val high: ShortArray,val mid: ShortArray,val low: ShortArray) {
    SIN(
        high = HighSinWave.generateSound(), mid = MidSinWave.generateSound(), low = LowSinWave.generateSound()
    ), SQUARE(
        high = HighSquareWave.generateSound(), mid = MidSquareWave.generateSound(), low = LowSquareWave.generateSound()
    ),
    ;

    companion object {
        fun initialize() {
            values()
        }



        private fun getCurrentWave(name: String): WaveFactoryBuffer {
            return when(name) {
                "sin" -> SIN
                "square" -> SQUARE
                else -> SIN
            }
        }

        fun getSound(tableWave: String, pitch: String): ShortArray {
            val wave = getCurrentWave(tableWave)
            return when(pitch) {
                "high" -> wave.high
                "mid" -> wave.mid
                "low" -> wave.low
                else -> throw UnsupportedOperationException()
            }

        }
    }



}



