package com.example.metronome.player

import android.media.AudioAttributes
import android.media.AudioFormat
import android.media.AudioTrack
import java.lang.NullPointerException

class MetronomePlayer : Player {

    init {
        initPlayer()
    }
    private var audioTrack: AudioTrack? = null
    private val sampleRate: Int = 44100
    private val bufferSize = AudioTrack.getMinBufferSize(sampleRate, AudioFormat.CHANNEL_OUT_MONO, AudioFormat.ENCODING_PCM_16BIT)
    private val playing = AudioTrack.PLAYSTATE_PLAYING
    override fun initPlayer() {
        if(audioTrack == null) {
            audioTrack = AudioTrack.Builder()
                .setAudioAttributes(
                    AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build())
                .setAudioFormat(
                    AudioFormat.Builder()
                    .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                    .setSampleRate(sampleRate)
                    .setChannelMask(AudioFormat.CHANNEL_OUT_MONO)
                    .build())
                .setBufferSizeInBytes(bufferSize)
                .setTransferMode(AudioTrack.MODE_STREAM)

                .build()
        }
    }

    override fun play(sound: ShortArray) {
        if(audioTrack == null) {
            initPlayer()
        }
        Thread {
            audioTrack?.play()

            audioTrack?.write(sound, 0, sound.size)
        }.start()
    }

    override fun isPlay(): Boolean {
        val state =  audioTrack?.playState
        return state == playing
    }

}