package com.example.metronome.wave

enum class WaveFactoryBuffer(val high: ShortArray,val mid: ShortArray,val low: ShortArray) {
    SIN(
        high = HighSinWave.generateSound(), mid = MidSinWave.generateSound(), low = LowSinWave.generateSound()
    ), SQUARE(
        high = HighSquareWave.generateSound(), mid = MidSquareWave.generateSound(), low = LowSqureWave.generateSound()
    );

    companion object {
        fun initialize() {
            values()
        }

        fun getCurrentWave(name: String): WaveFactoryBuffer {
            return when(name) {
                "sin" -> SIN
                "square" -> SQUARE
                else -> SIN
            }
        }
    }



}