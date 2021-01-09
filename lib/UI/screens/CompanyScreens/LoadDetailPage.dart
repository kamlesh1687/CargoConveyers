import 'package:cargoconveyers/UI/Helpers/CustomFlatButton.dart';
import 'package:cargoconveyers/UI/Helpers/constants.dart';
import 'package:cargoconveyers/businessLogics/models/LoadModel.dart';
import 'package:cargoconveyers/businessLogics/models/UserModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/ProfileViewMode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoadDetailPage extends StatefulWidget {
  final LoadModel loadModel;

  const LoadDetailPage({Key key, this.loadModel}) : super(key: key);
  @override
  _LoadDetailPageState createState() => _LoadDetailPageState();
}

class _LoadDetailPageState extends State<LoadDetailPage> {
  bool isloading = true;
  UserModel _userModel;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await Provider.of<ProfileViewModel>(context, listen: false)
        .getLoadUserData(widget.loadModel.ownerId)
        .then((value) {
      setState(() {
        _userModel = value;
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (isloading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Load Details"),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              child: Icon(FontAwesomeIcons.user),
            ),
            title: Text(
              _userModel.companyName,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            subtitle: Text(_userModel.city),
          ),
          ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(
                FontAwesomeIcons.route,
                color: Colors.deepOrange,
              ),
              title: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Ubuntu'),
                    children: [
                      TextSpan(text: widget.loadModel.from),
                      TextSpan(text: ' - '),
                      TextSpan(text: widget.loadModel.to),
                    ]),
              ),
              isThreeLine: true,
              subtitle: RichText(
                maxLines: 2,
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.grey, fontSize: 16, fontFamily: 'Ubuntu'),
                    text: 'Material:',
                    children: [
                      TextSpan(text: widget.loadModel.goodDetail),
                      TextSpan(text: ', '),
                      TextSpan(
                        text: 'Quantity:',
                      ),
                      TextSpan(text: widget.loadModel.capacity),
                      TextSpan(text: ', '),
                      TextSpan(
                        text: 'Lorry Type:',
                      ),
                      TextSpan(text: widget.loadModel.payMode),
                    ]),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(DateFormat().format(widget.loadModel.posTime.toDate())),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
                color: Colors.blue.shade50,
                shape:
                    RoundedRectangleBorder(borderRadius: varProp.borderRadius),
                child: Container(
                  height: size.height * 0.45,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Send Message To ${_userModel.companyName}',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: varProp.borderRadius,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            expands: true,
                            maxLines: null,
                            minLines: null,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Your Message (Optional)'),
                          ),
                        ),
                        width: size.width - 80,
                        height: size.height * 0.25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: varProp.borderRadius,
                          color: Colors.white,
                        ),
                        width: size.width - 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your New Price'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomFlatBtn(
                    btnText: 'Place A Bid',
                    onPressed: () {},
                  )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
