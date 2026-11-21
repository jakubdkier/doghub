package pl.jakubdkier.doghub

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

/** 2×1 widget: quick-add buttons for meal, poop and walk. */
class DogHubSmallWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        for (id in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_small).apply {
                setOnClickPendingIntent(R.id.widget_btn_meal, quickAdd(context, "meal"))
                setOnClickPendingIntent(R.id.widget_btn_poop, quickAdd(context, "poop"))
                setOnClickPendingIntent(R.id.widget_btn_walk, quickAdd(context, "walk"))
            }
            appWidgetManager.updateAppWidget(id, views)
        }
    }
}
