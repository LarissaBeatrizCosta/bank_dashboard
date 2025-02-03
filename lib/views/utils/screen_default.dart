import 'package:flutter/material.dart';
import 'package:viacred_app/views/utils/colors.dart';

class ScreenDefault extends StatelessWidget {
  const ScreenDefault({super.key, required this.child});

  ///Widget child
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: ColorsHome().colorMap[11],
    );
    final _text = Text('Dashboard', style: _style);
    return Scaffold(
      appBar: AppBar(
        title: _text,
        automaticallyImplyLeading: false,
        backgroundColor: ColorsHome().colorMap[13],
      ),
      body: Stack(
        children: [
          _ImageBackground(),
          Container(
            child: child,
          ),
        ],
      ),
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
