import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/filter_controller.dart';
import 'colors.dart';

///Button que abre modal de filtros
class Filters extends StatelessWidget {
  Filters({super.key});

  final text = Text(
    'Filtros',
    style: TextStyle(
      fontSize: 14,
      color: ColorsHome.colorMap[17],
    ),
  );

  final style = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    side: BorderSide(
      color: ColorsHome.colorMap[13] ?? Colors.grey,
    ),
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  );

  @override
  Widget build(BuildContext context) {
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
                return _Modal();
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
    return ChangeNotifierProvider(
      create: (context) => FilterController(),
      child: AlertDialog(
        backgroundColor: ColorsHome.colorMap[11],
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: text,
        content: _SizedBox(),
      ),
    );
  }
}

class _SizedBox extends StatelessWidget {
  const _SizedBox();

  @override
  Widget build(BuildContext context) {
    final filterController = Provider.of<FilterController>(context);

    return FutureBuilder(
      future: filterController.buildItem(),
      builder: (context, item) {
        final cooperatives = item.data ?? [];
        return SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DropDown(
                icon: Icons.calendar_today,
                text: 'Período',
                listItem: [],
                fuction: (newValue) {},
              ),
              _DropDown(
                icon: Icons.business,
                text: 'Agência',
                listItem: cooperatives,
                fuction: (newValue) {
                  filterController.updateCooperativeSelected(newValue);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DropDown extends StatelessWidget {
  const _DropDown({
    required this.icon,
    required this.text,
    required this.fuction,
    required this.listItem,
  });

  final IconData icon;
  final String text;
  final Function fuction;
  final List<DropdownMenuItem> listItem;

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
          color: ColorsHome.colorMap[13],
        ),
        child: DropdownButtonFormField(
          isExpanded: true,
          icon: Icon(icon),
          hint: Text(
            text,
            style: style,
          ),
          items: listItem,
          onChanged: (_) {
            fuction;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: ColorsHome.colorMap[11],
          ),
        ),
      ),
    );
  }
}
