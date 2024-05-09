package com.example.metronome.wave

import kotlin.math.sign
import kotlin.math.sin

class SquareWave(frequency: Double, time: Int) : TableWaveGenerator(frequency, time) {

    override fun generateSound(): ShortArray {
        val numSample = timeCalculator()
        val wave = ShortArray(numSample)

        for(i in 0 until numSample) {
            val sample = (amplitude * sign(sin((Math.PI * 2 * frequency) * i / sampleRate)) ) .toInt()
            wave[i] = sample.toShort()
        }
        return wave
    }
}