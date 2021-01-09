import 'package:flutter/material.dart';

class CustomMaterialBtn extends StatelessWidget {
  final String btnText;
  final onPressed;

  const CustomMaterialBtn({Key key, this.btnText, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(btnText),
      onPressed: onPressed,
    );
  }
}
