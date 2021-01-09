import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'AuthScreen.dart';
import 'UserType.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print('test');
            if (snapshot.hasData && snapshot.data.uid != null) {
              return UserTypeCheck(
                userId: snapshot.data.uid,
              );
            }
            return AuthScreen();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
