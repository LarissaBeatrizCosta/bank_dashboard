import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/container_background.dart';

///Grafico de barras das avaliações com estrelas
class BarGraph extends StatelessWidget {
  ///Construtor
  const BarGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final text = 'Indicadores de Satisfação';
    final icon = Icons.bar_chart;
    return ContainerBackground(
      heightValueDesktop: 0.8,
      heightValueMobile: 0.5,
      widthValueDesktop: 1,
      widthValueMobile: 1,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: _TitleGraph(text, icon),
    );
  }
}

class _TitleGraph extends StatelessWidget {
  const _TitleGraph(this.text, this.icon);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final color = ColorsHome().colorMap[15];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon, color: color),
              ),
              Text(
                text,
                style: style,
              ),
            ],
          ),
        ),
        _BuilderGraph(),
      ],
    );
  }
}

class _BuilderGraph extends StatelessWidget {
  const _BuilderGraph();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var availableWidth = screenWidth - 40;

    final style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: (screenWidth > 600 ? screenHeight * 0.6 : screenHeight * 0.2),
        width: (screenWidth > 600 ? availableWidth * 1 : availableWidth * 1),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            maxY: 5.0,
            groupsSpace: 50,
            barGroups: [
              _BarGroup(3, 5),
              _BarGroup(3, 5),
            ],
            gridData: FlGridData(
              drawHorizontalLine: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 0.8,
                  dashArray: [6, 6],
                );
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                tooltipPadding:
                    EdgeInsets.only(top: 2, left: 9, right: 9),
                getTooltipColor: (group) {
                  return ColorsHome().colorMap[16] ?? Colors.green;
                },
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    'Média: ${rod.toY}',
                    style,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

BarChartGroupData _BarGroup(int x, double y) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: ColorsHome().colorMap[16],
        width: 18,
        borderRadius: BorderRadius.circular(6),
      ),
    ],
  );
}
