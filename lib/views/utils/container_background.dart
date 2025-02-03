import 'package:flutter/material.dart';

import 'colors.dart';

///Container default que envolve todos os graficos
class ContainerBackground extends StatelessWidget {
  ///Construtor
  const ContainerBackground({super.key,
    required this.heightValueDesktop,
    required this.heightValueMobile,
    required this.widthValueDesktop,
    required this.widthValueMobile,
    required this.child, required this.margin,
  });

  ///Valor da altura do container no desktop
  final double heightValueDesktop;
  ///Valor da altura do container no mobile
  final double heightValueMobile;
  ///Valor da largura do container no desktop
  final double widthValueDesktop;
  ///Valor da largura do container no mobile
  final double widthValueMobile;
  ///Widget filho
  final Widget child;
  ///Valor da margem
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var availableWidth = screenWidth - 40;

    return Container(
      margin: margin,
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
      child: child,
    );
  }
}
