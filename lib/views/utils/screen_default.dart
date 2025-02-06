import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/home_controller.dart';
import 'colors.dart';

///Tela default da dash
class ScreenDefault extends StatelessWidget {
  ///Construtor
  const ScreenDefault({super.key, required this.child});

  ///Widget child
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    final style = TextStyle(
      fontSize: (screenWidth > 600 ? 23 : 20),
      fontWeight: FontWeight.bold,
      color: ColorsHome.colorMap[11],
    );
    final text = Padding(
      padding: (screenWidth > 600 ? EdgeInsets.all(20) : EdgeInsets.all(8)),
      child: Text('Dashboard', style: style),
    );
    return Scaffold(
      appBar: AppBar(
        title: text,
        actions: screenWidth > 600
            ? [
                _Row(),
                Container(
                  margin: const EdgeInsets.only(
                      left: 50, right: 30, top: 5, bottom: 5),
                  child: Image.asset(
                    'assets/images/logo_white2.png',
                    fit: BoxFit.contain,
                    height: 500,
                    width: 100,
                  ),
                )
              ]
            : null,
        automaticallyImplyLeading: false,
        backgroundColor: ColorsHome.colorMap[13],
      ),
      body: _Body(child: child),
    );
  }
}

class _ImageBackground extends StatelessWidget {
  const _ImageBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ImageBackground(),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row();

  @override
  Widget build(BuildContext context) {
    ///Banco controller
    final state = Provider.of<HomeController>(context);
    var nameUser = state.userName;

    final style = TextStyle(
      fontSize: 14,
      color: ColorsHome.colorMap[11],
    );

    final text = RichText(
      text: TextSpan(
        style: style,
        text: 'Bem vindo,',
        children: [
          TextSpan(
            text: ' \n$nameUser',
            style: style.copyWith(
              fontSize: 16,
              color: ColorsHome.colorMap[15],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    return text;
  }
}
