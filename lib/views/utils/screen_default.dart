import 'package:flutter/cupertino.dart';

class ScreenDefault extends StatelessWidget {
  const ScreenDefault({super.key, required this.child});

  ///Widget child
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
