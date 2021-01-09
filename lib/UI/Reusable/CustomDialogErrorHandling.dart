import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingDialog extends StatelessWidget {
  final Stream stream;

  const CustomLoadingDialog({Key key, @required this.stream}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot) {
        var _size = MediaQuery.of(context).size;

        if (snapshot.data != null) {
          if (snapshot.data != "Done") {
            String error;
            if (snapshot.data.contains('invalid-email')) {
              error = 'The email address is badly formatted.';
            }
            if (snapshot.data.contains('wrong-password')) {
              error = 'The password is invalid.';
            }
            return Center(
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black54,
                              spreadRadius: 1)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    curve: Curves.elasticIn,
                    height: _size.height * 0.15,
                    width: _size.width * 0.7,
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                      error ?? snapshot.data,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: TextButton(
                      child: Text('Try Again'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            Navigator.pop(context);
          }
        }
        return Center(
          child: Container(
            child: SpinKitThreeBounce(color: Theme.of(context).primaryColor),
          ),
        );
      },
    );
  }
}
