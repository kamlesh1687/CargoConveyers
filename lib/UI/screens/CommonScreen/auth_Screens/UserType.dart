import 'package:cargoconveyers/UI/screens/CommonScreen/HomePage/HomePage.dart';
import 'package:cargoconveyers/businessLogics/viewModels/MarketViewModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/ProfileViewMode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class UserTypeCheck extends StatefulWidget {
  final String userId;
  const UserTypeCheck({
    Key key,
    @required this.userId,
  }) : super(key: key);

  @override
  _UserTypeCheckState createState() => _UserTypeCheckState();
}

class _UserTypeCheckState extends State<UserTypeCheck> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (_, _profile, __) {
        print('building');
        if (_profile.isNewUser != null && !_profile.isNewUser) {
          _profile.getProfileDetails(widget.userId);
        }
        if (_profile.userData != null) {
          print("userData !=null");

          if (_profile.isNewUser != null) {
            context
                .read<MarketViewModel>()
                .getMyLoads(_profile.userData.userId)
                .then((value) {
              _profile.isNewUser = null;
            });
          }
          return HomePage(
            isServiceProvider: false,
            userId: widget.userId,
          );
        }

        print("userData ==null");
        return Scaffold(
          body: Center(
            child: SpinKitThreeBounce(
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }
}
