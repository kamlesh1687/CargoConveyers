import 'package:flutter/material.dart';

class CustomFlatBtn extends StatelessWidget {
  final String btnText;
  final onPressed;

  const CustomFlatBtn({Key key, this.btnText, this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
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
