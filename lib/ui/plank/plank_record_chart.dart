import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/ui/plank/plank_view_model.dart';

class PlankRecordChart extends ConsumerWidget {
  const PlankRecordChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PlankContent plankContent = ref.watch(plankDataProvider);
    return Center(
      child: SizedBox(
        height: MediaQuery
            .of(context)
            .size
            .width,
        width: MediaQuery
            .of(context)
            .size
            .width,
        //判断数据是否为空，为空则不限时Chart
        child: BarChart(
          BarChartData(
            barTouchData: _initBarTouchData(plankContent.chartDataList),
            titlesData: _initTitlesData(plankContent.chartDataList),
            borderData: borderData,
            barGroups: _initBarGroups(plankContent.chartDataList),
            gridData: FlGridData(show: false),
            alignment: BarChartAlignment.spaceAround,
            maxY: 20,
          ),
        ),
      ),
    );
  }

  BarTouchData _initBarTouchData(List<ChartData> chartDataList) =>
      BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.blueAccent,
          tooltipPadding: const EdgeInsets.all(2),
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,) {
            return BarTooltipItem(
              chartDataList[groupIndex].durationStr,
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData _initTitlesData(List<ChartData> chartDataList) =>
      FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: chartDataList
                .reduce(
                    (current, next) =>
                current.duration > next.duration
                    ? current
                    : next)
                .duration
                .toDouble() * 1.5,
            getTitlesWidget: (value, meta) =>
                SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 4.0,
                  child: Text(chartDataList[value.toInt()].dateStr,
                      style: const TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                ),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData =>
      FlBorderData(
        show: false,
      );

  final _barsGradient = const LinearGradient(
    colors: [
      Colors.lightBlueAccent,
      Colors.greenAccent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> _initBarGroups(List<ChartData> chartDataList) =>
      chartDataList
          .asMap()
          .entries
          .map((entry) =>
          BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.duration.toDouble(),
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ))
          .toList();
}
