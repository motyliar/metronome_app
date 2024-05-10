package com.example.metronome.player

interface Player {
     abstract fun initPlayer()
    abstract fun play(sound: ShortArray)
    abstract fun isPlay() : Boolean
}