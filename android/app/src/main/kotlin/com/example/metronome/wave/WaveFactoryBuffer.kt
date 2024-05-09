package com.example.metronome.wave

enum class WaveFactoryBuffer(high: ShortArray,mid: ShortArray, low: ShortArray) {
    SIN(
        high = HighSinWave.generateSound(), mid = MidSinWave.generateSound(), low = LowSinWave.generateSound()
    ), WAVE(
        high = HighSquareWave.generateSound(), mid = MidSquareWave.generateSound(), low = LowSqureWave.generateSound()
    );

    companion object {
        fun initialize() {
            values()
        }
    }



}