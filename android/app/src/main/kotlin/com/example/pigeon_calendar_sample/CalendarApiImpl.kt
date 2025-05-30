package com.example.pigeon_calendar_sample

import android.os.Build

class CalendarApiImpl : CalendarApi {
    override fun getPlatformVersion(): String {
        return "Android ${Build.VERSION.RELEASE}"
    }
}
