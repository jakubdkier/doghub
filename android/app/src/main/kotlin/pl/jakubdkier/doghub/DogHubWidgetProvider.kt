package pl.jakubdkier.doghub

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.view.View
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

/** 4×2 widget: last entries, food stock, health alert and quick-add buttons. */
class DogHubWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        for (id in appWidgetIds) {
            appWidgetManager.updateAppWidget(id, build(context, widgetData))
        }
    }

    private fun build(context: Context, data: SharedPreferences): RemoteViews {
        val views = RemoteViews(context.packageName, R.layout.widget_large)
        val ready = data.flag(WidgetKeys.READY)

        views.setOnClickPendingIntent(R.id.widget_root, launch(context, "doghub://today"))
        views.setViewVisibility(R.id.widget_empty, if (ready) View.GONE else View.VISIBLE)
        views.setViewVisibility(R.id.widget_content, if (ready) View.VISIBLE else View.GONE)
        if (!ready) return views

        views.setTextViewText(R.id.widget_dog, data.text(WidgetKeys.DOG))
        views.setTextViewText(R.id.widget_meal_ago, formatAgo(context, data.millis(WidgetKeys.MEAL_AT)))
        views.setTextViewText(R.id.widget_poop_ago, formatAgo(context, data.millis(WidgetKeys.POOP_AT)))
        views.setTextViewText(R.id.widget_walk_ago, formatAgo(context, data.millis(WidgetKeys.WALK_AT)))

        line(context, views, R.id.widget_food, data.text(WidgetKeys.FOOD), data.flag(WidgetKeys.FOOD_LOW))
        line(context, views, R.id.widget_health, data.text(WidgetKeys.HEALTH), data.flag(WidgetKeys.HEALTH_ALERT))
        line(context, views, R.id.widget_meds, data.text(WidgetKeys.MEDS), data.flag(WidgetKeys.MEDS_ALERT))
        views.setViewVisibility(
            R.id.widget_info,
            if (data.text(WidgetKeys.FOOD).isEmpty() && data.text(WidgetKeys.HEALTH).isEmpty()) View.GONE else View.VISIBLE,
        )

        views.setOnClickPendingIntent(R.id.widget_btn_meal, quickAdd(context, "meal"))
        views.setOnClickPendingIntent(R.id.widget_btn_poop, quickAdd(context, "poop"))
        views.setOnClickPendingIntent(R.id.widget_btn_pee, quickAdd(context, "pee"))
        views.setOnClickPendingIntent(R.id.widget_btn_walk, quickAdd(context, "walk"))
        views.setOnClickPendingIntent(R.id.widget_btn_note, quickAdd(context, "note"))
        return views
    }

    private fun line(context: Context, views: RemoteViews, id: Int, text: String, alert: Boolean) {
        views.setViewVisibility(id, if (text.isEmpty()) View.GONE else View.VISIBLE)
        views.setTextViewText(id, if (alert) "⚠ $text" else text)
        views.setTextColor(
            id,
            context.getColor(if (alert) R.color.widget_alert else R.color.widget_text_secondary),
        )
    }
}
