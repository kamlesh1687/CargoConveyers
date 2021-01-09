import 'package:cargoconveyers/UI/Helpers/CustomMaterialButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'LogIn.dart';
import 'SignUp.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
         SignUpView();
      
  }
}

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool formVisible;
  int _formsIndex;

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  List<String> imgList = [
    'assets/images/slide1.jpg',
    'assets/images/slide2.jpg',
    'assets/images/slide3.jpg',
    'assets/images/slide4.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height),
                    items: imgList
                        .map((item) => Container(
                              child: Center(
                                  child: Image.asset(
                                item,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              )),
                            ))
                        .toList(),
                  ),
                ),
              ),
              Column(
                children: [
                  Column(
                    children: <Widget>[
                      Text(
                        "Hello there,",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Welcome to Cargo Conveyers. \n You are awesome",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 10.0),
                      Expanded(
                          child: CustomMaterialBtn(
                        btnText: 'Login',
                        onPressed: () {
                          setState(() {
                            formVisible = true;
                            _formsIndex = 1;
                          });
                        },
                      )),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.blueGrey,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text("Signup"),
                          onPressed: () {
                            setState(() {
                              formVisible = true;
                              _formsIndex = 2;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
            ],
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: (!formVisible)
                ? null
                : Container(
                    color: Colors.black54,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              textColor: _formsIndex == 1
                                  ? Colors.white
                                  : Colors.black,
                              color: _formsIndex == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              child: Text("Login"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 1;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            RaisedButton(
                              textColor: _formsIndex == 2
                                  ? Colors.white
                                  : Colors.black,
                              color: _formsIndex == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              child: Text("Signup"),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              onPressed: () {
                                setState(() {
                                  _formsIndex = 2;
                                });
                              },
                            ),
                            const SizedBox(width: 10.0),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  formVisible = false;
                                });
                              },
                            )
                          ],
                        ),
                        Container(
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 300),
                            child: _formsIndex == 1
                                ? LoginForm(
                                    formVisible: (value) {
                                      setState(() {
                                        formVisible = value;
                                      });
                                    },
                                  )
                                : SignupForm(
                                    formVisible: (value) {
                                      setState(() {
                                        formVisible = value;
                                      });
                                    },
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
          )
        ],
      ),
    ));
  }
}
