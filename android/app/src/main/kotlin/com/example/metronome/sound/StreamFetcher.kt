package com.example.metronome.sound

import android.content.Context
import com.example.metronome.R
import java.io.InputStream

class StreamFetcher(val context: Context): IStreamFetcher {

    override fun fetch(): List<InputStream> {
        var inputs: MutableList<InputStream> = mutableListOf(
            context.resources.openRawResource(R.raw.tambourinehigh),
            context.resources.openRawResource(R.raw.tambourinelow2),

        )

        return inputs

    }
}