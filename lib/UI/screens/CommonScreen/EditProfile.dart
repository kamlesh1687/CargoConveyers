import 'package:cargoconveyers/UI/Helpers/CustomTextFormFields.dart';

import 'package:cargoconveyers/businessLogics/models/UserModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/ProfileViewMode.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserModel userProfileData;

  const EditProfile({
    Key key,
    this.userProfileData,
  }) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _editProfileFormKey = GlobalKey<FormState>();
  TextEditingController _controllerCompanyName;
  TextEditingController _controllerUserName;
  TextEditingController _controllerCityname;
  @override
  void initState() {
    _controllerCityname = TextEditingController();
    _controllerCompanyName = TextEditingController();
    _controllerUserName = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 70,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Primary Information',
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
                Form(
                  key: _editProfileFormKey,
                  child: Column(
                    children: [
                      TextFormFieldProfileEdit(
                          controller: _controllerUserName,
                          hintText: 'Enter Your Name',
                          labelText:
                              widget.userProfileData?.userName ?? 'Your Name'),
                      TextFormFieldProfileEdit(
                          controller: _controllerCompanyName,
                          hintText: 'Enter Company Name',
                          labelText: widget.userProfileData?.companyName ??
                              'Company Name'),
                      TextFormFieldProfileEdit(
                        hintText: 'Select Your City',
                        labelText: widget.userProfileData?.city ?? 'City',
                        controller: _controllerCityname,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text('Submit'),
                              onPressed: () {
                                if (_editProfileFormKey.currentState
                                    .validate()) {
                                  var _model = context.read<ProfileViewModel>();

                                  User _user =
                                      FirebaseAuth.instance.currentUser;
                                  _model
                                      .addusermodel(
                                    _user.email,
                                    _user.uid,
                                    _controllerUserName.text,
                                    _controllerCityname.text,
                                    _controllerCompanyName.text,
                                    "Phone number",
                                  )
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
