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
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Text('Legenda'),
        ),
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
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: (screenWidth > 600 ? screenHeight * 0.3 : screenHeight * 0.20),
        width: (screenWidth > 600 ? availableWidth * 1 : availableWidth * 1),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return PieChart(
              PieChartData(
                sections: pieChart(),
              ),
            );
          },
        ),
      ),
    );
  }
}

///Pedaços do grafico
List<PieChartSectionData> pieChart() {
  return List.generate(
    5,
    (i) {
      double value = 10;
      var title = 'teste';
      var color = ColorsHome.colorMap[16];
      return PieChartSectionData(
        value: value,
        title: title,
        color: color,
        titleStyle: TextStyle(
          color: ColorsHome.colorMap[11],
        ),
        radius: 50,
      );
    },
  );
}
