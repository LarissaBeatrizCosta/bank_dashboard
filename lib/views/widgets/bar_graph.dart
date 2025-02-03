import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/dashboard_bar_graph_controller.dart';
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
        child: LayoutBuilder(builder: (context, constraints) {
          final barsSpace = 4 * constraints.maxWidth / 1300;
          final barsSpaceGeneral = 16 * constraints.maxWidth;
          final barsWidth = (11 * constraints.maxWidth / 160) / (1.5);

          return BarChart(
            BarChartData(
              groupsSpace: barsSpaceGeneral,
              alignment: BarChartAlignment.center,
              maxY: 5.0,
              gridData: _grid(),
              borderData: FlBorderData(
                show: false,
              ),
              titlesData: _titles(),
              barTouchData: _touch(),
              barGroups: _getBarGroups(
                barsWidth,
                barsSpace,
                context,
              ),
            ),
          );
        }),
      ),
    );
  }
}

List<BarChartGroupData> _getBarGroups(
  double barsWidth,
  double barsSpace,
  BuildContext context,
) {
  final state = Provider.of<DashboardState>(
    context,
    listen: false,
  );

  if (MediaQuery.sizeOf(context).width < 728) {
    return [
      if (state.companies.isNotEmpty)
        for (final (i, it) in state.companies.first.rates.indexed)
          BarChartGroupData(
            x: i,
            barsSpace: barsSpace,
            barRods: [
              BarChartRodData(
                color: state.companies.first.color,
                toY: it.value,
                width: barsWidth,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
              ),
            ],
          )
    ];
  }
  if (MediaQuery.sizeOf(context).width < 1000) {
    return [
      if (state.companies.length >= 2)
        for (var index = 0; index < 2; index++)
          for (final (i, it) in state.companies[index].rates.indexed)
            BarChartGroupData(
              x: i,
              barsSpace: barsSpace,
              barRods: [
                BarChartRodData(
                  color: state.companies[index].color,
                  toY: it.value,
                  width: barsWidth,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
              ],
            )
    ];
  }

  return [
    for (final (_, item) in state.companies.indexed)
      for (final (i, it) in item.rates.indexed)
        BarChartGroupData(
          x: i,
          barsSpace: barsSpace,
          barRods: [
            BarChartRodData(
              color: item.color,
              toY: it.value,
              width: barsWidth,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
          ],
        )
  ];
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
        return ColorsHome().colorMap[14] ?? Colors.green;
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
