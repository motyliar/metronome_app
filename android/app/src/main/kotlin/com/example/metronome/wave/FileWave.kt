package com.example.metronome.wave

import android.content.Context
import android.content.res.Resources
import com.example.metronome.R
import java.io.InputStream

class FileWave(val inputs: List<InputStream>) {

    fun getLE2(buffer: ByteArray): Long {
        var value = ((buffer[1]).toInt() and 0xff)
        value = (value shl 8) + (buffer[0].toInt() and 0xFF)
        return value.toLong()
    }

    fun readAudioToArray(): List<ShortArray> {
        var waves: MutableList<ShortArray> = mutableListOf()
        val headersSize = 44
        val readInitPosition = 0
        val pcmSize = 2


        for(inputStream in inputs) {
        var waveOut = mutableListOf<Short>()

        var read: Int = readInitPosition
        var headers: ByteArray = ByteArray(headersSize)
        read = inputStream.read(headers, 0, headers.size )

        var pcm = ByteArray(pcmSize)
        var longTmp: Long? = null
        while (read != -1) {
            read = inputStream.read(pcm, 0, pcm.size)
            longTmp = getLE2(pcm)
            waveOut.add(longTmp.toShort())
        }
        inputStream.close()

        waves.add(waveOut.toShortArray())
        }
        return waves
    }
}