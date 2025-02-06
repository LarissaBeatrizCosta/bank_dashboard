import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/dashboard_bar_graph_controller.dart';
import 'colors.dart';

///Button que abre modal de filtros
class Filters extends StatelessWidget {
  ///Construtor
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    ///Texto do button
    final text = Text(
      'Filtros',
      style: TextStyle(
        fontSize: 14,
        color: ColorsHome.colorMap[17],
      ),
    );

    ///Estilo do button
    final style = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      side: BorderSide(
        color: ColorsHome.colorMap[13] ?? Colors.grey,
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    );

    final state = Provider.of<DashboardState>(context);

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: TextButton(
          style: style,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return ChangeNotifierProvider.value(
                  value: state,
                  child: _Modal(),
                );
              },
            );
          },
          child: text,
        ),
      ),
    );
  }
}

class _Modal extends StatelessWidget {
  const _Modal();

  @override
  Widget build(BuildContext context) {
    final text = Text(
      'Filtrar Dados',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorsHome.colorMap[17],
      ),
    );

    return AlertDialog(
      backgroundColor: ColorsHome.colorMap[11],
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: text,
      content: _ContentDialog(),
    );
  }
}

class _ContentDialog extends StatelessWidget {
  const _ContentDialog();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<DashboardState>(context);

    final style = TextStyle(
      color: Colors.black,
      fontSize: 16,
    );

    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DropDown(
            icon: Icons.calendar_today,
            text: 'Período',
            listItem: [],
            onChange: (_) {},
            value: null,
          ),
          _DropDown<String?>(
            value: state.selectedCompany?.idCooperative,
            icon: Icons.business,
            text: 'Agência',
            listItem: [
              DropdownMenuItem(
                value: '',
                child: Text(
                  'Todos',
                  style: style,
                ),
              ),
              for (final item in state.mainsCompanies)
                DropdownMenuItem(
                  value: item.idCooperative,
                  child: Text(
                    item.name,
                    style: style,
                  ),
                ),
            ],
            onChange: (item) {
              state.getCooperativeId(item);
            },
          ),
        ],
      ),
    );
  }
}

class _DropDown<T> extends StatelessWidget {
  const _DropDown({
    required this.icon,
    required this.text,
    required this.onChange,
    required this.listItem,
    required this.value,
  });

  final IconData icon;
  final String text;
  final ValueChanged<dynamic>? onChange;
  final List<DropdownMenuItem<T>> listItem;
  final T value;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 16,
      color: ColorsHome.colorMap[17],
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorsHome.colorMap[15],
          boxShadow: [
            BoxShadow(
              color: ColorsHome.colorMap[14] ?? Colors.grey,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          icon: Icon(
            icon,
            color: ColorsHome.colorMap[16],
          ),
          hint: Text(
            text,
            style: style,
          ),
          items: listItem,
          onChanged: onChange,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: ColorsHome.colorMap[11],
          ),
        ),
      ),
    );
  }
}
