import 'package:flutter/material.dart';

class TextFormFieldPassword extends StatefulWidget {
  final controller;
  final String hinttext;

  const TextFormFieldPassword({Key key, this.controller, this.hinttext})
      : super(key: key);

  @override
  _TextFormFieldPasswordState createState() => _TextFormFieldPasswordState();
}

class _TextFormFieldPasswordState extends State<TextFormFieldPassword> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: isObscure,
      validator: (value) {
        if (value.length < 5) {
          return 'Your password is short';
        }
        return null;
      },
      expands: false,
      decoration: InputDecoration(
        suffix: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          child: InkWell(
            child: Icon(
              isObscure ? Icons.visibility : Icons.visibility_off,
              size: 20,
            ),
            onTap: () {
              setState(() {
                if (isObscure) {
                  isObscure = false;
                } else {
                  isObscure = true;
                }
              });
            },
          ),
        ),
        labelText: widget.hinttext,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class TextFormFieldOther extends StatelessWidget {
  final controller;
  final String hinttext;

  const TextFormFieldOther({Key key, this.controller, this.hinttext})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: hinttext,
        border: OutlineInputBorder(),
      ),
    );
  }
}

class TextFormFieldEmail extends StatelessWidget {
  final controller;
  final String hinttext;
  final bool isBordered;

  const TextFormFieldEmail(
      {Key key, this.controller, this.hinttext, this.isBordered})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: hinttext,
        border: isBordered ?? OutlineInputBorder(),
      ),
    );
  }
}

class TextFormFieldProfileEdit extends StatelessWidget {
  final controller;
  final String hintText;
  final String labelText;

  const TextFormFieldProfileEdit(
      {Key key, this.controller, this.hintText, this.labelText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText ?? hintText,
        hintText: hintText,
      ),
    );
  }
}
