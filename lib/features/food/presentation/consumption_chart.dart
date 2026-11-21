import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

/// Daily grams as bars, oldest left; dates labelled weekly.
class ConsumptionChart extends StatelessWidget {
  const ConsumptionChart({super.key, required this.days});

  final List<({DateTime day, int grams})> days;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme.labelSmall;
    final maxGrams = days.fold(0, (m, d) => d.grams > m ? d.grams : m);
    return SizedBox(
      height: 160,
      child: BarChart(
        BarChartData(
          maxY: maxGrams == 0 ? 100 : maxGrams * 1.15,
          alignment: BarChartAlignment.spaceBetween,
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(drawVerticalLine: false),
          barTouchData: const BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (v, meta) => v == meta.max
                    ? const SizedBox.shrink()
                    : Text(meta.formattedValue, style: style),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (v, _) {
                  final i = v.toInt();
                  // Label every 7th day counting back from today.
                  if ((days.length - 1 - i) % 7 != 0) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    DateFormat('d.MM').format(days[i].day),
                    style: style,
                  );
                },
              ),
            ),
          ),
          barGroups: [
            for (final (i, d) in days.indexed)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: d.grams.toDouble(),
                    color: scheme.primary,
                    width: 6,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
