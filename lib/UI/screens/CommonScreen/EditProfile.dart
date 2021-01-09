import 'package:cargoconveyers/UI/Helpers/CustomTextFormFields.dart';
import 'package:cargoconveyers/UI/Helpers/SelectableList.dart';

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
                      UserTypeSelect(
                        isEnabled:
                            widget.userProfileData == null ? true : false,
                        isShipper: (isShipper) {
                          context.read<ProfileViewModel>().isServiceProvider =
                              !isShipper;
                          print(isShipper);
                        },
                      ),
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
                                  bool isProvider = _model.isServiceProvider;

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
                                          !isProvider)
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

class UserTypeSelect extends StatefulWidget {
  final Function(bool) isShipper;
  final bool isEnabled;

  const UserTypeSelect({Key key, this.isShipper, this.isEnabled})
      : super(key: key);
  @override
  _UserTypeSelectState createState() => _UserTypeSelectState();
}

class _UserTypeSelectState extends State<UserTypeSelect> {
  List _userTypeList = ['Shipper', 'Transport Contracter'];

  int selectedIndex;

  @override
  void initState() {
    var _data = context.read<ProfileViewModel>();
    if (_data.isServiceProvider != null) {
      if (_data.isServiceProvider) {
        selectedIndex = 1;
      } else {
        selectedIndex = 0;
      }
    } else {
      selectedIndex = null;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.isEnabled ?? true) {
          showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _bottomSheet()),
                  ));
        }
      },
      contentPadding: EdgeInsets.all(0),
      title: Text("Service Provided"),
      subtitle: Text(
        selectedIndex == null
            ? 'Select Your Mode'
            : _userTypeList[selectedIndex],
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _bottomSheet() {
    return SelectableList(
      preselected: selectedIndex,
      scrollDirection: Axis.vertical,
      getSelectedItem: (index) {
        setState(() {
          selectedIndex = index;
        });
        if (index == 0) {
          widget.isShipper(true);
        } else {
          widget.isShipper(false);
        }
      },
      list: _userTypeList,
      builder: (index) {
        List _txtList = [
          'I own the good,looking for transportation services.',
          'I provide Transportation services, I own Lorries'
        ];
        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: CircleAvatar(
            radius: 20,
          ),
          title: Text(_userTypeList[index]),
          subtitle: Text(_txtList[index]),
        );
      },
    );
  }
}

class BottomModalSheet extends StatefulWidget {
  final Function(int) onTap;
  final int selectedIndex;

  const BottomModalSheet({Key key, this.onTap, this.selectedIndex})
      : super(key: key);
  @override
  _BottomModalSheetState createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  bool isServiceProvider = false;
  bool isShipper = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          onTap: () {
            setState(() {
              if (!isServiceProvider) {
                isShipper = false;
                isServiceProvider = true;
              }
            });
          },
          contentPadding: EdgeInsets.all(10),
          tileColor: isServiceProvider ? Theme.of(context).primaryColor : null,
          leading: CircleAvatar(
            radius: 20,
          ),
          title: Text('Transport Contracter'),
          subtitle: Text('I provide Transportation services, I own Lorries'),
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          onTap: () {
            setState(() {
              if (!isShipper) {
                isShipper = true;
                isServiceProvider = false;
              }
            });
          },
          contentPadding: EdgeInsets.all(10),
          tileColor: isShipper ? Theme.of(context).primaryColor : null,
          leading: CircleAvatar(
            radius: 20,
          ),
          title: Text('Shipper'),
          subtitle:
              Text('I own the good,looking for transportation services. '),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text('Cancle'),
              onPressed: () {
                Navigator.pop(context);
              },
              colorBrightness: Brightness.dark,
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text('Done'),
              onPressed: () {
                Provider.of<ProfileViewModel>(context, listen: false)
                    .isServiceProvider = isServiceProvider;

                Navigator.pop(context);
              },
              colorBrightness: Brightness.dark,
            ),
          ],
        )
      ],
    );
  }
}
