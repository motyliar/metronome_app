package com.example.metronome.wave

abstract class TableWaveGenerator(frequency: Double, time: Int) {



    protected val frequency = frequency
    protected val time = time
    protected val sampleRate = 44100
    protected val amplitude = Short.MAX_VALUE
     abstract fun generateSound(): ShortArray

    protected fun timeCalculator(): Int {
        return sampleRate / time

    }
}


