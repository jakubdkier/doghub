package pl.jakubdkier.doghub

import android.app.PendingIntent
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import java.util.Calendar

/** Keys written by the app (lib/features/home_widget/domain/widget_snapshot.dart). */
object WidgetKeys {
    const val READY = "dh_ready"
    const val DOG = "dh_dog"
    const val MEAL_AT = "dh_meal_at"
    const val POOP_AT = "dh_poop_at"
    const val WALK_AT = "dh_walk_at"
    const val FOOD = "dh_food"
    const val FOOD_LOW = "dh_food_low"
    const val HEALTH = "dh_health"
    const val HEALTH_ALERT = "dh_health_alert"
}

internal fun SharedPreferences.text(key: String): String = getString(key, null) ?: ""

internal fun SharedPreferences.flag(key: String): Boolean = text(key) == "1"

internal fun SharedPreferences.millis(key: String): Long? = text(key).toLongOrNull()

/** Opens the app at [uri] (doghub://quick-add?type=…, doghub://today). */
internal fun launch(context: Context, uri: String): PendingIntent =
    HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java, Uri.parse(uri))

internal fun quickAdd(context: Context, type: String): PendingIntent =
    launch(context, "doghub://quick-add?type=$type")

/**
 * "przed chwilą", "25 min temu", "3 h temu" (under 24 h), then calendar days:
 * "wczoraj", "4 dni temu". Mirrors formatAgo() in event_labels.dart.
 */
internal fun formatAgo(context: Context, at: Long?, now: Long = System.currentTimeMillis()): String {
    if (at == null) return context.getString(R.string.widget_none)
    val minutes = (now - at) / 60_000
    if (minutes < 1) return context.getString(R.string.widget_just_now)
    if (minutes < 60) return context.getString(R.string.widget_minutes_ago, minutes)
    val hours = minutes / 60
    if (hours < 24) return context.getString(R.string.widget_hours_ago, hours)
    val days = calendarDaysBetween(at, now)
    return if (days <= 1) {
        context.getString(R.string.widget_yesterday)
    } else {
        context.getString(R.string.widget_days_ago, days)
    }
}

private fun calendarDaysBetween(from: Long, to: Long): Long {
    fun startOfDay(t: Long) = Calendar.getInstance().apply {
        timeInMillis = t
        set(Calendar.HOUR_OF_DAY, 0)
        set(Calendar.MINUTE, 0)
        set(Calendar.SECOND, 0)
        set(Calendar.MILLISECOND, 0)
    }.timeInMillis
    // Round to absorb DST shifts of an hour.
    return Math.round((startOfDay(to) - startOfDay(from)) / 86_400_000.0)
}
