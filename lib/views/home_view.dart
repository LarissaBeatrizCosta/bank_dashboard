import 'package:flutter/material.dart';
import 'utils/screen_default.dart';
import 'widgets/bar_graph.dart';
import 'widgets/list_view_rents.dart';
import 'widgets/pie_graph.dart';

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
                    BarGraph(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PieGraph(),
                    ListViewRents(),
                  ],
                ),
              ]
            : [
                Column(
                  children: [
                    BarGraph(),
                    PieGraph(),
                    ListViewRents(),
                  ],
                ),
              ]),
      ),
    );
  }
}
