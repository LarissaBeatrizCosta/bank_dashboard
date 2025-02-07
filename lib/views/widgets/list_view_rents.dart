import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/dashboard_bar_graph_controller.dart';
import '../utils/colors.dart';
import '../utils/container_background.dart';

/// ListView das 10 avaliações recentes
class ListViewRents extends StatelessWidget {
  /// Construtor
  const ListViewRents({super.key});

  @override
  Widget build(BuildContext context) {
    final text = 'Avaliações Recentes';
    final icon = Icons.list;

    final state = Provider.of<DashboardState>(context, listen: false);

    if (state.rateList.isEmpty) {
      state.getRates();
    }

    return ContainerBackground(
      heightValueDesktop: 0.65,
      heightValueMobile: 0.45,
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
        _BuilderList(),
      ],
    );
  }
}

class _BuilderList extends StatelessWidget {
  const _BuilderList();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DashboardState>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var availableWidth = screenWidth - 40;

    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: SizedBox(
        height: (screenWidth > 600 ? screenHeight * 0.5 : screenHeight * 0.35),
        width: availableWidth,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return state.rateList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: state.rateList.length,
                    itemBuilder: (context, index) {
                      final cooperatives = state.rateList[index];
                      return Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        elevation: 4,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            cooperatives.cpfValue,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
