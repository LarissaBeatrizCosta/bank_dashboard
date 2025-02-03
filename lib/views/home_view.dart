import 'package:flutter/material.dart';
import 'package:viacred_app/views/utils/screen_default.dart';

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
    return ScreenDefault(
      child: Column(),
    );
  }
}
