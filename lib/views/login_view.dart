import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/constants.dart';

///Tela de login
class LoginView extends StatelessWidget {
  ///Construtor
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];

    return SignInScreen(
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

            // ignore: use_build_context_synchronously
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ],
    );
  }
}
