import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constants.dart';

///Tela de login
class LoginView extends StatefulWidget {
  ///Construtor
  const LoginView({super.key});

  @override

  ///Construtor
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Constants.userKey);

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return _Body();
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return SignInScreen(
      sideBuilder: (context, constraints) {
        return Image.asset(
          'assets/images/favicon.jpg',
          height: constraints.maxHeight,
          width: constraints.maxWidth,
        );
      },
      providers: providers,
      actions: [
        AuthStateChangeAction<SignedIn>(
          (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final token = await state.user?.getIdToken();
            if (token == null) {
              return;
            }
            prefs.setString(Constants.userKey, token);
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        AuthStateChangeAction<UserCreated>((context, state) {
          Navigator.pushReplacementNamed(context, '/login');
        }),
      ],
    );
  }
}
