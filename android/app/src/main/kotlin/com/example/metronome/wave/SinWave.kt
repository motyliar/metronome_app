package com.example.metronome.wave

import kotlin.math.sin

class SinWave(frequency: Double, time: Int) : TableWaveGenerator(frequency, time) {

    override fun generateSound(): ShortArray {
            val numSamples = timeCalculator()
            var wave = ShortArray(numSamples)

            for(i in 0 until numSamples) {
                val sample = (amplitude * sin(2 * Math.PI * frequency * i) / sampleRate).toInt()
                wave[i] = sample.toShort()
            }
        return wave


    }


}