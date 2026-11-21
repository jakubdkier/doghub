import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/utils/formatting.dart';
import '../domain/weight_entry.dart';

/// Weight over time; x = days since the first point. Needs 2+ entries.
class WeightChart extends StatelessWidget {
  const WeightChart({
    super.key,
    required this.entries,
    this.height = 200,
    this.compact = false,
  });

  /// Oldest first.
  final List<WeightEntry> entries;
  final double height;

  /// Without axes and touch, for previews.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.labelSmall;
    final first = entries.first.at;
    double x(DateTime t) => t.difference(first).inHours / 24;
    final kgs = entries.map((e) => e.kg);
    final minKg = kgs.reduce((a, b) => a < b ? a : b);
    final maxKg = kgs.reduce((a, b) => a > b ? a : b);
    // Pad so a flat line isn't glued to an edge.
    final pad = ((maxKg - minKg) * 0.2).clamp(0.3, double.infinity);
    final span = x(entries.last.at);

    return SizedBox(
      height: height,
      child: LineChart(
        LineChartData(
          minY: (minKg - pad).floorToDouble().clamp(0, double.infinity),
          maxY: (maxKg + pad).ceilToDouble(),
          minX: 0,
          maxX: span == 0 ? 1 : span,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: !compact, drawVerticalLine: false),
          lineTouchData: LineTouchData(
            enabled: !compact,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (spots) => [
                for (final s in spots)
                  LineTooltipItem(
                    '${formatKg(s.y)} kg\n'
                    '${DateFormat.yMMMd().format(first.add(Duration(hours: (s.x * 24).round())))}',
                    TextStyle(color: scheme.onInverseSurface),
                  ),
              ],
            ),
          ),
          titlesData: compact
              ? const FlTitlesData(show: false)
              : FlTitlesData(
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      getTitlesWidget: (v, meta) =>
                          (v == meta.min || v == meta.max)
                          ? const SizedBox.shrink()
                          : Text(meta.formattedValue, style: style),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: span <= 0 ? 1 : span / 3,
                      getTitlesWidget: (v, meta) => Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          DateFormat('d.MM.yy').format(
                            first.add(Duration(hours: (v * 24).round())),
                          ),
                          style: style,
                        ),
                      ),
                    ),
                  ),
                ),
          lineBarsData: [
            LineChartBarData(
              spots: [for (final e in entries) FlSpot(x(e.at), e.kg)],
              color: scheme.primary,
              barWidth: 3,
              isCurved: entries.length > 2,
              preventCurveOverShooting: true,
              dotData: FlDotData(show: !compact && entries.length <= 30),
              belowBarData: BarAreaData(
                show: true,
                color: scheme.primary.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
