import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool passwordObscure = true;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  Future login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 2));

    loading = false;

    loggedIn = true;

    email = '';

    password = '';
  }

  @action
  Future logout() async {
    loggedIn = false;
  }

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  togglePasswordVisibility() => passwordObscure = !passwordObscure;

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(email);
  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @computed
  dynamic get loginPressed => isFormValid && !loading ? login : null;
}
