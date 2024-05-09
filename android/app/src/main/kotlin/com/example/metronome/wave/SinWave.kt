package com.example.metronome.wave

import kotlin.math.sin

 open class SinWave(frequency: Double, time: Int) : TableWaveGenerator(frequency, time) {

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


object HighSinWave: SinWave(frequency = 640.0, time =  10)
object MidSinWave: SinWave(frequency = 540.0, time = 10)
object LowSinWave: SinWave(frequency = 440.0, time = 10)

