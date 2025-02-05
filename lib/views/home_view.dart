import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/dashboard_bar_graph_controller.dart';
import '../controllers/home_controller.dart';
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
    final state = Provider.of<HomeController>(context);

    if (state.isLoading) {
      return SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return ChangeNotifierProvider<DashboardState>(
      create: (context) => DashboardState(),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;

    final state = Provider.of<DashboardState>(context);

    return ScreenDefault(
      child: Column(
        children: () {
          if (state.isLoading) {
            return [
              SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ];
          }

          if (screenWidth > 600) {
            return [
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
            ];
          }
          return [
            BarGraph(),
            PieGraph(),
            ListViewRents(),
          ];
        }(),
      ),
    );
  }
}
