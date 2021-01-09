import 'package:cargoconveyers/UI/Helpers/CustomMaterialButton.dart';
import 'package:cargoconveyers/UI/Helpers/CustomTextFormFields.dart';
import 'package:cargoconveyers/UI/Reusable/CustomDialogErrorHandling.dart';
import 'package:cargoconveyers/businessLogics/viewModels/ProfileViewMode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final Function(bool) formVisible;
  LoginForm({
    Key key,
    @required this.formVisible,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Form(
        key: _loginFormKey,
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormFieldOther(
              controller: _emailController,
              hinttext: "Enter email",
            ),
            const SizedBox(height: 10.0),
            TextFormFieldPassword(
              hinttext: "Enter password",
              controller: _passwordController,
            ),
            const SizedBox(height: 10.0),
            CustomMaterialBtn(
              btnText: 'Login',
              onPressed: () {
                if (_loginFormKey.currentState.validate()) {
                  var _profile = context.read<ProfileViewModel>();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomLoadingDialog(
                        stream: _profile
                            .signinFunc(
                                _emailController.text, _passwordController.text)
                            .asStream(),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
