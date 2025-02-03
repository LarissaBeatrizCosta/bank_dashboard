import 'package:flutter/material.dart';

import 'colors.dart';

///Tela default da dash
class ScreenDefault extends StatelessWidget {
  ///Construtor
  const ScreenDefault({super.key, required this.child});

  ///Widget child
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final style = TextStyle(
      fontSize: (screenWidth > 600 ? 23 : 20),
      fontWeight: FontWeight.bold,
      color: ColorsHome().colorMap[11],
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
        backgroundColor: ColorsHome().colorMap[13],
      ),
      body: _Body(child: child),
    );
  }
}

class _ImageBackground extends StatelessWidget {
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
        Container(
          child: child,
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row();

  @override
  Widget build(BuildContext context) {
    var nomeProvisorio = 'Nome provisório';
    var screenWidth = MediaQuery.of(context).size.width;
    final style = TextStyle(
      fontSize: 14,
      color: ColorsHome().colorMap[11],
    );

    final text = Text(
      'Bem vindo \n$nomeProvisorio',
      textAlign: TextAlign.start,
      style: style,
    );

    return Row(
      children: [
        text,
      ],
    );
  }
}
