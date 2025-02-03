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

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: (screenWidth > 600 ? screenHeight * 0.6 : screenHeight * 0.35),
        width: (screenWidth > 600 ? availableWidth * 1 : availableWidth * 1),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            maxY: 5.0,
            groupsSpace: 40,
            barGroups: [
              _barGroup(0, 5),
              _barGroup(1, 3.5),
              _barGroup(2, 0.5),
            ],
            gridData: _grid(),
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: _titles(),
            barTouchData: _touch(),
          ),
        ),
      ),
    );
  }
}

BarChartGroupData _barGroup(int x, double y) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: y,
        color: ColorsHome().colorMap[15],
        width: 40,
        borderRadius: BorderRadius.circular(6),
      ),
    ],
  );
}

FlGridData _grid() {
  return FlGridData(
    drawHorizontalLine: true,
    drawVerticalLine: false,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: Colors.grey,
        strokeWidth: 0.8,
        dashArray: [6, 6],
      );
    },
  );
}

FlTitlesData _titles() {
  final styleBottomBar = TextStyle(
    fontSize: 12,
    color: ColorsHome().colorMap[17],
  );

  final textAmbient = 'Ambiente';
  final textCollaborators = 'Colaboradores';
  final textTime = 'Espera';
  return FlTitlesData(
    topTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: false,
      ),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          switch (value.toInt()) {
            case 0:
              return Text(
                textAmbient,
                style: styleBottomBar,
              );
            case 1:
              return Text(
                textCollaborators,
                style: styleBottomBar,
              );
            case 2:
              return Text(
                textTime,
                style: styleBottomBar,
              );
            default:
              return Text('');
          }
        },
      ),
    ),
  );
}

BarTouchData _touch() {
  final style = TextStyle(
    color: ColorsHome().colorMap[11],
    fontWeight: FontWeight.w500,
  );
  return BarTouchData(
    touchTooltipData: BarTouchTooltipData(
      tooltipPadding: EdgeInsets.only(top: 2, left: 9, right: 9),
      getTooltipColor: (group) {
        return ColorsHome().colorMap[15] ?? Colors.green;
      },
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        return BarTooltipItem(
          'Média: ${rod.toY}',
          style,
        );
      },
    ),
  );
}
