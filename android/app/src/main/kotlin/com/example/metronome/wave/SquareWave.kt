package com.example.metronome.wave

import kotlin.math.sign
import kotlin.math.sin

open class SquareWave(frequency: Double, time: Int) : TableWaveGenerator(frequency, time) {

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

object HighSquareWave: SquareWave(frequency = 640.0, time =  10)
object MidSquareWave: SquareWave(frequency = 540.0, time = 10)
object LowSquareWave: SquareWave(frequency = 440.0, time = 10)
