import 'package:cargoconveyers/UI/Helpers/CustomTextFormFields.dart';
import 'package:cargoconveyers/UI/Reusable/CustomDialogErrorHandling.dart';
import 'package:cargoconveyers/UI/screens/CommonScreen/EditProfile.dart';
import 'package:cargoconveyers/businessLogics/viewModels/ProfileViewMode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  final Function(bool) formVisible;
  SignupForm({
    Key key,
    this.formVisible,
  }) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Form(
        key: _formKey,
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormFieldOther(
                controller: _emailController,
                hinttext: 'Enter Your Email',
              ),
              const SizedBox(height: 10.0),
              TextFormFieldPassword(
                controller: _passwordController,
                hinttext: "Enter your password",
              ),
              const SizedBox(height: 10.0),
              TextFormFieldPassword(
                controller: _passwordConfirmController,
                hinttext: 'Retenter your password',
              ),
              const SizedBox(height: 10.0),
              MaterialButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text('Signup'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (_passwordController.text ==
                          _passwordConfirmController.text) {
                        var _profile = context.read<ProfileViewModel>();

                        _profile
                            .signupFunc(_emailController.text,
                                _passwordConfirmController.text)
                            .then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(),
                              ));
                        });
                      } else {
                        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //    content: Text('Your password is not matching')));
                      }
                    }
                  }),
            ]),
      ),
    );
  }
}
