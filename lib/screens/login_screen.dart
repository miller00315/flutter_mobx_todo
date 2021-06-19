import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todomobx/stores/login_store.dart';
import 'package:todomobx/widgets/custom_icon_button.dart';
import 'package:todomobx/widgets/custom_text_field.dart';

import 'list_screen.dart';
import 'list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginStore? loginStore;

  ReactionDisposer? disposer;

  @override
  void didChangeDependencies() {
    loginStore = Provider.of<LoginStore>(context);
    
    super.didChangeDependencies();

    disposer = reaction((_) => loginStore?.loggedIn, (loggedIn) {
      if (loginStore?.loggedIn ?? false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ListScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposer?.call();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Observer(
                      builder: (_) => CustomTextField(
                        hint: 'E-mail',
                        prefix: Icon(Icons.account_circle),
                        textInputType: TextInputType.emailAddress,
                        onChanged: loginStore?.setEmail,
                        enabled: !(loginStore?.loading ?? true),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (_) => CustomTextField(
                      hint: 'Senha',
                      prefix: Icon(Icons.lock),
                      obscure: (loginStore?.passwordObscure ?? true),
                      onChanged: loginStore?.setPassword,
                      enabled: !(loginStore?.loading ?? false),
                      suffix: CustomIconButton(
                        radius: 32,
                        iconData: (loginStore?.passwordObscure ?? true)
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onTap: loginStore?.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Observer(
                    builder: (context) => SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        child: (loginStore?.loading ?? false)
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Theme.of(context)
                                  .primaryColor
                                  .withAlpha(50);
                            }

                            if (states.contains(MaterialState.disabled)) {
                              return Theme.of(context)
                                  .primaryColor
                                  .withAlpha(100);
                            }

                            return Theme.of(context).primaryColor;
                          }),
                        ),
                        onPressed: loginStore?.loginPressed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
