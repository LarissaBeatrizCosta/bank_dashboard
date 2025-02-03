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
      heightValueDesktop: 0.43,
      heightValueMobile: 0.28,
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
