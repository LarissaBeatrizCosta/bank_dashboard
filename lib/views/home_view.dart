import 'package:flutter/material.dart';
import 'utils/colors.dart';
import 'utils/screen_default.dart';

///Tela inicial
class HomeView extends StatelessWidget {
  ///Key da tela inicial do app
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return _Body();
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return ScreenDefault(
      child: Column(
        children: (screenWidth > 600
            ? [
                Row(
                  children: [
                    _CurveGraph(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _BarGraph(),
                    _PieGraph(),
                  ],
                ),
              ]
            : [
                Column(
                  children: [
                    _CurveGraph(),
                    _BarGraph(),
                    _PieGraph(),
                  ],
                ),
              ]),
      ),
    );
  }
}

class _ContainerBackground extends StatelessWidget {
  const _ContainerBackground(this.heightValueDesktop, this.heightValueMobile,
      this.widthValueDesktop, this.widthValueMobile);

  final double heightValueDesktop;
  final double heightValueMobile;
  final double widthValueDesktop;
  final double widthValueMobile;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var availableWidth = screenWidth - 40;

    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 2),
      height: (screenWidth > 600
          ? screenHeight * heightValueDesktop
          : screenHeight * heightValueMobile),
      width: (screenWidth > 600
          ? availableWidth * widthValueDesktop
          : availableWidth * widthValueMobile),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorsHome().colorMap[13] ?? Colors.grey,
            blurRadius: 0.5,
          ),
        ],
        color: ColorsHome().colorMap[11],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class _CurveGraph extends StatelessWidget {
  const _CurveGraph();

  @override
  Widget build(BuildContext context) {
    return _ContainerBackground(0.4, 0.3, 1, 1);
  }
}

class _BarGraph extends StatelessWidget {
  const _BarGraph();

  @override
  Widget build(BuildContext context) {
    return _ContainerBackground(0.2, 0.28, 0.495, 1);
  }
}

class _PieGraph extends StatelessWidget {
  const _PieGraph();

  @override
  Widget build(BuildContext context) {
    return _ContainerBackground(0.2, 0.28, 0.495, 1);
  }
}
