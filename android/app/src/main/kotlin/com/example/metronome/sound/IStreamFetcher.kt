package com.example.metronome.sound

import java.io.InputStream

interface IStreamFetcher {
    abstract fun fetch(): List<InputStream>
}