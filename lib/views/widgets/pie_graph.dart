import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/container_background.dart';

///Grafico de pizza das avaliações de indicação
class PieGraph extends StatelessWidget {
  ///Construtor
  const PieGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final text = 'Índice de Recomendação';
    final icon = Icons.pie_chart;
    return ContainerBackground(
      heightValueDesktop: 0.65,
      heightValueMobile: 0.55,
      widthValueDesktop: 0.495,
      widthValueMobile: 1,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: _Graph(text, icon),
    );
  }
}

class _Graph extends StatelessWidget {
  const _Graph(this.text, this.icon);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    final color = ColorsHome.colorMap[15];
    final sections = pieChart();

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
              Text(text, style: style),
            ],
          ),
        ),
        _BuilderGraph(sections: sections),
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: _Legend(sections: sections),
        ),
      ],
    );
  }
}

class _BuilderGraph extends StatelessWidget {
  const _BuilderGraph({required this.sections});

  final List<PieChartSectionData> sections;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var availableWidth = screenWidth - 40;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: (screenWidth > 600 ? screenHeight * 0.3 : screenHeight * 0.20),
        width: (screenWidth > 600 ? availableWidth * 1 : availableWidth * 1),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return PieChart(
              PieChartData(
                sections: sections,
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Pedaços do gráfico
List<PieChartSectionData> pieChart() {
  return List.generate(
    11,
    (i) {
      double value = 10;
      var title = '${(i - 1) + 1} ';
      var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];

      return PieChartSectionData(
        value: value,
        title: title,
        color: color,
        titleStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        radius: 50,
      );
    },
  );
}

class _Legend extends StatelessWidget {
  const _Legend({required this.sections});

  final List<PieChartSectionData> sections;

  @override
  Widget build(BuildContext context) {
    final middleIndex = (sections.length / 2).ceil();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              sections.sublist(0, middleIndex).map(_buildLegendItem).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              sections.sublist(middleIndex).map(_buildLegendItem).toList(),
        ),
      ],
    );
  }

  Widget _buildLegendItem(PieChartSectionData section) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: section.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            section.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
