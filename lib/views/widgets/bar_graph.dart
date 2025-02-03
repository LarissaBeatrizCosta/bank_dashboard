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
      ],
    );
  }
}

