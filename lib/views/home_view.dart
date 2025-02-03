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
                )
              ]
            : [
                Column(
                  children: [
                    _CurveGraph(),
                  ],
                )
              ]),
      ),
    );
  }
}

class _CurveGraph extends StatelessWidget {
  const _CurveGraph();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    var availableWidth = screenWidth - 40;

    return Container(
      height: (screenWidth > 600 ? screenHeight * 0.4 : screenHeight * 0.3),
      width: (screenWidth > 600 ? availableWidth * 1 : availableWidth * 1),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorsHome().colorMap[13] ?? Colors.grey,
              blurRadius: 0.5,
            ),
          ],
          color: ColorsHome().colorMap[11],
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
